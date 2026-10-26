# Betriebsheft: Anforderungen, Kosten und eigener Betriebsstand

**Zugehörige Manuskriptfassung:** Selfhosting mit Linux, Band 2, Markdown-Stand vom 26. Oktober 2026. Die einzelnen Quellen behalten ihre angegebenen Prüfdaten.

*Optionale Arbeitsvorlage zum Buch · Stand: 22. September 2026*

Ein gutes Betriebsheft beantwortet nach einer längeren Pause wenige konkrete Fragen: Welches System betreue ich? Wo liegen die benötigten Dateien und Zugänge? Was wurde zuletzt geändert? Wie komme ich wieder zu einem brauchbaren Stand?

Diese Vorlage verbindet die Planung aus Anforderungen, Aufwand und Kosten (Band 1, Kapitel 2) mit den vier Bereichen aus Arbeitsrechner und sichere Zugänge (Band 1, Kapitel 4, Abschnitt „Ein Betriebsheft, das Ihnen später Arbeit erspart“). Sie können sie als Grundlage für Ihre vorhandene Datei **planung.md** verwenden. Wer bereits übersichtliche eigene Notizen führt, ergänzt nur die fehlenden Angaben. Alle benötigten Anleitungen bleiben im Buch.

Wenn Sie Ihr vorhandenes Betriebsheft weiterführen, können Sie direkt bei der [Ergänzung für Band 2](BL01_betriebsheft_anforderungen_und_kosten.md#ergänzung-für-band-2-nur-eingerichtete-anwendungen-aufnehmen) beginnen. Sie nehmen daraus nur die Angaben zu tatsächlich eingerichteten Anwendungen auf und ergänzen sie in den vorhandenen vier Bereichen.

Die vollständige Grundvorlage bleibt darunter verfügbar, falls Sie bislang anders notiert haben oder einzelne Angaben nachtragen möchten. Die beiden ausgefüllten Kostenbeispiele helfen beim Vergleich; ein zweites Betriebsheft brauchen Sie dafür nicht.

## Mit wenigen Angaben beginnen

Für eine neu angelegte Grundnotiz beginnen Sie mit Funktionsumfang, Standort, benötigtem Datenstand nach einem Ausfall, vertretbarer Unterbrechung, Jahresbudget und Zuständigkeit. Bei einem bestehenden Server übernehmen Sie die tatsächlichen Angaben aus Ihrer bisherigen Dokumentation und ergänzen, was Ihre gewählte Erweiterung verändert.

Kopieren Sie aus der folgenden Arbeitsfassung nur die gerade benötigten Abschnitte in Ihr Betriebsheft. Die Gliederung bleibt **Aufbau, Zugänge, Änderungen und Wiederherstellung**. Die Beispiele weiter unten dienen zum Vergleich und gehören nicht als eigener Betriebsstand in Ihre Datei. Vorhandene Notizen werden beim Übernehmen zusammengeführt, nicht überschrieben.

Die eckigen Platzhalter **[eintragen]** ersetzen Sie durch eigene Angaben. Wenn etwas noch ungeklärt ist, schreiben Sie **offen — nächste Klärung …**. **Entfällt — weil …** passt nur, wenn die Aufgabe für Ihren gewählten Aufbau tatsächlich nicht benötigt wird. So lässt sich später eine bewusste Entscheidung von einem vergessenen Feld unterscheiden. Unbenutzte Modulabschnitte können Sie entfernen.

Das Heft enthält Hinweise auf Zugangsmittel, jedoch keine Passwörter, privaten Schlüssel, Tokens, Wiederherstellungscodes oder geheimen Melde-URLs. Ein neutraler Eintragsname im Passwortmanager genügt. Auch ohne diese Geheimnisse können Adressen, Vertragsangaben und Netzpläne vertraulich sein. Bewahren Sie Ihre Arbeitsfassung geschützt und zusätzlich außerhalb des alleinigen Website-Servers auf; sie gehört nicht in dessen öffentliches Dateiverzeichnis.

## Ihre kopierbare Arbeitsfassung

Die folgenden Abschnitte sind Notizvorlagen für den Texteditor und enthalten keine auszuführenden Befehle. Beginnen Sie mit den ersten sieben Angaben. Das Kostenblatt gehört ebenfalls zur Planung; der dritte Block wird erst während der Einrichtung benötigt.

### Der erste Plan

~~~markdown
## Aufbau

### Vorhaben und Entscheidung

- Projekt und Datum dieser Planung: [eintragen]
- Erster Funktionsumfang und ausdrücklich spätere Erweiterung: [eintragen]
- Betriebsweg und Grund der Wahl: [eintragen]
- Datenarten; benötigter Datenstand nach einem Ausfall: [eintragen]
- Vertretbare Ausfalldauer einschließlich Entdeckung und Reaktion: [eintragen]
- Verantwortliche Rolle, erreichbare Vertretung und verfügbare Zeit: [eintragen]
- Jahresbudget; gesonderte Reserve; wichtigste offene Entscheidung: [eintragen]
~~~

### Das wiederverwendbare Kostenblatt

Kopieren Sie diesen Teil unter „Aufbau“, sobald Sie Kosten vergleichen. Entfernen Sie nicht benötigte Positionen mit einer kurzen Begründung.

~~~markdown
### Kostenblatt

- Betrachteter Zeitraum: [eintragen]
- Währung und Preisbasis einschließlich Steuerdarstellung: [eintragen]
- Vorhandene Geräte/Verträge und zusätzlich erfasste Projektkosten: [eintragen]

| Kostenposition | Ansatz mit Menge und Zeitraum | Herkunft, Datum und offene Bedingung | Betrag im ersten Jahr |
|---|---|---|---|
| Serverkauf oder Servermiete mit gebuchten Adressen | [eintragen] | [eintragen] | [eintragen] |
| Einrichtung, Datenträger, Kabel und Zubehör | [eintragen] | [eintragen] | [eintragen] |
| Zusätzlich benötigte Heimnetztechnik | [eintragen] | [eintragen] | [eintragen] |
| Strom von Server und zusätzlicher Netztechnik | [eintragen] | [eintragen] | [eintragen] |
| Mehrkosten von Anschluss oder Vermittlung | [eintragen] | [eintragen] | [eintragen] |
| Domain und Verlängerung | [eintragen] | [eintragen] | [eintragen] |
| Externer Sicherungsspeicher und nötige Übertragung | [eintragen] | [eintragen] | [eintragen] |
| Gewählter Versand, Überwachung oder private Fernverwaltung | [eintragen] | [eintragen] | [eintragen] |
| Zeitweiliges Ersatzsystem, Übungen und Zusatzressourcen | [eintragen] | [eintragen] | [eintragen] |
| Weitere tatsächlich benötigte Leistung | [eintragen] | [eintragen] | [eintragen] |

- Einmalige Ausgaben zusammen: [eintragen]
- Laufende Ausgaben des ersten Jahres zusammen: [eintragen]
- Eigenes Übungsbudget des ersten Jahres: [eintragen]
- Geplante Ausgaben des ersten Jahres insgesamt: [eintragen]
- Folgejahr ohne die entfallenden Erstanschaffungen: [eintragen]
- Zusätzlich bereitzuhaltende, noch nicht ausgegebene Reserve: [eintragen]
- Eigene Zeit: Einrichtung / laufende Betreuung / Übungen: [eintragen]
- Lernzeit, Inhalte und ungeplante Störungen zusätzlich: [eintragen]
- Optionaler kalkulatorischer Stundenwert, getrennt von Ausgaben: [eintragen]
- Nächster Preis-/Vertragsvergleich und Beendigungsfrist: [eintragen]
~~~

### Die späteren Betriebsangaben

Die ersten Zeilen ergänzen „Aufbau“. Zugänge, Änderungen und Wiederherstellung bilden danach die drei übrigen Heftbereiche. Übernehmen Sie sie nach Bedarf beim jeweiligen Lernschritt.

~~~markdown
### Tatsächlich eingerichteter Stand — später ergänzen

- Arbeitsrechner, Betriebssystem, Shell und SSH-Clientfassung: [eintragen]
- Eigener Arbeitsordner und Ablage dieser Notiz: [eintragen]
- Serverrolle, Standort, Architektur und tatsächlicher Systemstand: [eintragen]
- Gewählte Anwendungen/Module und tatsächliche Fassungen: [eintragen]
- Eigene Webnamen, DNS-Zuständigkeit, Ziel und TLS-Endpunkt: [eintragen]
- Netzvariante, verwendete IP-Familien und Verwaltungsweg: [eintragen]
- Ablage der relevanten Konfigurationen und Geräteexporte: [eintragen]
- Verwendete Dienstleister, Datenorte und Vertragsprüfung: [eintragen]
- Aktueller Betriebszustand und letzte dazu passende Beobachtung: [eintragen]

## Zugänge

- Verwaltungsrolle und erlaubter Zugangsweg zum richtigen Server: [eintragen]
- Bezeichnung des eigenen SSH-Schlüssels; geschützter Aufbewahrungsort: [eintragen]
- Hostfingerabdruck, Vergleichsdatum und unabhängiger Vergleichsweg: [eintragen]
- Unabhängiger Konsolen-/Wiederzugangsweg; tatsächliche letzte Probe: [eintragen]
- Anbieter-, Domain- und Speicherzugänge: nur neutrale Tresorverweise: [eintragen]
- Unabhängiger Zugriff auf Sicherungspasswort und Wiederzugangsunterlagen: [eintragen]
- Wer bei Ausfall oder Abwesenheit handeln kann: [eintragen]

## Änderungen

### Eintrag vom [Datum mit Zeitzone]

- Anlass, betroffener Server und vorheriger Stand: [eintragen]
- Beobachtung oder begründete Vermutung: [eintragen]
- Tatsächlich vorgenommene Änderung; zugehöriger Versions-/Dateistand: [eintragen]
- Beobachtetes Ergebnis einschließlich betroffener Daten und Rechte: [eintragen]
- Aufbewahrter Rückweg; seitdem neu entstandene Daten: [eintragen]
- Entscheidung, offene Folgeaufgabe und zuständige Rolle: [eintragen]
- Fundstelle nötiger bereinigter Belege: [eintragen]

## Wiederherstellung

- Ziele: siehe benötigten Datenstand und Ausfalldauer unter Aufbau.
- Benötigter Sicherungsumfang; Ablage der eigenen vollständigen Auswahl: [eintragen]
- Lokales und externes Repository; gemeinsame Abhängigkeiten: [eintragen]
- Zusätzliche Kopie außerhalb einer gemeinsam gefährdeten Umgebung: [eintragen]
- Ausgewählte vollständige Snapshot-ID und enthaltenes Export-/Datendatum: [eintragen]
- Sicherungstakt, letzte abgeschlossene externe Kopie und Alarmempfänger: [eintragen]
- Letzte tatsächlich empfangene Fehler-/Ausbleibemeldung: [eintragen]
- Zugriff auf Geheimnisse: siehe Zugänge; keine Geheimnisse hier einfügen.
- Ersatzsystem, Wiederaufbauweg und Umgang mit dem bisherigen Server: [eintragen]
- Bei paralleler Probe: eigene Meldeziele, Repository und angehaltene Aufgaben: [eintragen]
- Letzte Restoreprobe: Datum, Quelle, zurückgeholter Inhalt und Ergebnis: [eintragen]
- Gemessene Übungsdauer; darin fehlende Entdeckungs-/Beschaffungszeiten: [eintragen]
- Vergleich mit den Zielen, nächste nötige Änderung und Zuständigkeit: [eintragen]
- Noch aktive Probe-/Kostenressourcen und geplanter Abschluss: [eintragen]
- Unabhängige Ablage dieser Notiz und Datum ihrer letzten Kopie: [eintragen]
~~~

Für kleine Inhaltsänderungen genügt unter „Änderungen“ oft ein kurzer Absatz. Die ausführlicheren Zeilen werden nützlich, sobald Konfiguration oder Anwendungsdaten betroffen sind. Große Protokollausgaben bewahren Sie gegebenenfalls gesondert auf und verweisen auf die relevante Stelle.

### Das Kostenblatt sinnvoll verwenden

Jede Kostenposition erhält ihre Herkunft: **eigenes Angebot**, **gemessener Wert** oder **Annahme**. Bei Angeboten gehören Produktumfang, Abrufdatum, Währung, Steuerdarstellung, Abrechnungszeitraum und mögliche Zusatzleistungen zusammen. Ein noch ungeklärter Betrag bleibt offen. Eine Null bedeutet dagegen, dass für diese Position unter den notierten Voraussetzungen keine zusätzliche Ausgabe geplant ist.

Einmalige, laufende und Übungsausgaben werden genau einmal addiert. Eine gesonderte Reserve wird nicht nochmals als bereits geplante Ausgabe behandelt. Ihre eigene Arbeitszeit steht ebenfalls getrennt. Wenn ein vorhandener Anschluss privat ohnehin bezahlt wird, erfassen Sie hier die durch das Websiteprojekt entstehenden Mehrkosten; für eine vollständige Haushaltsrechnung wäre die Betrachtungsgrenze eine andere.

Für Strom können Sie die Rechnung aus dem [Heimbeispiel im Kostenanhang](AN001_kosten_und_ressourcen.md#4-das-eigene-budget-an-einer-variante-prüfen) verwenden: mittlere Wattzahl geteilt durch 1.000, mal Betriebsstunden, mal Gesamtpreis je Kilowattstunde. Server, zusätzliche Firewall und gegebenenfalls Switch werden einzeln berücksichtigt. In den folgenden Mustern runden wir jede Kostenzeile auf Cent und addieren diese Beträge.

Ein späteres Angebot kann Mindestlaufzeiten, andere Verlängerungspreise oder eine fremde Währung enthalten. Rechnen Sie dann den tatsächlich betrachteten Zeitraum nach; zwölfmal der erste Monatsbetrag ist nicht automatisch die richtige Jahressumme. Ein neuer Dienst kommt nur in die Kalkulation, wenn Sie ihn wirklich wählen.

## Ausgefülltes Beispiel: eigene Hardware zu Hause

**Konstruiertes Planungsbeispiel.** Sämtliche Beträge stammen aus den Annahmen des Buchs; sie sind keine eingeholten Angebote oder Verbrauchsmessungen. Planungsdatum im Beispiel ist der 22. September 2026, vor der Servereinrichtung. Offene Angaben bleiben deshalb offen.

### Aufbau

Das Vorhaben ist eine kleine Werkstattwebsite mit Leistungen, Öffnungszeiten und einer redaktionell gepflegten Terminübersicht. Verbindliche Buchungen werden später gesondert entschieden. Daten sind zunächst Website-Dateien und die je nach Einrichtung entstehenden technischen Protokolle; Buchungsdatensätze fallen noch nicht an. Freigegebene Website-Dateien sollen nach einem Ausfall wieder verfügbar sein; für die erste Informationsseite werden höchstens 24 Stunden Unterbrechung eingeplant. Verantwortlich ist die betreuende Person, eine Vertretung für Abwesenheiten ist noch zu benennen.

Als Standort ist ein vorhandener kleiner amd64-Rechner zu Hause vorgesehen. Der erste Aufbau bleibt geschützt. Für die spätere öffentliche Website wird die Drei-Port-Netzvariante des Buchs kalkuliert, weil in diesem Beispiel passende zusätzliche Netztechnik fehlt. Der direkte öffentliche Anschlussweg ist beabsichtigt; seine Eignung muss vor einer Kauf- oder Freigabeentscheidung noch nach der Anschlussprüfung (Band 1, Kapitel 6) geklärt werden. Eine wechselnde eigene öffentliche IPv4 würde die beschriebene Adresspflege benötigen. Falls nur der Tunnelweg passt, werden dessen Bedingungen und eventuelle Mehrkosten vor der Entscheidung ergänzt.

**Kostenblatt, erstes Betriebsjahr ab Einrichtung, Euro einschließlich angenommener Steuern:**

| Position | Ansatz | Jahresbetrag |
|---|---|---:|
| Vorhandener Server | Keine neue Anschaffung; technische Eignung noch prüfen | 0,00 |
| Kabel und Zubehör | Einmaliger Ansatz | 20,00 |
| Zusätzliche Drei-Port-Firewall | Einmaliger Ansatz, kein Geräteangebot | 180,00 |
| Serverstrom | 20 W ÷ 1.000 × 8.760 h × 0,30 EUR/kWh | 52,56 |
| Firewallstrom | 8 W ÷ 1.000 × 8.760 h × 0,30 EUR/kWh | 21,02 |
| Anschlussmehrkosten | Vorläufig 0; bisheriger Anschluss muss geeignet sein | 0,00 |
| Domain | Jahresansatz | 12,00 |
| Externer Sicherungsspeicher | 12 × 5,00 EUR | 60,00 |
| Wiederherstellungsübungen | Vorhandener Ersatzrechner; zusätzlicher Strom und Medien | 20,00 |
| Zusätzlicher Versand, VPN oder weitere Dienste | Für diesen ersten Funktionsumfang nicht gewählt | 0,00 |
| **Geplante Ausgaben** | **200,00 einmalig + 145,58 laufend + 20,00 Übungen** | **365,58** |

Im Folgejahr entfallen die 180 Euro für die Firewall und die 20 Euro einmaliges Zubehör. Mit unveränderten laufenden Ansätzen und demselben Übungsbudget bleiben **165,58 Euro**. Die zusätzliche Ersatzreserve beträgt **250 Euro** und wird getrennt bereitgehalten. Muss bereits vor dem Start ein Server gekauft werden, ist dessen Kaufpreis eine zusätzliche Ausgabe; eine dafür aufgebrauchte Reserve steht anschließend nicht nochmals zur Verfügung.

Das Zeitbudget beträgt 16 Stunden Einrichtung nach der Einarbeitung, zwölfmal zwei Stunden Betreuung und vier Übungen zu je zwei Stunden: **48 Stunden im ersten Jahr**. Lernzeit, Inhalte und ungeplante Störungen kommen hinzu. Bei einem optionalen eigenen Stundenwert von 20 Euro entspräche dieser Zeitansatz 960 Euro kalkulatorischem Aufwand; er wird nicht mit der Ausgabensumme verwechselt.

Der geplante Servername lautet **web-heim**. Betriebssystem, SSH-Fassung und tatsächliche Adressen sind noch nicht erhoben. Es sind keine Containeranwendung und kein natives Board eingerichtet. Der Verbrauch von 20 Watt bleibt bis zur eigenen Messung eine Annahme.

### Zugänge

Die Verwaltung soll über den eigenen Arbeitsrechner erfolgen; der Hostschlüsselvergleich ist an der lokalen Serverkonsole vorgesehen. SSH-Schlüssel und Fingerabdruck werden bei der Einrichtung ergänzt; die Konsolenprobe ist im Beispiel noch nicht ausgeführt. Als Ablagebezeichnung für benötigte Zugangsmittel ist „Lernprojekt / Websitebetrieb“ im eigenen geschützten Speicher vorgesehen. Für dessen unabhängigen Wiederzugriff ist noch eine Lösung festzulegen.

Für den SSH-Schlüssel kann dieser Plan bereits konkreter werden: „Vorgesehen: passphrasegeschützte Schlüsselkopie auf USB A, getrennt vom Arbeitsrechner im abgeschlossenen Schrank; Passphrase im Umschlag B an einem zweiten geschützten Ort. Rückleseprobe: nicht ausgeführt.“ Das Ablagebeispiel und die Rückleseprobe in Band 1, Kapitel 4 (Band 1, Kapitel 4, Abschnitt „Ein einfaches Beispiel für die getrennte Aufbewahrung“) führen diese Variante vollständig vor. Erst die tatsächliche Probe ersetzt den offenen Eintrag durch Datum und Ergebnis. Für andere Konten und den Verlust des gesamten Wohnorts bleibt der jeweils passende Wiederzugang zusätzlich zu klären.

### Änderungen

Am Planungsdatum wurde der erste Funktionsumfang auf die Informationswebsite begrenzt. Eine verbindliche Terminverwaltung wird zurückgestellt, bis Betreuung und Datenwiederherstellung zu diesem zusätzlichen Nutzen passen. Nächste Entscheidung: Anschlussklasse und vorhandene Netztechnik vergleichen. Eine öffentliche Freigabe ist daraus nicht abgeleitet.

### Wiederherstellung

Server und Ersatzrechner gelten im Rechenfall als vorhanden; ihre tatsächliche Eignung und freie Kapazität sind noch zu prüfen. Geplant sind die Sicherung der freigegebenen Inhalte, eine externe Kopie und unabhängig zugängliche Wiederzugangsunterlagen. Speicheranbieter und Repository werden bei der Einrichtung festgelegt; Snapshot-ID und Restoreergebnis kommen nach der tatsächlichen Sicherung und Rückholprobe hinzu. Die geplanten 24 Stunden sind daher noch nicht durch eine Wiederherstellung belegt.

Das Heft würde genau an diesen offenen Entscheidungen weiterwachsen. Ein ausgefülltes Kostenblatt verlangt noch keine ausgedachten technischen Daten.

## Ausgefülltes Beispiel: selbst verwalteter Mietserver

**Konstruiertes Planungsbeispiel vom 22. September 2026, vor der Serverbereitstellung.** Die Website und ihre später gewählten Anwendungen sollen direkt auf dem Mietserver laufen. Ein Heimserver ist dafür nicht vorgesehen. Auch hier werden keine bereits ausgeführten Prüfungen behauptet.

### Aufbau

Geplant ist eine Werkstattwebsite mit Leistungen, Öffnungszeiten und redaktioneller Terminübersicht; verbindliche Buchungen sind eine spätere Erweiterung. Freigegebene Dateien sollen nach einem Ausfall wieder verfügbar sein. Hinzu kommen die je nach Einrichtung entstehenden technischen Protokolle, zunächst keine Buchungsdaten. Als vertretbare Unterbrechung sind höchstens 24 Stunden einschließlich Entdeckung und Reaktion vorgesehen. Verantwortlich ist die betreuende Person; eine Vertretung bleibt vor dem tatsächlichen Betrieb zu klären.

Der Mietweg wird gewählt, um keine eigene Serverhardware und zusätzliche Heimnetztechnik betreuen zu müssen. Linux, Webserver, Daten und Anwendungen bleiben in eigener Verantwortung.

Für den im Buch verwendeten kleinen VPS wird ein Gesamtbudget von **8 Euro je Monat einschließlich öffentlicher IPv4 und Steuer** angesetzt. Der aktuelle Endpreis und die Verfügbarkeit der benötigten Ausstattung müssen vor Bestellung im eigenen Angebot bestätigt werden. Diese Vorlage ersetzt den Angebotsvergleich aus Mietserver auswählen (Band 1, Kapitel 10) nicht.

**Kostenblatt, erstes Betriebsjahr ab Einrichtung, Euro einschließlich angenommener Steuern:**

| Position | Ansatz | Jahresbetrag |
|---|---|---:|
| VPS samt Systemdisk und öffentlicher IPv4 | 12 × 8,00 EUR | 96,00 |
| Einrichtung | Annahme ohne zusätzliche Gebühr; Angebot prüfen | 0,00 |
| Zusätzliche Heimnetztechnik und eigener Serverstrom | Für diesen Serverstandort nicht erforderlich | 0,00 |
| Domain | Jahresansatz | 12,00 |
| Externer Sicherungsspeicher | 12 × 5,00 EUR | 60,00 |
| Zeitweilige Ersatzinstanzen für Übungen | 4 × 10,00 EUR Übungsbudget | 40,00 |
| Zusätzlicher Versand, VPN oder weitere Dienste | Für diesen ersten Funktionsumfang nicht gewählt | 0,00 |
| **Geplante Ausgaben** | **0,00 einmalig + 168,00 laufend + 40,00 Übungen** | **208,00** |

Die 40 Euro bilden ein Übungsbudget, keine bereits angefallene Rechnung. Tatsächliche Laufzeit und Zusatzressourcen werden beim jeweiligen Versuch aufgenommen und danach beendet, soweit sie nicht mehr benötigt werden. Unter unveränderten Annahmen beträgt das Folgejahr ebenfalls **208 Euro**. Eine Hardware-Ersatzreserve für einen eigenen Server entfällt in diesem Beispiel; eine weitere frei verfügbare Ausgabenreserve kann nach persönlichem Bedarf ergänzt werden.

Als Zeitbudget sind 16 Stunden Einrichtung nach der Einarbeitung, zwölfmal zwei Stunden Betreuung und vier Übungen zu je zwei Stunden vorgesehen: **48 Stunden**. Lernzeit, Inhalte und ungeplante Störungen kommen hinzu. Der Standortwechsel ist keine Zusage, dass die eigenen Betriebsaufgaben weniger Zeit benötigen. Als nächste Angebotsprüfung werden Gesamtpreis, gebuchte Adressen, Nebenkosten, unabhängiger Sicherungszugang und die Bedingungen der Beendigung vorgemerkt.

Der geplante Servername lautet **web-vps**. Tatsächliche Instanzkennung, Standort, Image, Systemfassung und öffentliche Adresse werden bei der Bereitstellung ergänzt. Die zusätzliche Netzvariante zu Hause entfällt mit dieser Standortwahl; eine zusätzliche Anwendung ist noch nicht gewählt.

### Zugänge

Die Anbieteranmeldung braucht den vorgesehenen Kontoschutz und einen Wiederzugangsweg. Der unabhängige Hostschlüsselvergleich soll über die dem richtigen Server zugeordnete Anbieterkonsole erfolgen. Konto, Konsole und Fingerabdruck sind vor der Bereitstellung noch nicht geprüft.

Im Betriebsheft stehen später nur die neutralen Ablagebezeichnungen „Lernprojekt / Anbieter“, „Lernprojekt / Domain“ und „Lernprojekt / Sicherung“. Die geheimen Inhalte bleiben in der dafür vorgesehenen Aufbewahrung. Dass mehrere Einträge existieren, belegt noch keinen unabhängigen Zugriff bei Ausfall des Arbeitsrechners.

Für den persönlichen SSH-Schlüssel lässt sich derselbe konkrete USB-/Umschlagplan wie im Heimbeispiel verwenden. Die Rückleseprobe aus Band 1, Kapitel 4 (Band 1, Kapitel 4, Abschnitt „Die Kopie einmal zurücklesen“) gehört deshalb auch zu diesem Weg. Ein lesbarer Schlüssel allein öffnet noch kein gesperrtes Anbieterkonto; dessen Wiederherstellung einschließlich Mehrfaktorschutz wird gesondert vorbereitet und geprüft.

### Änderungen

Die Standortentscheidung ist auf den direkt genutzten VPS gefallen. Im Jahresbudget wurden öffentliche IPv4, externes Sicherungsziel und Ersatzübungen gesondert berücksichtigt. Vor der Bestellung bleiben die aktuellen Gesamtpreise und der Wiederzugang offen. Es wurde weder ein Server bestellt noch eine Freigabe eingerichtet.

### Wiederherstellung

Der geplante Ersatz ist ein zeitweise bereitgestellter leerer VPS mit eigener Kennung. Zur Wiederherstellung soll die externe Kopie ohne Rückgriff auf den ausgefallenen Originalserver genügen. Ob Server und Speicher am selben Anbieteraccount hängen, ist vor Auswahl festzuhalten; eine dadurch gemeinsam gefährdete Kopie deckt den Verlust dieses Accounts nicht ab. Die gesonderte Kopie und die Schlüsselaufbewahrung folgen der Sicherungsanleitung (Band 1, Kapitel 18).

Repository, ausgewählter Snapshot, enthaltenes Datendatum und gemessene Wiederanlaufzeit werden bei der Einrichtung und Rückholprobe erfasst. Bei einer späteren Parallelprobe erhalten Ersatz und Quelle getrennte Meldeziele und den vorgesehenen getrennten Probe-Sicherungsbereich. Der Ersatz übernimmt den produktiven Zeitplan erst nach der bewussten Betriebsübernahme; der vollständige Ablauf steht unter Wiederherstellung und Betriebsroutine (Kapitel 10, Abschnitt „Die Sicherungsroutine am Ersatz wieder aufnehmen“).

## Wenn aus der Planung ein laufender Betrieb wird

Ergänzen Sie die tatsächlichen Werte an der vorhandenen Stelle. Eine zunächst offene Serveradresse wird nach Einrichtung ersetzt; ein geänderter Datenverlustbedarf bekommt eine begründete neue Fassung. Unter „Änderungen“ bleibt nur die für den späteren Rückweg hilfreiche Vorgeschichte stehen. So enthält „Aufbau“ den aktuellen Stand und die Chronik erklärt, wie er zustande kam.

Die folgende Auswahl zeigt, welche Angaben je nach gewähltem Modul dazukommen. Sie ist keine Liste weiterer Pflichtinstallationen. Für eine statische Website entfallen Anwendung, Datenbank und Containerkonto.

| Gewählter Bestandteil | Im bestehenden Heft ergänzen | Vollständiger Lernort |
|---|---|---|
| Heimnetz | Genau eine gewählte Netzvariante, Rollen-/Portzuordnung, Verwaltungsweg und Ablage der eigenen Geräteexporte; Switchexport bei VLAN mitführen | Drei-Port-Aufbau (Band 1, Kapitel 7) oder VLAN-Variante (Band 1, Kapitel 8) |
| Öffentlicher Webzugang | Eigene Namen, DNS-Zuständigkeit, Ziel und TLS-Endpunkt, verwendete IP-Familien; beim Tunnel Vermittler und Ursprung getrennt | Domain und HTTPS (Band 1, Kapitel 20), Außenprüfung (Band 1, Kapitel 26) |
| Dynamische IPv4 oder zusätzlich IPv6 | Zuständiger Aktualisierer, betroffene Namen und letzte tatsächliche Wechselprobe; bei IPv6 aktueller Präfix, Geräteteil und getrennte AAAA-Pflege | Dynamischer Heimzugang (Band 1, Kapitel 21), IPv4 und IPv6 (Band 1, Kapitel 25) |
| Journal oder Terminverwaltung | Nur gewählte Anwendung, Programm-/Imagefassung, Daten-/Dateiumfang, Exporte und Zeitgeber. Bei eigener Terminrezeptur auch Imagearchiv, Prüfsumme, Image-ID, Plattform, ursprüngliche Referenz, Datenzeitpunkt und Bauquellen. Eigene Prüfergebnisse nach BL08 dem tatsächlich verwendeten Stand zuordnen. | Journal (Kapitel 6), Terminverwaltung (Kapitel 7), Sicherung und Freigabe (Kapitel 10) |
| Natives Aufgabenboard | Programm-/PHP-Fassung, private Daten, Dienst/Tageslauf und frisches Exportpaket. Beim Umzug finaler Stand und tatsächlich angehaltene Quelle. | Nativer Anwendungsbetrieb (Kapitel 3), Standortwechsel (Kapitel 19) |
| Extern betreute Buchung | Gewählter Dienst, Datenexport, Verantwortlichkeiten und Kündigung. Diese Daten gehören nicht automatisch zur Sicherung des eigenen Servers. | Anwendungswahl (Kapitel 7), Dienstleister und Datenorte (Band 1, Kapitel 19) |
| Private Fernverwaltung | Gewählte Geräte, Adressen, Richtlinienablage, Ablauf und unabhängige Konsole; am Ersatz eigene Geräteidentität | Privater Verwaltungsweg (Band 1, Kapitel 28) |
| Zeitreihen und Alarmierung | Konfigurationsablage, wirklicher Alarmempfänger, letzte Empfangs-/Ausbleibeprobe und eigene Meldeziele paralleler Systeme. Keine geheimen Ping-URLs einfügen. | Messhistorie und Alarmierung (Kapitel 12) |
| Testbereitstellung und KI-Labore | Eigener Teststand, Rollen, geänderte Dateien, Ergebnis und beendete Ressourcen. Keine Zugangsmittel oder fremden Protokolldaten übernehmen. | Geprüfte Bereitstellung (Kapitel 15), Begrenzte Agenten (Kapitel 16) |

Für Dienstleister-, Namens- und Außenprüfungen können Sie die kurzen Notizen am jeweiligen Lernort in denselben passenden Heftbereich übernehmen. Die ausführlichen Fragen müssen hier nicht ein zweites Mal beantwortet werden. Begriffe, Konten und Standardpfade finden Sie im Nachschlageanhang (im Buchanhang „Begriffe, Befehle und Betriebswege zum Nachschlagen“); hier halten Sie Ihre davon abhängigen eigenen Werte fest.

### Ein späterer Eintrag, der eine Entscheidung erklärt

Auch ein fehlgeschlagener Versuch kann eine gute Notiz ergeben. Das folgende **vollständig konstruierte Beispiel** zeigt die Form einer Störungsnotiz. Es behauptet keinen ausgeführten Serverversuch.

~~~markdown
### Restoreprobe am 22.09.2026, 14:00–14:25 UTC — konstruiertes Beispiel

Anlass: Den gesicherten Website-Stand auf einem getrennten Ersatz öffnen.
Beobachtung: Der Versuch stoppt an der Passwortabfrage. Das benötigte
Passwort ist während der Probe nicht über die unabhängige Ablage erreichbar.
Der Versuch endet vor der eigentlichen Wiederherstellung.

Entscheidung: Die Wiederherstellung ist für diesen Stand nicht nachgewiesen.
Keine öffentliche Freigabe aus diesem Versuch ableiten.
Den vorhandenen Originalserver unverändert weiter geschützt betreiben.

Nächster Schritt: Zugang zur vorgesehenen unabhängigen Aufbewahrung klären,
danach denselben Sicherungsstand erneut auf dem Ersatz prüfen.
Keine Passwortwerte in diese Notiz kopieren.

Ressourcen: Der vorbereitete Ersatz ist noch vorhanden. Vor Ende der Sitzung
entscheiden, ob er für die Wiederholung benötigt wird; aktive Kosten erfassen.
Die 25 Minuten sind die Dauer des abgebrochenen Versuchs, keine Wiederanlaufzeit.
~~~

Die Notiz hält Beobachtung, Schlussfolgerung und nächsten Schritt auseinander. Sie enthält weder eine pauschale Erfolgsmeldung noch die Vermutung, eine andere Anwendungsversion werde das Problem lösen. Für eine tatsächlich ausgeführte spätere Probe ergänzen Sie das beobachtete Ergebnis und die dafür verwendeten eigenen Kennungen.

## Bei Änderungen und Übergaben verwenden

Nach einem erfolgreichen Aufbau muss das Heft nicht ständig länger werden. Halten Sie die aktuellen Zuständigkeiten, Pfade und Wiederzugänge nach; ergänzen Sie größere Änderungen mit Datum und Rückweg. Ein Betreiberwechsel oder ein neuer Sicherungsspeicher ist ein Anlass, diese Angaben zu prüfen. Eine unveränderte Routine braucht keinen täglichen Abschriftbericht.

Vor einem Standortwechsel helfen die Fragen aus Umzug und Datenrückweg (Kapitel 19): Welche Quelle darf noch schreiben, welcher Stand wird übernommen, und ab wann besitzt das Ziel neuere Daten? Nach einem Sicherheitsverdacht ist zuerst die Vorfallentscheidung (Kapitel 18) maßgeblich. Ein vollständiges Heft ersetzt diese unterschiedliche Beurteilung der Ausgangslage nicht.

Beim Umzug halten Sie außerdem Vorprobe und endgültiges Ziel mit ihren Projektnamen, Volumes und lokalen Ports auseinander. Die Zuordnung und der gemeinsame Zielimport (Kapitel 19, Abschnitt „Den endgültigen Datenstand übernehmen“) führen durch diesen Übergang; dieselben Regeln gelten beim VPS-Anbieterwechsel.

Für Umzug oder Abschlussprobe genügt im vorhandenen Wiederherstellungsabschnitt eine klare Zuordnung: ausgewählter externer Stand, jetzt aktiver Server, Zeitpunkt erster neuer Zieldaten und Zustand des Sicherungsplans. Halten Sie bei einer Pause fest, ob noch die Quelle oder bereits der Ersatz den Betrieb führt. Beim späteren Fortsetzen wird der aktuelle Zielbestand dadurch nicht versehentlich durch einen älteren Import ersetzt.

Für eine Übergabe genügt ein Durchgang durch die vier Bereiche: aktuelle Aufgaben und Grenzen, nutzbare Wiederzugänge, letzte wesentliche Änderung, tatsächlich beobachtete Wiederherstellung. Besprechen Sie offene Punkte ausdrücklich. Eine fremde Person muss dafür keine interne Projektkennung des Buchs kennen.

Wenn Sie eine bereinigte Fassung mit einer zweiten Person oder einer KI besprechen, entfernen Sie Kontokennungen, interne Adressen, Vertragsdetails und identifizierbare Betriebsdaten, soweit diese für die Frage nicht gebraucht werden. Die Originalfassung bleibt in Ihrer eigenen geschützten Ablage. Die vorhandene [Planungsgegenprüfung mit und ohne KI](AN001_kosten_und_ressourcen.md#eine-freiwillige-gegenprüfung-mit-ki) kann offene Annahmen ordnen; sie benötigt keinen Zugriff auf Ihren Server.

Für eine gewählte Terminverwaltung führt [BL08](BL08_terminreferenz_abnahme.md) durch die zugehörigen Testfälle. Übernehmen Sie deren Ergebnisse mit Softwarestand und Datum in denselben Wiederherstellungsabschnitt.

Die Vorlage steht Ihnen ohne zusätzliches Konto oder Abonnement als Markdown zur Verfügung. Quellen und weiterführende Links zu den Anleitungen bleiben im gemeinsamen [Quellenverzeichnis](BL07_quellen_und_links.md). Die Beispiele und Rechenannahmen dieser Arbeitsdatei führen keine neuen Produkt- oder Tarifempfehlungen ein.

## Ergänzung für Band 2: nur eingerichtete Anwendungen aufnehmen

Führen Sie das bisherige Betriebsheft weiter. Die folgenden Felder ergänzen vorhandene Angaben; unverwendete Module bleiben leer. Speichern Sie Geheimnisse weiterhin separat und vermerken Sie hier nur deren geschützten Ablageort.

| Bestandteil | Eigener Stand |
|---|---|
| Gewählter Weg | Natives Board, CMS, Termine, Kombination oder statischer Vertiefungsweg |
| Laufzeit und Programmstand | Tatsächliche Version, Bezugsquelle, Wartungszeitraum |
| Konto, Dienst und Verzeichnisse | Tatsächlich zuständiger Benutzer, Unit beziehungsweise Compose-Projekt, Datenort |
| Dauerhafte Daten | Datenbank und zugehörige Dateien/Uploads |
| Sicherung | Konsistenter Export, externe Snapshot-ID und letzter tatsächlicher Wiederanlauf |
| Versand und Hintergrundaufgaben | Eingerichtete Rollen, Zeitgeber und empfangene Testnachricht |
| Änderung und Rückweg | Gesicherter Ausgang, notwendige Schreibpause, Freigabe neuer Daten |
| Fachliche Probe | Erwarteter Beitrag, Aufgabe oder Termin; Datum und Ergebnis |
| Offene Prüfung | Konkrete Lücke, zuständige Person, nächster Schritt |

Für die Datei- und Maildienste aus Band 3 führen Sie dieselben Bereiche weiter. Die dort eingerichteten Datenorte, Nutzkonten und Versandwege erhalten eigene Einträge; bestehende Webrollen werden dadurch nicht zu allgemeinen Dateinutzern oder Postfachkonten. Nehmen Sie jeweils erst den tatsächlich eingerichteten Umfang und seine geprüften Rückwege auf.

Bei einer Übergabe benennen Sie genau einen aktiven Sicherungs- und Meldeverantwortlichen je Dienst. Kopierte Probeinstanzen erhalten eigene Prüfziele. Für einen Terminbestand ordnen Sie den Parallelprüfbericht dem tatsächlichen Software- und Konfigurationsstand zu; eine alte Bestätigung gilt nicht automatisch für einen veränderten Aufbau.
