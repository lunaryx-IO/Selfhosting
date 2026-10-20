#!/bin/bash
set -euo pipefail
umask 077

test "$(id -u)" -eq 0
exec 9>/run/lock/werkpost.lock
flock -w 300 9
. /etc/werkpost-tls.env

mailhost=mail.post.example.org
modus=${1:-renew}
case "$modus" in
  issue|renew|test) ;;
  *) printf 'Aufruf: werkpost-zertifikat issue|renew|test\n' >&2; exit 2 ;;
esac
case "$TLS_PING_URL" in
  https://hc-ping.com/*) ;;
  *) exit 2 ;;
esac

melden() {
  local ende=$1
  printf 'url = "%s%s"\n' "$TLS_PING_URL" "$ende" |
    curl --config - --fail --silent --show-error \
      --max-time 20 --retry 2 --output /dev/null
}
abschluss() {
  local rc=$?
  trap - EXIT
  if ! nft flush set inet werkserver acme_ports; then rc=1; fi
  if [ "$rc" -eq 0 ]; then
    melden "" || rc=1
  else
    melden "/fail" || true
  fi
  exit "$rc"
}
trap abschluss EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

melden "/start"
nft flush set inet werkserver acme_ports
nft add element inet werkserver acme_ports '{ 80 timeout 15m }'

case "$modus" in
  issue)
    timeout --signal=TERM --kill-after=30s 12m \
      certbot certonly --standalone --non-interactive \
      --agree-tos --email "$ACME_CONTACT" \
      --cert-name "$mailhost" -d "$mailhost"
    ;;
  renew)
    timeout --signal=TERM --kill-after=30s 12m \
      certbot renew --cert-name "$mailhost" --quiet
    ;;
  test)
    timeout --signal=TERM --kill-after=30s 12m \
      certbot renew --cert-name "$mailhost" \
      --dry-run --run-deploy-hooks
    ;;
esac
if [ "$modus" != issue ]; then
  test -x /etc/letsencrypt/renewal-hooks/deploy/50-werkpost
  RENEWED_LINEAGE="/etc/letsencrypt/live/$mailhost" \
    /etc/letsencrypt/renewal-hooks/deploy/50-werkpost
fi
