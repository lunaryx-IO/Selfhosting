# Sicherung, Diagnose und Betrieb

**Beobachtungszeitraum:** Oktober 2026; Berichtsfassung 12. Oktober 2026.  
**Bezug:** Band 1: Website, Sicherung, Wartung und Proxydiagnose. Band 2: zusammenhängende Anwendungssicherung, Monitoring, Fehlersuche und Leistung.

## Methode

Caddy 2.11.7, lokale Linux-Dienste, restic über SFTP, externer Testspeicher sowie zusätzliche verschlüsselte Rückkopien auf einen unabhängigen Rechner. Reale Dienst- und Timerläufe wurden mit kontrollierten Fehlern und bekanntem Datenbestand verglichen. Die jeweilige Wiederherstellung wurde tatsächlich ausgeführt.

## Ergebnisse

| Versuch | Tatsächliches Ergebnis | Aussagegrenze |
|---|---|---|
| Website und Konfiguration zurückholen | Vollständige Quellen, konkrete Snapshotbindung, Dateien und Rechte auf leerem Ziel geprüft. | Ein Sicherungserfolg allein wurde nicht als Restore gewertet. |
| Anwendungen zusammen sichern | Exporte, Dateien und Images erfasst; aus unabhängiger Kopie mit bekannten Anwendungsdaten zurückgeholt. | Aussage gilt für die jeweilige erfasste Fassung. |
| Sicherung gezielt stören | Fehlende Pflichtquelle, belegte Sperre, Transferabbruch, Zeitlimit, Imagewechsel und fehlgeschlagener Wiederstart erkannt. Letzter brauchbarer Stand blieb erhalten. | Kein erzwungenes Entsperren als vermeintliche Reparatur. |
| Dienstzustand erhalten | Zuvor pausierte Anwendungen blieben pausiert; nur zum Export angehaltene Anwendungen wieder aufgenommen. | Keine pauschale Aktivierung aller vorgefundenen Dienste. |
| Externe Alarmkette | Tatsächliche Fehler-, Entwarnungs- und Ausbleibemeldungen am unabhängigen eigenen Empfänger angekommen. | Konfiguration und tatsächlicher Empfang wurden getrennt beobachtet. |
| Reguläre Sicherungstermine | Drei natürliche Tagesläufe und drei natürliche Stundenstarts mit Export, externer Kopie, Wiederkehr und Meldeeingang erfolgreich. | Manuelle Vorläufe und Nachholung nicht mitgezählt. |
| Unabhängige Archivprüfung | Neue Kopie mit 31 Snapshots und 327 Packs vollständig gelesen; alle drei Stundenstände zurückgeholt, jeweils 37 richtige Anwendungssummen. | Kein monatelanger Betriebsnachweis. |
| Proxydiagnose | Statisches 404, abgewiesene Backendverbindung mit 502 und angenommene, unbeantwortete Backendverbindung mit 504 unterschieden. | Die frühere 502-Erwartung beim Antworttimeout wurde im Buch korrigiert. |
| Monitoring | Anhaltende/kurze Überschreitung, Entwarnung, fehlender Exporter, fehlerhafte Sicherungsmetrik und ausbleibender Watchdog getrennt geprüft; Historie nach Neustart erhalten. | Keine vollständige öffentliche K047-Betriebsabnahme. |
| Begrenzte Last und Browsercache | Zwölf Läufe mit 759 Abrufen ohne HTTP-/Speicherfehler im Labor; echte Chrome-Cachewirkung und Korrektur beobachtet. | Keine Kapazitätszusage für andere Hardware. |

## Gemessene Zeiten richtig lesen

Bei einem gemeinsamen Export wurden 35,24 Sekunden Exportdauer beobachtet. Die Zeit vom ersten fehlgeschlagenen bis zum wieder erfolgreichen HTTP-Abruf lag für die beiden Anwendungen bei etwa 16,01 und 15,36 Sekunden; die Messabstände betrugen höchstens drei Sekunden.

Diese Angaben trennen den beobachteten HTTP-Ausfall von der gesamten Exportdauer. Sie sind keine exakte Ausfallgrenze und keine vollständig gemessene Wiederanlaufzeit nach Verlust des Standorts.

## Abschluss und offene Grenzen

Der ursprüngliche tägliche Sicherungsplan wurde nach dem Stundenversuch wiederhergestellt. Nach unabhängiger Archivprüfung wurden die bezahlten Laborressourcen beendet und die Meldeprüfungen pausiert. Die Archive blieben unabhängig erhalten.

Natürliche Zertifikatserneuerung, ein erst künftig fälliges Sicherheitspaket, langfristige Zuverlässigkeit und vollständiger Verlust des Anbieterkontos sind nicht durch die kurzen Versuche belegt. Solche Beobachtungen gehören zum später tatsächlich betriebenen Standort.

[Zur Prüfübersicht](README.md)

## Nachprüfung eigener Website-Dateien am 12. Oktober 2026

Der ergänzte Ablauf aus Band 1, Kapitel 16, wurde mit getrennten Testverzeichnissen unter Linux geprüft. Die erste Übernahme und ihre Rücknahme, eine Folgeänderung mit Bild und Unterordner sowie die vollständige Rückkehr einschließlich Eigentümern und Dateirechten bestanden. Eine im neuen Stand entfallene Seite blieb nicht im veröffentlichten Dateibaum zurück.

Ein bereits verwendeter Bereitstellungsname, eine abweichende Kopie und eine symbolische Verknüpfung wurden erkannt. Nach einer absichtlichen Unterbrechung zwischen den beiden Verschiebungen ließ sich der vorherige Bestand vollständig zurückholen. Die ursprüngliche Rückwegkopie blieb erhalten; die zusätzlichen Testverzeichnisse wurden danach entfernt.

Diese gezielte Nachprüfung betrifft die geänderten Dateioperationen. Sie wurde in einer vorhandenen Ubuntu-Linux-VM ausgeführt und wiederholt weder den früheren Caddy-/Browsernachweis noch eine unabhängige Testlektüre. Bestehende Dienste und andere Arbeitsdaten wurden dafür nicht verändert.
