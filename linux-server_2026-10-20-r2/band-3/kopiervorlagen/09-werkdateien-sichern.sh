#!/bin/bash
set -euo pipefail
umask 077
if (( EUID != 0 )); then
    echo 'Bitte mit sudo aufrufen.' >&2
    exit 1
fi
modus="${1:-normal}"
case "$modus" in
    normal|--probe-fehler|--abschluss) ;;
    *) echo 'Erlaubt: ohne Argument, --probe-fehler, --abschluss' >&2; exit 2 ;;
esac
exec 8>/run/lock/werkdateien-sicherung.lock
if ! /usr/bin/flock -n 8; then
    echo 'Ein anderer Sicherungslauf ist noch aktiv.' >&2
    exit 75
fi
marker=/run/werkdateien-smbd-neustart
bestand=/var/lib/werkdateien-sicherung
restic=/usr/local/sbin/werkdateien-restic
lauf="${INVOCATION_ID:-$(cat /proc/sys/kernel/random/uuid)}"
if [[ "$modus" == --abschluss && -n "${2:-}" ]]; then
    lauf="$2"
fi

wiederanlauf() {
    if [[ -e "$marker" ]]; then
        read -r marker_lauf < "$marker" || return 1
        if [[ "$marker_lauf" != "$lauf" ]]; then
            echo 'Ein alter Wiederanlaufmarker braucht eine bewusste Entscheidung.' >&2
            return 1
        fi
        /usr/local/sbin/werkdateien-mount-pruefen || return 1
        /usr/bin/systemctl start smbd.service || return 1
        /usr/bin/systemctl is-active --quiet smbd.service || return 1
        rm -- "$marker" || return 1
    fi
}

if [[ "$modus" == --abschluss ]]; then
    wiederanlauf
    exit 0
fi

source /etc/werkdateien-sicherung.env
: "${HC_PING_URL:?Pingadresse fehlt}"
if [[ ! "$HC_PING_URL" =~ ^https://[A-Za-z0-9./_-]+$ ]]; then
    echo 'Unerwartete Form der HTTPS-Pingadresse.' >&2
    exit 2
fi
melden() {
    printf 'url = "%s%s"\n' "$HC_PING_URL" "$1" |
        /usr/bin/curl --config - --fail --silent --show-error \
        --output /dev/null --connect-timeout 10 --max-time 30
}
abschluss() {
    ergebnis=$?
    trap - EXIT INT TERM
    if ! wiederanlauf; then
        echo 'Samba konnte nicht in den vorherigen Zustand zurueckkehren.' >&2
        ergebnis=1
    fi
    if (( ergebnis != 0 )); then
        melden /fail || true
    fi
    exit "$ergebnis"
}
trap abschluss EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

if [[ -e "$marker" ]]; then
    echo 'Unerledigter frueherer Lauf; keine neue automatische Dienstaktion.' >&2
    exit 1
fi
/usr/local/sbin/werkdateien-mount-pruefen
melden /start || echo 'Startmeldung nicht angekommen; Sicherung wird versucht.' >&2
"$restic" snapshots >/dev/null
zustand=$(/usr/bin/systemctl is-active smbd.service || true)
case "$zustand" in
    active) printf '%s\n' "$lauf" > "$marker" ;;
    inactive|failed) ;;
    *) echo "Ungeklaerter Samba-Zustand: $zustand" >&2; exit 1 ;;
esac
/usr/bin/systemctl stop smbd.service
if /usr/bin/pgrep -x smbd >/dev/null; then
    echo 'Es ist noch ein smbd-Prozess vorhanden.' >&2
    exit 1
fi
if [[ "$modus" == --probe-fehler ]]; then
    echo 'Beabsichtigte Fehlerprobe nach dem Dienststopp.' >&2
    exit 42
fi

install -d -o root -g root -m 700 "$bestand"
getent passwd datei01 datei02 > "$bestand/passwd.txt"
getent group werkdateien werkpflege > "$bestand/group.txt"
{ id datei01; id datei02; } > "$bestand/mitgliedschaften.txt"
net getlocalsid > "$bestand/server-sid.txt"
pdbedit -L -v > "$bestand/samba-konten.txt"
getfacl -R -p -n /srv/werkdateien > "$bestand/acl.txt"
findmnt -rn -o SOURCE,UUID,FSTYPE,OPTIONS --mountpoint /srv/werkdateien > "$bestand/mount.txt"
cp -- /etc/fstab "$bestand/fstab.txt"
repquota -u -n /srv/werkdateien > "$bestand/quoten.txt"
dpkg-query -W -f='${Package}\t${Version}\n' samba restic acl attr quota e2fsprogs > "$bestand/pakete.txt"
date --iso-8601=seconds > "$bestand/stand.txt"

quellen=(
    /srv/werkdateien
    /etc/samba
    /var/lib/samba
    /etc/werkdateien.uuid
    /etc/werkdateien-quoten.tsv
    /etc/werkdateien-sicherung.env
    /root/werkdateien-backup
    /var/lib/werkdateien-sicherung
    /etc/systemd/system/smbd.service.d
    /etc/systemd/system/werkdateien-sicherung.service
    /etc/systemd/system/werkdateien-sicherung.timer
    /usr/local/sbin/werkdateien-mount-pruefen
    /usr/local/sbin/werkdateien-restic
    /usr/local/sbin/werkdateien-sichern
    /etc/nftables.conf
    /etc/fstab
    /etc/hostname
    /etc/hosts
)
for pfad in "${quellen[@]}"; do
    [[ -e "$pfad" ]] || { echo "Sicherungsquelle fehlt: $pfad" >&2; exit 1; }
done
if [[ -d /etc/systemd/system/tailscaled.service.d ]]; then
    quellen+=(/etc/systemd/system/tailscaled.service.d)
fi
"$restic" backup --tag werkdateien --one-file-system "${quellen[@]}"
wiederanlauf
"$restic" check
melden ''
echo 'Dateibestand extern gesichert, Dienstzustand wiederhergestellt, Struktur geprueft.'
