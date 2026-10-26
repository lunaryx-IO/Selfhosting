# Kopiervorlagen zu Band 3

Diese zwölf Dateien ersparen Ihnen das Abtippen längerer Programme und Ausgangskonfigurationen. Lesen Sie zuerst den genannten Abschnitt im Buch. Dort finden Sie Vorbereitung, eigene Werte, Rechte, Prüfschritte und Rückweg. Die vollständigen Listings bleiben auch im Buch erhalten.

Öffnen Sie die gewünschte Datei im Texteditor. Jede Vorlage gehört zu einer bestimmten Ausbaustufe; insbesondere ersetzen die ersten lokalen Mailkonfigurationen keine später ergänzte Einrichtung. Die Dateien werden durch das Entpacken weder installiert noch gestartet.

| Datei | Stelle im Buch | Ziel nach Anleitung |
|---|---|---|
| [02-filter-heim.nft](02-filter-heim.nft) | Kapitel 2, 4. Eine gemeinsame, begrenzte Hostfilterbasis einrichten | `/root/werkserver-aufbau/filter.neu.nft` |
| [03-smb.conf](03-smb.conf) | Kapitel 3, 4. Die Freigabe beschreiben | `/etc/samba/smb.conf` |
| [09-werkdateien-sichern.sh](09-werkdateien-sichern.sh) | Kapitel 9, 5. Die Ruhephase und den Wiederanlauf zusammenhalten | `/usr/local/sbin/werkdateien-sichern` |
| [13-dovecot-lokal.conf](13-dovecot-lokal.conf) | Kapitel 13, 3. Dovecot den lokalen Zustellweg erklären | `/etc/dovecot/dovecot.conf` |
| [13-postfix-lokal.cf](13-postfix-lokal.cf) | Kapitel 13, 4. Postfix nur bekannte Empfänger annehmen lassen | `/etc/postfix/main.cf` |
| [14-werkpost-zertifikat.sh](14-werkpost-zertifikat.sh) | Kapitel 14, 3. Ausgabe und Erneuerung in einen begrenzten Ablauf fassen | `/usr/local/sbin/werkpost-zertifikat` |
| [14-50-werkpost.sh](14-50-werkpost.sh) | Kapitel 14, 4. Das Zertifikat kontrolliert an die Dienste übergeben | `/etc/letsencrypt/renewal-hooks/deploy/50-werkpost` |
| [16-werkpost-sicherung-abschluss.sh](16-werkpost-sicherung-abschluss.sh) | Kapitel 16, 5. Den Wiederstart auch nach einem Fehler regeln | `/usr/local/sbin/werkpost-sicherung-abschluss` |
| [16-werkpost-sichern.sh](16-werkpost-sichern.sh) | Kapitel 16, 6. Den vollständigen Sicherungslauf schreiben | `/usr/local/sbin/werkpost-sichern` |
| [16-werkpost-restore-rechte.py](16-werkpost-restore-rechte.py) | Kapitel 16, Paketidentitäten auf dem Ersatz zuordnen | `/usr/local/sbin/werkpost-restore-rechte` |
| [17-rspamd.local.lua](17-rspamd.local.lua) | Kapitel 17, 4. Den sichtbaren Absender mit der Sendeerlaubnis verbinden | `/etc/rspamd/rspamd.local.lua` |
| [18-werkpost-beobachten.sh](18-werkpost-beobachten.sh) | Kapitel 18, 6. Den öffentlichen Stand regelmäßig und unabhängig beobachten | `/usr/local/sbin/werkpost-beobachten` |

## 02-filter-heim.nft

Heimvariante; Schnittstelle, Netz und Verwaltungsadresse wie in Kapitel 2 anpassen. Für den VPS die dort erklärten Änderungen übernehmen.

## 03-smb.conf

Erste geschützte Freigabe. Sie setzt den begrenzten Netzweg aus Kapitel 2 voraus; die späteren Speicher- und Rechteergänzungen folgen im Buch.

## 09-werkdateien-sichern.sh

Erst nach der Speicher-, Restic- und Geheimnisvorbereitung dieses Kapitels. Die zugehörige Diensteinrichtung bleibt Teil der Anleitung.

## 13-dovecot-lokal.conf

Nur die erste lokale Zustellstufe. Domain, Benutzerzuordnung und Datenträger vorbereiten; spätere IMAP-/TLS-Ergänzungen nicht damit überschreiben.

## 13-postfix-lokal.cf

Nur die erste lokale Zustellstufe. Eigene Namen und Empfängertabellen einsetzen; kein vollständiger öffentlicher Mailserver.

## 14-werkpost-zertifikat.sh

Echten Mailhost und die geschützte TLS-Umgebung aus Kapitel 14 verwenden. Ausgabe, Erneuerung und Probe sind getrennte Aufrufe.

## 14-50-werkpost.sh

Übernahme des Zertifikats erst nach Erstausgabe und Zielvorbereitung. Mailhost muss zu Zertifikatsroutine und Diensten passen.

## 16-werkpost-sicherung-abschluss.sh

Abschluss der Mailsicherung aus Kapitel 16. Gemeinsam mit der Hauptroutine und der dortigen Unit einrichten. Eine alte Unterbrechung zuerst zuordnen. Bei einem Wiederstartfehler bleibt die offene Laufmarkierung erhalten; ein reiner Meldefehler hält einen bereits abgeschlossenen Wiederstart nicht offen.

## 16-werkpost-sichern.sh

Basisstufe aus Kapitel 16 mit MAIL_FILTER=no. Speicher, Ziele, Geheimnisse und Abschlussroutine vorher einrichten. Kapitel 17 ergänzt vor der Pause die Rspamd-Prüfung, die Filterquellen und die Dienstfolge für Redis/Rspamd; Kapitel 18 ergänzt die Beobachtungsdateien. Diese Basisvorlage ersetzt keine bereits so erweiterte Sicherung.

## 16-werkpost-restore-rechte.py

Nur im beschriebenen Wiederaufbau auf dem leeren Ersatz. Paketidentitäten und Datenträger vorher vergleichen.

## 17-rspamd.local.lua

Eigene Absenderzuordnung zusammen mit den im Kapitel gezeigten Rspamd-Dateien und Prüfungen einrichten.

## 18-werkpost-beobachten.sh

Beobachtung des öffentlichen Stands. Geschützte Meldedaten, Prüfziele und Zeitgeber wie in Kapitel 18 vorbereiten.

[Zur Materialübersicht](../README.md) · Die [Fassungszuordnung](../VERSION.md) unterscheidet den Textabgleich von einer praktischen Prüfung.
