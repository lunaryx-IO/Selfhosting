#!/bin/bash
set -euo pipefail
umask 077
test "$(id -u)" -eq 0
exec 9>/run/lock/werkpost.lock
if ! flock -n 9; then exit 0; fi
set -a
. /etc/werkpost-beobachtung.env
. /etc/werkpost-redis.env
set +a

abschluss() {
  local rc=$?
  trap - EXIT
  local ende=/fail
  if [ "$rc" -eq 0 ]; then ende=; fi
  printf 'url = "%s%s"\n' "$BETRIEB_PING_URL" "$ende" |
    curl --config - --fail --silent --show-error \
      --max-time 20 --retry 2 --output /dev/null || rc=1
  exit "$rc"
}
trap abschluss EXIT
/usr/local/sbin/werkpost-speicher-pruefen
for dienst in postfix.service dovecot.service rspamd.service redis-server.service; do
  systemctl is-active --quiet "$dienst"
done
test "$(redis-cli -h 127.0.0.1 --raw PING)" = PONG
unset REDISCLI_AUTH

python3 - <<'PY'
import os
import socket
import ssl
import time
v = os.statvfs("/srv/mail")
if not v.f_blocks or v.f_bavail / v.f_blocks < 0.10:
    raise SystemExit("Weniger als zehn Prozent freier Mailplatz")
if v.f_files and v.f_favail / v.f_files < 0.10:
    raise SystemExit("Weniger als zehn Prozent freie Mail-Inodes")
host = os.environ["MAILHOST"]
ctx = ssl.create_default_context()
with socket.create_connection(("127.0.0.1", 993), timeout=10) as sock:
    with ctx.wrap_socket(sock, server_hostname=host) as tls:
        expires = ssl.cert_time_to_seconds(tls.getpeercert()["notAfter"])
        if expires - time.time() < 14 * 86400:
            raise SystemExit("Angebotenes IMAP-Zertifikat bald abgelaufen")
PY

postqueue -j | jq -se --argjson jetzt "$(date +%s)" \
  'length <= 100 and all(.[]; ($jetzt - .arrival_time) < 7200)' >/dev/null
