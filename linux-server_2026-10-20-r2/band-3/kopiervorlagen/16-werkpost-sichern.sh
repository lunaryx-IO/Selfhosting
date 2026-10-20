#!/bin/bash
set -euo pipefail
umask 077
test "$(id -u)" -eq 0
exec 9>/run/lock/werkpost.lock
flock -w 300 9
set -a
. /etc/werkpost-sicherung.env
set +a

zustand=/var/lib/werkpost-lauf
test ! -e "$zustand"
test "$MAIL_FILTER" = no
/usr/local/sbin/werkpost-speicher-pruefen
test "$(systemctl show postfix.service -p KillMode --value)" = control-group

quellen=(
  /srv/mail /etc/dovecot /etc/postfix /etc/aliases /etc/aliases.db
  /etc/letsencrypt /var/spool/postfix /var/lib/postfix /var/lib/dovecot
  /etc/fstab /etc/nftables.conf /etc/werkpost-speicher.uuid
  /etc/werkpost-tls.env /etc/werkpost-sicherung.env
  /etc/systemd/system /root/.ssh /root/werkpost-backup
  /usr/local/sbin/werkpost-speicher-pruefen
  /usr/local/sbin/werkpost-zertifikat
  /usr/local/sbin/werkpost-restic
  /usr/local/sbin/werkpost-sichern
  /usr/local/sbin/werkpost-sicherung-abschluss
  /var/lib/werkpost-sicherung
)
for pfad in "${quellen[@]}"; do
  test -e "$pfad" || { printf 'Pflichtquelle fehlt: %s\n' "$pfad" >&2; exit 1; }
done
restic -r "$LOCAL_REPOSITORY" --password-file "$LOCAL_PASSWORD_FILE" snapshots >/dev/null
restic snapshots >/dev/null

install -d -o root -g root -m 700 "$zustand"
WERKPOST_RUN_ID=${INVOCATION_ID:-manual-$$}
export WERKPOST_RUN_ID
printf '%s\n' "$WERKPOST_RUN_ID" > "$zustand/kennung"
: > "$zustand/aktiv"
abschluss() {
  local code=$?
  trap - EXIT
  WERKPOST_LOCK_GEHALTEN=yes WERKPOST_RESULT="$code" \
    /usr/local/sbin/werkpost-sicherung-abschluss finish || code=1
  exit "$code"
}
trap abschluss EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

printf 'url = "%s/start"\n' "$BACKUP_PING_URL" |
  curl --config - --fail --silent --show-error \
    --max-time 20 --retry 2 --output /dev/null

dienste=(postfix.service dovecot.service)
for dienst in "${dienste[@]}"; do
  if systemctl is-active --quiet "$dienst"; then
    printf '%s\n' "$dienst" >> "$zustand/aktiv"
  fi
done
cp -a /etc/postfix/main.cf "$zustand/main.cf"
cp -a /etc/postfix/main.cf /var/lib/werkpost-sicherung/main.cf.vor-schnitt
dpkg-query -W > /var/lib/werkpost-sicherung/pakete.txt
getent passwd vmail > /var/lib/werkpost-sicherung/vmail-passwd.txt
getent group vmail > /var/lib/werkpost-sicherung/vmail-group.txt
getent passwd > /var/lib/werkpost-sicherung/systemkonten.txt
getent group > /var/lib/werkpost-sicherung/systemgruppen.txt
findmnt -rn -M /srv/mail -o TARGET,SOURCE,FSTYPE,UUID,OPTIONS \
  > /var/lib/werkpost-sicherung/mailmount.txt
date -u +%FT%TZ > /var/lib/werkpost-sicherung/beginn.txt
cp "$zustand/aktiv" /var/lib/werkpost-sicherung/dienste-vorher.txt

postconf -e 'authorized_submit_users ='
if pgrep -x 'sendmail|postdrop' >/dev/null; then
  printf 'Eine lokale Einlieferung arbeitet noch.\n' >&2
  exit 1
fi
for dienst in "${dienste[@]}"; do
  systemctl stop "$dienst"
  test "$(systemctl show "$dienst" -p ActiveState --value)" = inactive
  test "$(systemctl show "$dienst" -p Result --value)" = success
done
date -u +%FT%TZ > /var/lib/werkpost-sicherung/ruhend.txt

restic -r "$LOCAL_REPOSITORY" --password-file "$LOCAL_PASSWORD_FILE" \
  backup --json --tag werkpost-ruhend \
  --exclude /var/lib/werkpost-sicherung/lauf.json.neu \
  --exclude /var/lib/werkpost-sicherung/lauf.json "${quellen[@]}" \
  > /var/lib/werkpost-sicherung/lauf.json.neu
snapshot=$(jq -er 'select(.message_type == "summary") | .snapshot_id' \
  /var/lib/werkpost-sicherung/lauf.json.neu)
test -n "$snapshot"

WERKPOST_LOCK_GEHALTEN=yes \
  /usr/local/sbin/werkpost-sicherung-abschluss resume
mv /var/lib/werkpost-sicherung/lauf.json.neu /var/lib/werkpost-sicherung/lauf.json

restic copy --from-repo "$LOCAL_REPOSITORY" \
  --from-password-file "$LOCAL_PASSWORD_FILE" "$snapshot"
restic check
lokal=$(restic -r "$LOCAL_REPOSITORY" --password-file "$LOCAL_PASSWORD_FILE" \
  snapshots --json "$snapshot")
original=$(jq -er 'if length == 1 then (.[0].original // .[0].id)
  else error("Snapshot nicht eindeutig") end' <<< "$lokal")
extern=$(restic snapshots --json)
extern_id=$(jq -er --arg id "$original" \
  '[.[] | select(.id == $id or .original == $id)] |
   if length == 1 then .[0].id else error("Externe Zuordnung nicht eindeutig") end' \
  <<< "$extern")
printf '%s\n' "$extern_id" > /var/lib/werkpost-sicherung/letzter-extern.txt
date -u +%FT%TZ > /var/lib/werkpost-sicherung/extern-fertig.txt
