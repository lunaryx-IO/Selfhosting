# BL08 — Die Terminverwaltung gezielt prüfen

Eine Terminverwaltung muss Buchungen auch dann verlässlich behandeln, wenn zwei Anfragen zusammentreffen, eine Nachricht ausbleibt oder Daten wiederhergestellt werden. Diese Beilage verbindet die Testfälle aus dem Terminaufbau — Kapitel 6 (Eine bereitgestellte Webanwendung übernehmen), dem Versand — Kapitel 7 (Formulare und Anwendungs-E-Mails absichern) und dem Wiederanlauf samt Freigabe — Kapitel 9 (Datenkonsistenz, Updates und Rückwege vertiefen). Sie können damit Ihre Ergebnisse ordnen oder eine Fachperson mit einem klar abgegrenzten Versuch beauftragen.

## Was Sie mit diesen Testfällen prüfen

Die Testprotokolle im zugehörigen Git-Repository nennen den jeweils untersuchten Aufbau und die beobachteten Ergebnisse. Vergleichen Sie diese Angaben mit Ihrer Softwarefassung und Konfiguration. So erkennen Sie, welche Bedingungen übereinstimmen und welche Unterschiede Sie bei der eigenen Prüfung berücksichtigen müssen.

Die **Installationsprüfung** umfasst Ihre tatsächlich verwendeten Rollen, Einstellungen, Versandwege und Sicherungen. Die normalen Bedienproben führen die Kapitel Schritt für Schritt vor. Für den gezielten Paralleltest T03 können Sie eine Fachperson hinzuziehen; die folgenden Angaben grenzen deren Aufgabe und den benötigten Ergebnisbericht ein.

Die ursprüngliche Rezeptur mit Fassung 1.6.0 hat im kontrollierten Parallelversuch Doppelbelegungen erzeugt. Der korrigierte Buchaufbau begrenzt die einzelne Apache-/PHP-Instanz auf eine gleichzeitig bearbeitete Anfrage. T03 wurde damit vor und nach unabhängiger Rückholung bestanden. Das Ergebnis gilt für diese Konfiguration mit abgeschalteten Integrationen; Versand und vollständige Betriebsfreigabe bleiben eigene Abnahmen.

## 1. Den zu prüfenden Stand eindeutig festlegen

Die folgende Übersicht hält den Softwareaufbau aus Kapitel 6 (Eine bereitgestellte Webanwendung übernehmen) fest. Vergleichen Sie diese Angaben mit Ihrer Installation und ergänzen Sie die beim Versuch tatsächlich verwendeten Fassungen. Nach einem Versionswechsel beziehen sich frühere Ergebnisse weiterhin auf den damals geprüften Stand.

| Baustein | Buchaufbau und Angaben für Ihren Versuch |
|---|---|
| Anwendung | Easy!Appointments 1.6.0, Release-ZIP aus der Bauvorlage in Kapitel 6 (Eine bereitgestellte Webanwendung übernehmen) |
| Release-ZIP SHA256 | `299f8da75583ea185992ece4ac0b10e98f673825edbf75116446d99001911e60` |
| PHP-Basis | Offizielles PHP 8.3 Apache auf Debian Bookworm, dokumentierter Stand PHP 8.3.33 |
| Basis-Indexdigest | `sha256:d9be5f5c49e07c71b1e906cf01a0bb7216dce466d1880d170467b9ca107071dd` |
| Gebautes Terminimage | Name `webhosting-termine:1.6.0-php8.3.33-r2-serial`; tatsächliche lokale Image-ID vor der Prüfung aus `image-id.txt` aufnehmen. |
| Lokaler Eingang | NGINX aus der Auswahl in Kapitel 3 (Mehrere Projekte trennen und Container verstehen); tatsächliche Image-ID aus `eingang-image-id.txt`, zugehörige `eingang.conf` und gemeinsames Archiv mit dem App-Image. |
| Plattform und Host | Buchaufbau: `linux/amd64`, Debian 13, Rootless Docker als `webapp`; genaue Host-, Engine- und Compose-Versionen beim Lauf erfassen. |
| Laufzeit im fertigen Image | Tatsächliche PHP-/Apache-Versionen und Erweiterungen aus dem gebauten Image erfassen; die Basisangabe allein ersetzt das nicht. |
| Bearbeitung der Anfragen | Genau eine App-Instanz, PHP als Apache-Modul mit `prefork`, `ServerLimit 1`, `MaxRequestWorkers 1` und zugehörige Werte aus Kapitel 6 (Eine bereitgestellte Webanwendung übernehmen); API, Kalenderabgleich und weitere schreibende Prozesse aus. |
| Datenbank | MariaDB 11.4; vollständige verwendete Registry-Referenz aus `.env` sowie tatsächliche Datenbankversion beim Lauf erfassen. |
| Konfiguration | Prüfsummen von Dockerfile, Apache-Konfiguration, Generator, Startskript, Compose und bereinigter Betriebsbeschreibung; Geheimnisse nur geschützt gesondert aufbewahren. |
| Sicherung | Datenzeitpunkt, Snapshot-ID, `BESTAND.txt`, Image-ID, Plattform, `image-reference.txt`, SQL, Storage und Archivprüfsummen des tatsächlich zurückgeholten Satzes |

Diese Werte werden aus demselben Aufbau gelesen. Ein Tagname, ein anderes Herstellerimage oder ein früherer Test einer fremden Installation genügt dafür nicht. Die Quellen zur Rezeptur stehen zentral im [Quellenverzeichnis zu Kapitel 6 (Eine bereitgestellte Webanwendung übernehmen)](BL07_quellen_und_links.md#kapitel-6-eine-bereitgestellte-webanwendung-übernehmen).

## 2. Umgebung und synthetischer Ausgangsbestand

Der Ausführende benötigt eine ausdrücklich zugeordnete, entbehrliche Testinstanz und ein getrenntes leeres Rückholziel. Vor Beginn festhalten: Maschinenkennungen, erlaubte Arbeiten, Zeitraum, verantwortliche Person, Kostenrahmen und geplanter Endzustand. Der ursprüngliche Docker-Speicher darf bei der abschließenden Rückholung nicht zur Verfügung stehen. Beginnen Sie den Versuch erst, wenn Testinstanz und Rückholziel eindeutig zugeordnet sind.

Verwenden Sie einen erfundenen Anbieter, eine Leistung von 30 Minuten und einen exklusiven Arbeitsplatz mit Kapazität eins. Dokumentieren Sie Zeitzone, Geschäftszeiten, Pausen, Vorlauf, Buchungshorizont und andere Einstellungen, die einen Zeitraum ausschließen könnten. Legen Sie einen Administrator, einen eingeschränkten Anbieter und zwei unterscheidbare synthetische Kundenprofile an. Alle Testzeiträume liegen innerhalb tatsächlich freier Geschäftszeiten; für jeden Konkurrenzversuch wird ein neuer Zeitraum verwendet.

Kalenderabgleich und sonstige Integrationen bleiben aus. Für Buchungs- und Konkurrenztests bleibt der Mailweg gesperrt; die getrennte Versandprüfung verwendet später ausschließlich eigene Testempfänger. Kennzeichnen Sie Aufzeichnungen mit Fallkennung und Testzeitraum. Sitzungscookies, CSRF-Werte, Zugangsdaten und unbereinigte Stornierungslinks werden nicht in das Ergebnisprotokoll übernommen.

## 3. Erst eine gültige Buchung, dann Konkurrenz

### T01 — Positive Kontrolle

Buchen Sie über die reguläre Oberfläche einen freien Zeitraum. Notieren Sie sichtbare Bestätigung, Kennung im Verwaltungskalender und den zugehörigen gespeicherten aktiven Datensatz. Ein fachkundiger Prüfer ordnet dafür die tatsächlich verwendeten Tabellen und Statuswerte anhand genau dieses Releases zu und liest sie ohne Änderungen aus.

Erwartet wird **genau eine aktive Buchung** für den gewählten Arbeitsplatz und Zeitraum. Ist bereits diese Kontrolle nicht erfolgreich, beginnen keine Konkurrenztests. Eine SMTP-Fehlermeldung muss getrennt vom tatsächlich gespeicherten Buchungsergebnis erfasst werden.

### T02 — Veraltete zweite Browseransicht

Öffnen Sie in zwei getrennten Sitzungen denselben freien Zeitraum. Schließen Sie die Buchung in Sitzung A ab und senden Sie anschließend die bereits vorbereitete Auswahl aus Sitzung B ab. Vergleichen Sie beide Rückmeldungen, Verwaltungskalender und aktive Datensätze. Wiederholen Sie den Versuch mit fünf neuen Zeiträumen.

Erwartet wird jeweils eine aktive Buchung und eine verständliche Ablehnung beziehungsweise neue Auswahl für die zweite Anfrage. Dieser Fall untersucht veraltete Ansichten. Er wird auch bei Erfolg nicht als erzwungene Parallelverarbeitung bezeichnet.

### T03 — Überlappende Speicheranfragen: Auftrag für die Fachprüfung

1. Ermitteln Sie am tatsächlichen Release den regulären Buchungsweg, seine Anfragefolge und die erforderlichen Sitzungs-, Formular-, CSRF- und gegebenenfalls CAPTCHA-Voraussetzungen. Verwenden Sie zwei eigenständige gültige Sitzungen. Ein vorbereiteter Request muss zunächst einzeln eine reguläre Buchung auslösen können; Testdaten danach geordnet über die Anwendung abschließen.
2. Bereiten Sie für einen neuen freien Zeitraum zwei gültige Buchungsanfragen vor. Halten Sie beide unmittelbar vor dem Absenden an einer gemeinsamen Startbarriere und geben Sie sie gemeinsam frei. Protokollieren Sie die Methode, Clientzeiten und eine serverseitige Beobachtung der überlappenden Verarbeitung. Ein bloß schneller Aufruf zweier Browser genügt nicht.
3. Ordnen Sie anhand des Quellstands und der Beobachtung zu, welches Zeitfenster zwischen Verfügbarkeitsentscheidung und Speicherung tatsächlich untersucht wurde. Beim auf eine Anfrage begrenzten Buchaufbau muss die Beobachtung stattdessen dessen wirksame **Serialisierung** belegen: Beide gültigen HTTP-Anfragen sind noch offen, die erste wartet im gezielt gehaltenen Speicherabschnitt und die zweite erreicht diesen erst nach dem Abschluss der ersten. Prozess- und Datenbankbeobachtung gehören zum Beleg. Ist nur der gemeinsame Versand, aber weder relevante Überlappung noch wirksame Serialisierung nachweisbar, bleibt der Fall **nicht belegt**. Verändern Sie dafür weder das Datenbankschema noch die Buchungslogik der Fremdanwendung.
4. Vergleichen Sie Antworten, Kalender und gespeicherte aktive Datensätze. **Genau eine** wirksame Buchung erfüllt die untersuchte Exklusivitätsregel. Zwei aktive Buchungen sind eine Verletzung; null erfolgreiche Buchungen machen den Fall ungültig. Eine Ablehnung wegen fehlender Tokens oder CAPTCHA untersucht den Anfragezugang, nicht die Buchungskonkurrenz.
5. Führen Sie 20 gültige Paare mit jeweils neuen freien Zeiträumen aus. Halten Sie gültige, ungültige und nicht belegte Überlappungen getrennt fest. Nach einer Korrektur beginnt eine neue, dem geänderten Stand zugeordnete Reihe.

Die Ein-Prozess-Grenze ist kein Schutz gegen zusätzliche App-Instanzen, direkte Datenbankeingriffe, nebenläufige Integrationen oder bewusst erzwungene Verwaltungsüberschneidungen. Diese Wege gehören nicht zum geprüften kleinen Buchungsprofil. Lange Anfragen können darin alle weiteren Zugriffe verzögern; Leistung und Versand sind gesondert zu prüfen.

Die Zahlen fünf und 20 sind der begrenzte Umfang dieses Prüfauftrags, keine statistische Sicherheitsgarantie. Schutzmechanismen bleiben aktiviert. Für einen anderen Anbieter-/Paketaufbau muss der Prüfer dessen tatsächlichen Weg und seine eigenen erlaubten Beobachtungsmöglichkeiten verwenden.

Die Fachperson richtet den Lastgenerator auf den zuvor ermittelten Buchungsweg ein. Dazu gehören gültige Sitzungen, die gemeinsame Startbarriere und die Beobachtung der Verarbeitung auf dem Server. Vor der eigentlichen Reihe muss jede vorbereitete Anfrage auch einzeln eine gültige Buchung auslösen können. Nur so lässt sich eine abgewiesene Doppelbelegung von einer grundsätzlich unbrauchbaren Testanfrage unterscheiden.

## 4. Weitere Abnahmefälle

| Fall | Handlung | Zu bestätigendes Ergebnis |
|---|---|---|
| T04 Neustart | Bekannte Termine erfassen; Container- und danach Serverneustart getrennt prüfen. | Dieselben Daten, richtige Rollen, geschützter Eingang; keine unbeabsichtigten Zeitgeber oder Nachrichten. |
| T05 Verschieben / Stornieren | Einen synthetischen Termin über die vorgesehenen Anwendungswege verschieben und stornieren. | Alter/neuer Zeitraum sowie aktiver Status passen zur dokumentierten Buchungsregel; erhaltene Daten sind erklärbar. |
| T06 Rollen | Anbieter- und Administrationskonto getrennt verwenden. | Vorgesehene Sicht- und Änderungsrechte; fremde Termine oder Verwaltungsfunktionen bleiben entsprechend der festgelegten Rolle gesperrt. |
| T07 Versand | Zustellung an eigenen Empfänger, danach kontrolliert fehlerhafter Versandweg. | Gespeicherter Buchungszustand und Versandzustand getrennt erkennbar; Wiederholung erzeugt keine unbemerkte weitere Buchung. Anschließend gültigen Weg wiederherstellen. |
| T08 Vollständiger Restore | Externen Sicherungssatz auf leerem Ziel ohne ursprünglichen Docker-Speicher zurückholen. | SQL, Dateien, Image-ID, Plattform und Referenz passen zusammen; bekannte Termine und Rollen stimmen; T01–T03 dem zurückgeholten Stand zuordnen beziehungsweise erneut prüfen. |
| T09 Sicherungsfehler | Fehlerfälle: fehlendes/falsches Image, Versionswechsel, Dumpfehler, Unterbrechung, fehlgeschlagener Wiederstart. | Kein falscher Erfolg; letzter guter Satz bleibt; nur zuvor angehaltene Dienste werden wieder aufgenommen. |
| T10 Abschlussschutz | Testzugänge, Empfänger, Dienste und Ressourcen anhand der vorherigen Vereinbarung prüfen. | Keine versehentliche öffentliche Buchungsfreigabe; benötigte Belege gesichert, ausschließlich eigene Testressourcen geordnet abgeschlossen. |

Messen Sie bei T09 die Zeit von der ersten unterbrochenen App bis zur bestätigten Rückkehr aller betroffenen Apps getrennt von der gesamten Laufzeit. Ein späterer Vergleich zweier Verfahren benötigt denselben Datenbestand und dieselbe Umgebung. Die Messung belegt nur die tatsächlich untersuchte Fassung.

## 5. Ein Ergebnis, das sich beurteilen lässt

Für jeden Fall genügt eine Zeile mit: **Fallkennung, geprüfter Stand, Ausgangsdaten, Methode, Erwartung, Beobachtung, Ergebnis und Belegort**. Zulässige Ergebnisse sind bestanden, fehlgeschlagen, ungültiger Versuch und nicht ausgeführt; ein leerer Eintrag ist kein Erfolg. Halten Sie außerdem die Grenze des jeweiligen Versuchs und den sicheren Endzustand fest.

Lesen Sie das Ergebnis anschließend zusammen mit Ihrer Betriebsregel: Für welchen Stand wurde genau eine aktive Buchung bestätigt, welche Fehlerfälle wurden untersucht und ist die vollständige Rückholung gelungen? Eine ungeklärte Doppelbelegung oder ein fehlender Nachweis für den verbindlichen Buchungsweg lässt den zusätzlichen Zugangsschutz bestehen. Die Informationswebsite und die Übungen mit synthetischen Terminen können Sie währenddessen weiter nutzen. Den zusammenhängenden Freigabeablauf finden Sie in Kapitel 9 (Datenkonsistenz, Updates und Rückwege vertiefen).
