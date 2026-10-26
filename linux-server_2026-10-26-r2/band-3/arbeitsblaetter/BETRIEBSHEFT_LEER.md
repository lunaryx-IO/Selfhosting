# Mein Betriebsheft

Persönliche Arbeitskopie zu **Linux-Server – Das umfassende Praxisbuch, Band 3**. Übernehmen Sie nur die Teile, die zu Ihrem Aufbau gehören, und führen Sie vorhandene Notizen weiter. Passwörter, private Schlüssel und Tokens bleiben in ihrer geschützten Ablage. Im Heft genügt ein neutraler Verweis darauf. Auch die ausgefüllte Datei bewahren Sie geschützt und unabhängig vom betreuten Server auf.

Die [erklärte Vorlage mit Beispielen](../BL01_betriebsheft_anforderungen_und_kosten.md) hilft Ihnen beim Ausfüllen. Ein Texteditor genügt.

## Aufbau

### Erweiterung vom [Datum mit Zeitzone]

- Gewählte Aufgabe: Dateien / Postfächer / beides: [eintragen]
- Konkreter Nutzen und ausdrücklich ausgenommene Aufgaben: [eintragen]
- Verantwortliche Person/Rolle und erreichbare Vertretung: [eintragen]
- Vertretbarer Verlust neuer Änderungen beziehungsweise Nachrichten: [eintragen]
- Vertretbare Ausfallzeit einschließlich Entdeckung und Reaktion: [eintragen]
- Einmalige, laufende und zeitweilige Zusatzkosten: [eintragen]
- Noch nicht ausgegebene Reserve und verfügbare eigene Zeit: [eintragen]

### Tatsächliche Rollen

| Rolle | Standort/Systemidentität | Daten und Dateisystem-UUID | Nutzerweg | Verwaltung |
|---|---|---|---|---|
| Dateirolle, falls gewählt | [eintragen] | [eintragen] | [eintragen] | [eintragen] |
| Mailrolle, falls gewählt | [eintragen] | [eintragen] | [eintragen] | [eintragen] |
| Unabhängige Sicherung | [eintragen] | [eintragen] | kein gewöhnlicher Nutzerzugang | [eintragen] |

- Installierte System-/Paketfassungen und Datum der Erfassung: [eintragen]
- Heimnetzvariante oder VPS-Netz; vorhandene und neue Grenzen: [eintragen]
- Gewählte Clientadressen, Route, zuständiges Gateway und Rückroute: [eintragen]
- Erlaubte VPN-Gerätepaare und Dienste: [eintragen]
- Datenumfang, Wachstum, freie Reserve und Quoten: [eintragen]
- Datenträgerverschlüsselung und Folgen für Neustart/Ersatz: [eintragen]
- Maildomain, Dienstname, autoritative Zone und PTR-Zuständigkeit: [eintragen]
- Gewählter ausgehender Mailweg; weiter verwendete Anwendungsversender: [eintragen]
- Dienste/Netzfreigaben, die am Ende der Sitzung tatsächlich aktiv sind: [eintragen]

## Zugänge

- Persönlicher Verwaltungszugang und unabhängige Konsole je Rolle: [eintragen]
- Verifizierter SSH-Hostfingerabdruck und unabhängiger Vergleich: [eintragen]
- Neutrale Tresorverweise für Anbieter, Domain und Sicherung: [eintragen]
- Recovery-Postfach außerhalb des eigenen Mailbetriebs: [eintragen]
- Außerhalb des eigenen Mailbetriebs empfangener Alarmweg: [eintragen]
- Letzte tatsächliche Wiederzugangs-/Alarmprobe: [eintragen]

### Dateizugänge, falls verwendet

| Person/Konto | Aufgabe/Gruppe | Tatsächliche UID/GID und Samba-Zuordnung | Geräte | Entzugsweg |
|---|---|---|---|---|
| [eintragen] | [eintragen] | [eintragen] | [eintragen] | [eintragen] |

- Server-SID und geschützte Ablage der zugehörigen Kontendaten: [eintragen]
- Leserechte, Schreibrechte und beabsichtigtes Löschen/Umbenennen: [eintragen]
- Bereits bestehende Sitzung bei Entzug berücksichtigt: [eintragen]
- Unabhängiger Zugang zum Daten-/Sicherungsschlüssel: [eintragen]

### Mailzugänge, falls verwendet

| Postfach | Verantwortliche Person | Erlaubte Absender/Aliasse | Quote | Entzugsweg |
|---|---|---|---|---|
| [eintragen] | [eintragen] | [eintragen] | [eintragen] | [eintragen] |

- Tatsächliche vmail-UID/GID und private Datenpfade: [eintragen]
- Dovecot-Kontenbestand und Postfix-Empfänger-/Absendermaps: [eintragen]
- Zertifikatsnamen, automatische Erneuerung und geprüfte Endpunkte: [eintragen]
- DKIM-Selectoren; gültige Versandquellen; DMARC-Berichtsziel: [eintragen]
- Entzug neuer und bestehender IMAP-/SMTP-Sitzungen: [eintragen]
- Vereinbarte administrative Einsicht und zuständige Personen: [eintragen]

## Änderungen

### Eintrag vom [Datum mit Zeitzone]

- Anlass, betroffene Rolle und bisherige Funktion: [eintragen]
- Beobachtung; davon getrennte Vermutung: [eintragen]
- Vorheriger Konfigurations-/Paketstand und vollständige Snapshot-ID: [eintragen]
- Angekündigte Unterbrechung; betroffene Nutzer/Schreiber: [eintragen]
- Tatsächlich ausgeführte Änderung und Zeitpunkt: [eintragen]
- Positive Funktionsprobe und passende Gegenprobe: [eintragen]
- Seit der Änderung neu entstandene Dateien/Nachrichten/Flags: [eintragen]
- Rückweg, der diese neuen Daten berücksichtigt: [eintragen]
- Gewählter Weiterbetriebsstand; wieder aktive Timer/Zugänge: [eintragen]
- Noch offene Beobachtung, zuständige Person und nächster Schritt: [eintragen]

## Wiederherstellung

- Benötigter Datenstand und erlaubte Ausfallzeit: siehe Aufbau.
- Datenquellen einschließlich Rechte, Identitäten und Geheimnisse: [eintragen]
- Dienstgerechte Schreibpause und tatsächlicher Sicherungsumfang: [eintragen]
- Unabhängiges Repository, Transportweg und gemeinsame Abhängigkeiten: [eintragen]
- Sicherungstakt; letzter abgeschlossener Stand; vollständige Snapshot-ID: [eintragen]
- Tatsächliche Fehler- und Ausbleibemeldung am unabhängigen Empfänger: [eintragen]
- Gesondert zugängliches Sicherungspasswort und Datenträgerschlüssel: [eintragen]
- Verfügbarkeit eines leeren Ersatzsystems mit passender Kapazität: [eintragen]
- Isolierung der Probe; kein zweiter öffentlicher Sender/Schreiber: [eintragen]
- Zurückgeholte Datei/Postfächer und Metadaten: [eintragen]
- Geprüfte Konten/Rechte/Clienthandlungen und abgewiesene Gegenprobe: [eintragen]
- Mailqueue getrennt beurteilt; unbekannter Versandzustand geklärt: [eintragen]
- Gemessene Zeiten für Bezug, Aufbau und Funktionsprobe: [eintragen]
- Noch nicht gemessene Entdeckung, Beschaffung und organisatorische Zeit: [eintragen]
- Abweichung vom gewünschten Ziel und beschlossene Verbesserung: [eintragen]
- Gewählter Weiterbetrieb und alleiniger aktueller Datenstand: [eintragen]
- Befristete Probe-/Kostenressourcen und bestätigtes Ende: [eintragen]
- Datum der unabhängigen Kopie dieses Betriebshefts: [eintragen]
