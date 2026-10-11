# Anwendungen und zusammengehörige Daten

**Beobachtungszeitraum:** Oktober 2026, ergänzt bis 11. Oktober; Berichtsfassung 12. Oktober 2026.  
**Bezug:** Band 2: native Anwendung, Containerprojekte, Datenbanken, CMS, Terminverwaltung, Versand, Browserschutz und Rückwege.

## Der untersuchte Aufbau

Native Kanboard-Anwendung sowie getrennte und kombinierte Rootless-Containerprojekte mit WordPress und Easy!Appointments. Die Versuche verwendeten erfundene Konten, Aufgaben, Beiträge, Bilder, Anlagen und Termine. Bekannte Daten, Rollen, HTTP-Antworten und Datei-/Eigentümer-/Moduswerte wurden vor und nach der Änderung verglichen. Echte Browserproben ergänzten die technischen Abrufe und Datenbankkontrollen.

## Bestandene begrenzte Versuche

| Versuch | Tatsächlich beobachtet |
|---|---|
| Leeres Rückholziel | Inhalte auf frischen Linux-Systemen beziehungsweise in einer neuen Containerengine unabhängig zurückgeholt; Dateien, Rechte, SQL-Daten und bekannte Anwendungsinhalte zugeordnet. |
| Rollen und Sitzungen | Vorgesehene Rollen, Sitzungsende, Uploads, CSRF und Schutz interner Pfade geprüft. |
| Kanboard-Update und Rückweg | 1.2.30 / Schema 127 → 1.2.54 / Schema 128; bekannte Aufgabe, Kommentar und Anlage erhalten, neue Aufgabe gespeichert. Unabhängiger Vorherstand tatsächlich zurückgeholt; neuer Stand separat erhalten. |
| Termin-App-Update und Rückweg | Easy!Appointments 1.5.2 / Schema 60 → 1.6.0 / Schema 69; Migration, alte und neue Buchung geprüft. Unabhängiger Rückweg auf 1.5.2 ausgeführt. |
| WordPress-Update und Rückweg | 7.0.6 → 7.1.2 und zurück; Beiträge und Anlage zugeordnet. Datenbankschema blieb 61833; eine tatsächliche Schemaänderung wird deshalb nicht behauptet. |
| PHP-Patchwechsel | 8.3.33 → 8.3.35 → 8.3.33 bei unverändertem Easy!Appointments 1.6.0 / Schema 69. Neue Buchung beim reinen Imagerückweg erhalten. |
| Browserwirkung | CSP-/Einbettungsproben, gespeichertes HSTS im Windows-Chrome und dessen wirksame Rücknahme über gültiges HTTPS geprüft. |
| Echte E-Mails | Terminversand über SMTP2GO und Journalversand über das offizielle Plugin am externen eigenen Empfänger angekommen; SPF/DKIM/DMARC jeweils PASS. |
| Versandfehler und Passwortlink | Buchung bei gezielter Versandsperre erhalten, positive Rückkehr; Journal-Passwortlink einmal wirksam, Administrator und neue Daten erhalten. |
| Öffentlicher Anwendungsumzug | Journal und Termin-App zwischen zwei VPS-Standorten vor und nach neuen Inhalten/Buchung gewechselt; Rückwege, Zielneustart, HTTPS, IPv4/IPv6 und tatsächliche Browseransicht geprüft. |
| CAPTCHA | Negative Gegenprobe und später persönlich abgeschlossene positive Buchung geprüft. Genau ein neuer Termin, alle 15 vorherigen Termine erhalten. |

## Doppelbuchungen: ursprünglicher Fehler und korrigierter Buchumfang

Die ursprüngliche parallele Easy!Appointments-1.6.0-Rezeptur erzeugte in zwei Reihen mit jeweils 20 kontrolliert überlappenden Paaren Doppelbuchungen. Dieser Fehlschlag bleibt ein tatsächlicher Befund. Ein eigener interner Programmkandidat ist kein Bestandteil der Buchbeilage und keine Herstellerkorrektur.

Die korrigierte Buchkonfiguration betreibt **genau eine prefork/mod_php-App mit `ServerLimit 1` und `MaxRequestWorkers 1`**. Sie bestand 20 gültige überlappende Paare vor und weitere 20 nach unabhängiger Wiederherstellung: jeweils eine Buchung und eine Konfliktablehnung. Voraussetzungen sind ausgeschaltete zusätzliche API-/Kalenderschreibwege und keine erzwungenen Verwaltungsüberschneidungen.

Mehrere Instanzen und nebenläufige Integrationen sind nicht davon erfasst. Lange Anfragen können die übrigen Zugriffe verzögern. Die [Termin-Prüfvorlage BL08](../band-2/BL08_terminreferenz_abnahme.md) beschreibt die genaue Abnahmeaufgabe; aus den 40 Paaren folgt keine statistische Sicherheitsgarantie.

## Verbleibende Herstellergrenze bei Kalendern

Die Anzeige „Vienna (+1:00)“ war für einen Sommerzeittermin falsch; `VTIMEZONE` enthielt unpassende Umstellungsregeln. Die konkreten Ereigniszeiten lagen richtig in UTC vor. Zwei lokale Apple-Kalender-Importe zeigten 09:00–09:30 korrekt: die unveränderten ursprünglichen Sommerzeitfelder und eine synthetische Winterkontrolle.

Diese Gegenproben reparieren den Herstellerfehler nicht. Empfänger und Alarme waren entfernt. Vollständige Einladungs-, Serien- und Mehrclientprüfungen sind nicht belegt.

## Abschluss und Grenzen

Testzugänge und öffentliche Anwendungswege wurden geschlossen; beide Versandberechtigungen abschließend blockiert. Daten und unabhängig geprüfte Archive blieben erhalten. Eine eigenständige menschliche Leser-/Fachabnahme, anderer Anbieter und öffentliche Gesamtvarianten weiterer Anwendungen sind davon getrennt.

[Zur Prüfübersicht](README.md)
