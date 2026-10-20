#!/bin/bash
set -euo pipefail
umask 077

mailhost=mail.post.example.org
lineage=/etc/letsencrypt/live/$mailhost
test "${RENEWED_LINEAGE:-}" = "$lineage"

openssl x509 -in "$lineage/cert.pem" -noout \
  -checkhost "$mailhost" >/dev/null
openssl x509 -in "$lineage/cert.pem" -noout -checkend 604800 >/dev/null
openssl verify -CAfile /etc/ssl/certs/ca-certificates.crt \
  -untrusted "$lineage/chain.pem" "$lineage/cert.pem" >/dev/null

certkey=$(openssl x509 -in "$lineage/cert.pem" -pubkey -noout |
  openssl pkey -pubin -outform DER | sha256sum | cut -d ' ' -f 1)
privkey=$(openssl pkey -in "$lineage/privkey.pem" -pubout -outform DER |
  sha256sum | cut -d ' ' -f 1)
test "$certkey" = "$privkey"

neu=$(mktemp /etc/postfix/tls/.mail.pem.XXXXXX)
trap 'rm -f "$neu"' EXIT
cat "$lineage/privkey.pem" "$lineage/fullchain.pem" > "$neu"
chmod 600 "$neu"
chown root:root "$neu"

doveconf -n >/dev/null
postfix check
if [ -f /etc/postfix/tls/mail.pem ]; then
  vergleich=0
  cmp -s /etc/postfix/tls/mail.pem "$neu" || vergleich=$?
  case "$vergleich" in
    0) ;;
    1) cp -p /etc/postfix/tls/mail.pem /etc/postfix/tls/mail.pem.vorher ;;
    *) printf 'PEM-Vergleich fehlgeschlagen.\n' >&2; exit "$vergleich" ;;
  esac
fi
mv -f "$neu" /etc/postfix/tls/mail.pem

if systemctl is-active --quiet dovecot.service; then
  systemctl reload dovecot.service
fi
if systemctl is-active --quiet postfix.service; then
  systemctl reload postfix.service
fi
logger -t werkpost-tls 'Geprueftes Zertifikat uebernommen; Endpunktkontrolle bleibt erforderlich.'
