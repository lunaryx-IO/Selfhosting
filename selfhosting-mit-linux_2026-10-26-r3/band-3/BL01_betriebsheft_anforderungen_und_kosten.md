# Betriebsheft: Dateien, Postfächer und eigener Betriebsstand

**Zugehörige Manuskriptfassung:** Selfhosting mit Linux, Band 3, Markdown-Stand vom 26. Oktober 2026. Die einzelnen Quellen behalten ihre angegebenen Prüfdaten.

Diese ausfüllbare Beilage gehört zum [digitalen Begleitmaterial von Band 3](README.md). Legen Sie für Ihre Einträge eine eigene Arbeitskopie an. Die Kostenrechnung, die technischen Anleitungen und die Rückwege finden Sie vollständig im Buch.

Die Materialliste und die Postfächer bringen neue Einzelheiten in Ihren Aufbau. Das vertraute Betriebsheft behält trotzdem seine vier Bereiche: **Aufbau, Zugänge, Änderungen und Wiederherstellung**. Unter ihnen ergänzen Sie die tatsächlich gewählten Dienste. Ihre Website muss dadurch nicht nochmals beschrieben werden. Ein Verweis auf die vorhandene Servernotiz genügt, wo sich nichts geändert hat.

Stellen Sie sich vor, Sie kommen nach einigen Wochen wieder zu diesem Aufbau zurück. Im Heft finden Sie den richtigen Rechner, den zuletzt gesicherten Stand und die Person, die auf einen wiederhergestellten Zugang wartet. Diese Verbindungen zwischen den einzelnen Angaben helfen Ihnen, die Arbeit wieder aufzunehmen.

Die folgenden Blöcke sind **Notizvorlagen, keine auszuführenden Befehle**. Übernehmen Sie nur die Teile, die zu Ihrem Vorhaben gehören. Ein Feld mit `[eintragen]` bleibt bis zur tatsächlichen Einrichtung offen. Wenn eine Frage noch geklärt werden muss, halten Sie den nächsten konkreten Schritt fest. Ein begründetes „entfällt“ beschreibt dagegen eine getroffene Entscheidung.

Passwörter, private Schlüssel, Wiederherstellungscodes und geheime Alarmadressen bleiben im dafür vorgesehenen sicheren Speicher. Im Heft steht ein eindeutiger Verweis auf diesen Eintrag. Auch das Heft selbst benötigt eine geschützte unabhängige Kopie: Bei einem ausgefallenen Dateiserver wäre es unpraktisch, wenn die einzige Wiederaufbauanleitung gerade auf dessen Freigabe läge.

## Aufbau: die neue Aufgabe einordnen

Beginnen Sie mit der benötigten Funktion. Wer soll welche Dateien verwenden? Welche Postfächer sollen entstehen? Daraus ergeben sich Umfang, Rollen und Zugangswege. Ein Dienst, den Sie noch nicht benötigen, muss weder eingerichtet noch vorsorglich bezahlt werden.

~~~markdown
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
~~~

Die Standortspalte unterscheidet eine Funktion von ihrem heutigen Rechner. Wenn der Dateidienst später umzieht, bleibt die Aufgabe dieselbe; Systemidentität, Datenträger und Netzweg ändern sich. Genau dieser Unterschied hilft beim Vergleich vor und nach dem Umzug.

## Zugänge: Personen, Geräte und Dienstkonten auseinanderhalten

Eine Person meldet sich am Dateidienst an, ein Gerät erhält einen privaten Netzwerkweg, und die Administration pflegt das Betriebssystem. Diese Berechtigungen gehören zusammen, sind aber verschiedene Einträge. Bei einem verlorenen Notebook lässt sich dadurch erkennen, welche davon entzogen werden müssen.

~~~markdown
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
~~~

Das Heft benötigt keine Kopie der vollständigen Kontendatei. Deren geschützte Sicherung ist eine eigene Aufgabe. Hier geht es um die Zuordnung, mit der Sie einen Zugang erklären, wiederherstellen oder gezielt sperren können.

## Änderungen: den Datenstand mitnehmen

Während Sie eine Änderung beurteilen, arbeitet vielleicht schon jemand mit der Dateifreigabe weiter oder der Mailserver nimmt neue Nachrichten an. Halten Sie deshalb auch fest, was seit dem Eingriff hinzugekommen ist. Wenn Sie die vorherige Konfiguration wieder einsetzen möchten, brauchen diese neuen Dateien und Nachrichten weiterhin ihren Platz. An dieser Stelle verbindet die Notiz den technischen Rückweg mit der inzwischen geleisteten Arbeit.

~~~markdown
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
~~~

Bei einer kleinen Änderung genügt oft ein zusammenhängender Absatz. Füllen Sie die ausführliche Vorlage aus, wenn mehrere Zustände auseinandergehalten werden müssen. Sie dient Ihrer späteren Orientierung und braucht keinen bestimmten Umfang.

## Wiederherstellung: vom Sicherungsstand zur benutzbaren Aufgabe

Aus den gesicherten Daten und Einstellungen soll wieder eine benutzbare Ablage oder ein erreichbares Postfach werden. Halten Sie deshalb fest, welche Datei Sie mit welchem Zugang geöffnet haben oder welche Nachricht wieder lesbar war. So finden Sie später im Heft auch den Schritt vom zurückgeholten Bestand zur tatsächlichen Benutzung wieder.

~~~markdown
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
~~~

## Zwei Notizen, an denen eine Entscheidung erkennbar bleibt

Die folgenden beiden Beispiele sind konstruiert. Sie zeigen, wie aus einer Beobachtung eine Entscheidung und eine brauchbare Notiz werden kann. In Ihrem Heft ergänzen Sie dazu die eigenen Zeiten, vollständigen Snapshotkennungen und Kontenzuordnungen. Technische Kennungen lassen wir im Beispiel offen; sie müssen zum wirklich verwendeten Sicherungsstand gehören.

### Eine ältere Materialliste neben neuer Arbeit zurückholen

Nehmen wir für dieses Beispiel an, die Dateiablage enthält bereits einen unabhängig gesicherten Lernbestand. Am Montagmorgen ist die Materialliste vollständig. Am Vormittag wird eine Zeile versehentlich überschrieben. Gleichzeitig entsteht im selben Ordner ein neues Dokument, das weiterhin gebraucht wird. Die Aufgabe lautet damit genauer: Der frühere Inhalt der Liste wird benötigt, die andere neue Datei soll bleiben.

| Angabe in der Notiz | Beispiel für eine brauchbare Notiz |
|---|---|
| Aufbau | Gemeinsame Unterlagen auf der Dateirolle; die Materialliste liegt im bekannten Ordner `unterlagen`. Die beiden persönlichen Zugänge und ihre Gruppen stehen in der vorhandenen Zugangsnotiz. |
| Beobachtung | In der aktuellen Materialliste fehlt die zuvor vorhandene Position. Das am Vormittag zusätzlich angelegte Dokument ist dagegen gewollte neue Arbeit. |
| Gewählter Stand | Die ältere Liste wird aus dem unabhängig erreichbaren Montagmorgen-Stand an einen getrennten Ort zurückgeholt. Seine vollständige Kennung wird vor dem Aufruf in der echten Notiz festgehalten. |
| Entscheidung | Zunächst beide Listen inhaltlich vergleichen. Nur die benötigte Fassung der Liste zur Übernahme vorbereiten; den übrigen aktuellen Ordner erhalten. |
| Abschluss | Nach der bewussten Übernahme öffnen beide persönlichen Zugänge die Liste mit ihren vorgesehenen Rechten. Das neue Dokument wird ebenfalls noch einmal geöffnet. Danach wird der gewählte Weiterbetriebsstand gesichert. |

An dieser Notiz lässt sich erkennen, weshalb wir zunächst nur die ältere Liste getrennt zurückholen. Die Sicherung enthält zwar die gesuchte Liste, kennt aber die später hinzugekommene Arbeit noch nicht. Im getrennten Rückholordner können wir den alten Inhalt mit dem aktuellen vergleichen. Ob eine alte Zeile übernommen oder die ganze Liste ersetzt wird, entscheidet dieser Vergleich.

Auch die Rechte gehören zum Abschluss. Das bloße Auftauchen einer Datei auf dem Server beantwortet noch nicht, ob der gewohnte Lesezugang sie öffnen kann und der pflegende Zugang sie weiterhin bearbeiten darf. Tragen Sie die beobachtete Handlung ein. Eine Notiz wie „Rückholung erfolgreich“ lässt diese entscheidende Einzelheit offen; ein Satz über die geöffnete Liste und das erhaltene neue Dokument ist später wesentlich hilfreicher.

Der Zeitbedarf erhält ebenfalls einen konkreten Bezug. Wenn das Herunterladen der alten Datei nur kurz dauert, das Auffinden des richtigen Stands aber lange, liegt die nächste Verbesserung vielleicht im Betriebsheft. Sie müssen dafür nicht vorschnell eine andere Sicherungsplattform wählen. Die Notiz zeigt, an welcher Stelle die Arbeit tatsächlich stockte.

### Eine Aufgabenadresse einer anderen Person zuordnen

Im zweiten Beispiel übernimmt die zweite Person künftig die neuen Anfragen an `kontakt@post.example.org`. Die bisherige Korrespondenz liegt im Postfach der ersten Person. Die Aufgabenadresse ist in unserem Aufbau eine Zuordnung zu einem Postfach. Ihre Änderung verschiebt daher nicht nachträglich die schon abgelegten Nachrichten.

| Angabe in der Notiz | Beispiel für eine brauchbare Notiz |
|---|---|
| Anlass | Die zweite Person bearbeitet künftig neue Kontaktanfragen. Beide persönlichen Konten behalten zunächst ihre übrigen Aufgaben. |
| Empfangsentscheidung | Neue Nachrichten an die Aufgabenadresse sollen nach der in Kapitel 15 beschriebenen Änderung im Postfach der zweiten Person ankommen. |
| Versandentscheidung | Gesondert festlegen, welches Konto unter der Aufgabenadresse antworten darf. Empfangsziel und erlaubter Absender werden gemeinsam betrachtet, aber getrennt eingerichtet. |
| Vorhandener Bestand | Die bisherige Korrespondenz verbleibt vorerst am alten Ablageort. Benötigte Übergaben werden ausdrücklich vereinbart und als eigene Datenübernahme behandelt. |
| Beobachtung | Eine eindeutig erkennbare neue Übungsnachricht an die Aufgabenadresse wird im vorgesehenen Postfach gesucht; die Antwort wird über den tatsächlich gewählten Versandweg verfolgt. |
| Abschluss | Neue Zuständigkeit, benötigte alte Unterlagen und tatsächlich erlaubte Zugänge sind festgehalten. Der nächste Sicherungsstand muss die geänderten Zuordnungen einschließen. |

Die Notiz verbindet eine organisatorische Entscheidung mit ihren technischen Folgen. „Kontakt ist jetzt bei Person zwei“ wäre als Merksatz verständlich, ließe aber mehrere Fragen offen. Wo liegt die neue Anfrage? Von welcher Adresse darf die Antwort kommen? Wie erreicht die neue zuständige Person eine ältere Zusage, die sie für die Antwort benötigt? Diese Fragen entstehen aus der Arbeit und sollten sich im Heft wiederfinden.

Ein Aufgabenwechsel ist außerdem nicht automatisch ein vollständiger Zugangsentzug. Vielleicht übernimmt die erste Person künftig andere Aufgaben und benötigt ihr persönliches Postfach weiter. Verlässt sie die Werkstatt, kommt die in den Kapiteln erklärte Beendigung neuer und bestehender Zugriffe hinzu. Schreiben Sie die tatsächlich getroffene Entscheidung auf, damit bei einer späteren Wiederherstellung kein älterer Sicherungsstand unbeabsichtigt die frühere Berechtigung wieder einführt.

Für die einzelnen Handgriffe schlagen Sie das passende Kapitel auf. Im Heft bleiben der Anlass, der gewählte Datenstand und Ihre Beobachtung zusammen. Das reicht, um die eigene Entscheidung später wieder aufzunehmen, ohne die ganze Anleitung abzuschreiben.
