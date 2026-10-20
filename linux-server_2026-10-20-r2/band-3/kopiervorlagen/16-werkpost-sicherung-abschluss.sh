#!/bin/bash
set -uo pipefail
umask 077
test "$(id -u)" -eq 0 || exit 1
modus=${1:-finish}
if [ "${WERKPOST_LOCK_GEHALTEN:-no}" != yes ]; then
  exec 9>/run/lock/werkpost.lock
  flock -w 300 9 || exit 1
fi

zustand=/var/lib/werkpost-lauf
test -d "$zustand" || exit 0
kennung=${WERKPOST_RUN_ID:-${INVOCATION_ID:-}}
test -n "$kennung" || exit 1
test "$kennung" = "$(cat "$zustand/kennung")" || exit 1
rc=0

if [ -f "$zustand/main.cf" ]; then
  if cp -a "$zustand/main.cf" /etc/postfix/main.cf; then
    rm -f "$zustand/main.cf"
  else
    rc=1
  fi
fi

if ! /usr/local/sbin/werkpost-speicher-pruefen; then rc=1; fi
if ! doveconf -n >/dev/null; then rc=1; fi
if ! postfix check; then rc=1; fi

if [ "$rc" -eq 0 ]; then
  for dienst in redis-server.service rspamd.service dovecot.service postfix.service; do
    if grep -Fxq "$dienst" "$zustand/aktiv"; then
      if systemctl start "$dienst" &&
          systemctl is-active --quiet "$dienst"; then
        sed "\|^$dienst$|d" "$zustand/aktiv" > "$zustand/aktiv.neu"
        mv "$zustand/aktiv.neu" "$zustand/aktiv"
      else
        rc=1
        break
      fi
    fi
  done
fi

if [ "$modus" = resume ]; then exit "$rc"; fi
. /etc/werkpost-sicherung.env || exit 1
ergebnis=${WERKPOST_RESULT:-${SERVICE_RESULT:-failure}}
ende=/fail
if [ "$rc" -eq 0 ] && { [ "$ergebnis" = 0 ] || [ "$ergebnis" = success ]; }; then
  ende=
fi
if ! printf 'url = "%s%s"\n' "$BACKUP_PING_URL" "$ende" |
    curl --config - --fail --silent --show-error \
      --max-time 20 --retry 2 --output /dev/null; then
  rc=1
fi
if [ "$rc" -eq 0 ]; then
  rm -f "$zustand/aktiv" "$zustand/kennung"
  rmdir "$zustand" || rc=1
fi
[ "$ende" = "" ] || rc=1
exit "$rc"
