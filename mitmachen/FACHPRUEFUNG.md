# Auftrag für die unabhängige Fachprüfung

Die Fachprüfung bewertet konkrete technische Aussagen des Buchs und deren Übertragbarkeit. Grundlage sind die vereinbarte Buchfassung, der tatsächliche eigene Prüfaufbau und die [veröffentlichten Testberichte](../pruefungen/README.md). Ein pauschales Urteil „sicher“ ist nicht das Ziel.

## Vorab vereinbaren

Halten Sie Buch-/Materialfassung, betroffene Kapitel, Geräte und Konten, zulässige Änderungen sowie Rückweg fest. Ausschließlich eigene freigegebene Lernsysteme und synthetische Daten verwenden. Ein Bericht mit Ergebniszusammenfassungen ersetzt keine unabhängige Beobachtung; erforderliche weitere Belege oder Gegenproben werden konkret benannt.

## Prüffelder

| Bereich | Fachliche Frage | Erwarteter Beitrag der Prüfung |
|---|---|---|
| Zugänge | Stimmen Hostbindung, Schlüsselrechte, Rollen und unabhängiger Wiederzugang zusammen? | Konkrete erlaubte und abgewiesene Wege, positive Rückkehr und nachvollziehbarer Endzustand. |
| Netztrennung | Welche tatsächlich geprüfte Grenze ergibt sich aus Topologie, Filter und Gegenstelle? | Virtuelle Firewallprüfung, physische VLAN-Probe und öffentliche Erreichbarkeit nicht miteinander gleichsetzen. |
| Sicherung | Ist der benötigte Datenstand außerhalb des ausgefallenen Originals vollständig nutzbar? | Leeres Rückholziel, bekannte Daten, Rechte, Anwendungszusammenhang und neue Daten beim Rückweg beurteilen. |
| Terminverwaltung | Gilt die begrenzte Ein-Instanz-Rezeptur unter den tatsächlichen Schreibwegen? | BL08/T03, prefork/mod_php, MaxRequestWorkers 1, ausgeschaltete zusätzliche Schreibwege und die dokumentierten 20 + 20 Paare einordnen; erforderliche Wiederholung begründen. |
| Zeitzonen und Kalender | Welche Aussage erlauben richtige UTC-Ereignisse trotz falscher Beschriftung/Metadaten? | Die dokumentierte Herstellergrenze ausdrücklich erhalten; andere Kalenderclients nicht ungeprüft freigeben. |
| Betrieb und Automatisierung | Werden Fehler, Ausbleiben, Teilzustände und unabhängige Kontrollen richtig behandelt? | Erkennbaren Fehlschlag und wirksame Begrenzung getrennt vom Erfolg einer automatisierten Aufgabe beurteilen. |

## Ergebnis je Befund

1. **Behauptung und Buchstelle:** Was wird genau zugesagt oder angeleitet?
2. **Prüfgrundlage:** Welche Fassung, Umgebung und Beobachtung wurden verwendet?
3. **Beurteilung:** Nachvollziehbar, zu korrigieren, zusätzliche Gegenprobe nötig oder nicht untersucht.
4. **Begründung:** Konkreter Einwand oder bestätigende Beobachtung, einschließlich Aussagegrenze.
5. **Nächster Schritt:** Kleinste erforderliche Korrektur oder Gegenprobe und deren sicherer Rückweg.

Die Fachprüfung ist unabhängig von der Leserprüfung. Beide Ergebnisse werden erst nach der tatsächlichen Durchführung eingetragen; diese Auftragsvorlage enthält noch keine Abnahme.
