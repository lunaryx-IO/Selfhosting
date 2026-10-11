# Kosten und Ressourcen im Detail

Ihr Websitebetrieb hat bereits einen Kostenrahmen. Dieser Anhang hilft Ihnen, den zusätzlichen Bedarf von Anwendungen, Probeumgebungen und Automatisierung damit abzugleichen. Die Grundlagen zur Ausstattung bleiben zum Nachschlagen enthalten. In der [Erweiterungsrechnung](#2-den-vorhandenen-betrieb-und-die-erweiterung-zusammen-rechnen) führen Sie den bisherigen Bedarf und die zusätzlich benötigten Ressourcen zusammen. Das ursprüngliche Standortbeispiel aus Band 1, Kapitel 2 (Anforderungen, Aufwand und Kosten planen) dient weiterhin als Vergleich.

## 1. Welche Ressourcen tatsächlich gebraucht werden

Serverangebote beschreiben ihre Ausstattung vor allem durch Prozessorressourcen, Arbeitsspeicher, Datenträger und Netzwerkanbindung. Diese Größen beeinflussen unterschiedliche Aufgaben. Ihre Bewertung beginnt deshalb beim Arbeitsablauf der Website: Welche Inhalte werden ausgeliefert, welche Daten verarbeitet und welche Änderungen gespeichert?

### Prozessor und Arbeitsspeicher

Die **CPU**, ausgeschrieben *Central Processing Unit*, führt als Prozessor die Anweisungen der laufenden Programme aus. Bei einer Website entstehen solche Aufgaben unter anderem durch die Verarbeitung von Anfragen und die Erzeugung von Seiteninhalten. Mehrere Prozessorkerne können Aufgaben parallel bearbeiten, sofern die Software und der jeweilige Ablauf dies zulassen.

Eine **vCPU** ist eine virtuelle Verarbeitungseinheit, die der Anbieter einer virtuellen Maschine zuordnet. Wie viel Rechenzeit ihr tatsächlich zur Verfügung steht, hängt auch vom Ressourcenmodell ab. Bei geteilten CPU-Angeboten nutzen mehrere Kunden dieselben physischen Rechenressourcen; bei ausdrücklich dedizierten Angeboten wird Rechenkapazität exklusiv zugeordnet. Entscheidend ist der zugesagte Leistungsumfang. Hetzner unterscheidet diese Modelle beispielsweise in seiner Serverdokumentation.[\[1\]][Q0015]

Aus der Anzahl der vCPUs allein lässt sich die Leistung eines VPS nicht zuverlässig mit der eines Heimrechners oder eines anderen VPS vergleichen. Neben dem Ressourcenmodell beeinflussen die Prozessorfamilie und die anfallenden Aufgaben die Leistung. Softwarekompatibilität und konkrete Ausstattung prüfen wir bei der Hardware- beziehungsweise Tarifauswahl im jeweiligen Betriebsweg.

Der **Arbeitsspeicher**, meist **RAM** genannt, hält Daten und Programmzustände bereit, mit denen das System gerade arbeitet. Sein Inhalt bleibt bei gewöhnlichem RAM ohne Strom nicht erhalten. Linux nutzt Arbeitsspeicher außerdem, um bereits gelesene Dateiinhalte zwischenzuspeichern. Das kann wiederholte Datenträgerzugriffe vermeiden. Eine Anzeige mit wenig völlig ungenutztem RAM bedeutet daher noch nicht automatisch einen Mangel.[\[2\]][Q0025]

Entscheidend ist, ob die laufenden Aufgaben ausreichend Speicher bekommen. Unter starkem Speicherdruck muss das System Platz zurückgewinnen; bei erschöpftem Speicher können Prozesse beendet werden. Eine größere SSD gleicht fehlenden Arbeitsspeicher nicht einfach aus.[\[2\]][Q0025]

Die statische Werkstattwebsite benötigt vor allem die Auslieferung vorbereiteter Dateien. Mit einer Terminverwaltung kommen die laufende Anwendung und gegebenenfalls eine Datenbank hinzu. Dadurch ändern sich Rechen- und Speicherbedarf. Für die Dimensionierung zählt daher neben der Anzahl der Zugriffe auch deren Art: Wenige aufwendige Verarbeitungsschritte können das System stärker beanspruchen als viele einfache Dateiaufrufe.

### Speicherplatz und Ein-/Ausgabe

Der **Datenträger** speichert Betriebssystem, Programme und Dateien dauerhaft. Eine SSD verwendet dafür elektronische Speicherbausteine. Für die Auswahl sind sowohl die verfügbare Kapazität als auch die Lese- und Schreibleistung relevant.

Lese- und Schreibvorgänge gehören zur **Ein-/Ausgabe**, häufig mit **I/O** für *Input/Output* abgekürzt. Dazu zählen beispielsweise das Laden eines Bildes, das Speichern einer Buchung und das Zurückschreiben einer Sicherung. Viele kleine Zugriffe stellen andere Anforderungen an den Datenträger als das Lesen einer großen zusammenhängenden Datei. Die Kapazität allein erlaubt deshalb keine Aussage über die Geschwindigkeit dieser Abläufe.

Für die Kapazitätsplanung unterscheiden wir Betriebssystem, Anwendungsdaten und Arbeitsreserve. Als Rechenmodell nehmen wir 10 GB für Betriebssystem und Programme, 2 GB für Website-Dateien, 3 GB für Protokolle und vorübergehende Dateien sowie 5 GB Spielraum für Änderungen an. Daraus ergeben sich 20 GB. Es handelt sich um geschätzte Planwerte, keine gemessenen Anforderungen einer bestimmten Installation.

Bei einem Datenträger mit nominell 40 GB bleibt damit zunächst Kapazität für weitere Arbeiten. Der tatsächlich nutzbare Platz hängt unter anderem von der Einrichtung des Datenträgers ab. Außerdem muss der Platzbedarf beim Wiederherstellen separat betrachtet werden: Sollen ein entpackter Sicherungsstand und neue Arbeitsdateien gleichzeitig vorliegen, können zusätzliche Kapazitäten nötig werden.

Ein Sicherungsziel benötigt zusätzliche Kapazität und muss bei einem Ausfall des ursprünglichen Datenträgers verfügbar bleiben. Eine Sicherung ausschließlich auf derselben SSD erfüllt diese Anforderung nicht. Wir budgetieren deshalb ein getrenntes Sicherungsziel.

### Was GB, GiB und Mbit/s bedeuten

Bei Größenangaben lohnt sich ein genauer Blick auf die Einheit. Ein **Byte** besteht aus acht **Bit**. Im Buch verwenden wir **MB** für eine Million Byte und **GB** für eine Milliarde Byte. **GiB**, gesprochen Gibibyte, bezeichnet dagegen 1.073.741.824 Byte. Beispielsweise entsprechen 4 GiB rund 4,29 GB. Beide Schreibweisen sind gebräuchlich, aber nicht gleichbedeutend.[\[3\]][Q0024]

Übernehmen Sie die Einheit eines Angebots zunächst unverändert und klären Sie mehrdeutige Angaben vor dem Vergleich. Ein mit „4 GB“ beworbener Tarif wird in unserer Rechnung entsprechend als 4 GB geführt; eine Kapazität von 4 GiB müsste gesondert belegt sein.

Im Netzwerk bezeichnet **Bandbreite** hier die mögliche Datenübertragungsrate. **Mbit/s** steht für Millionen Bit pro Sekunde. Das **Transfervolumen** gibt dagegen die innerhalb eines Zeitraums übertragene Datenmenge an, beispielsweise 50 GB im Monat. Anbieter verwenden dafür häufig die Bezeichnung **Traffic**. Bei einem Tarifvergleich sind Übertragungsrate und enthaltenes Transfervolumen getrennt zu prüfen.

Für unsere Website ist vor allem interessant, wie schnell der Server Daten an Besucher senden kann. Zu Hause nutzt er dafür den **Upload** des Internetanschlusses. Ein Anschluss mit hohem Downloadwert kann einen deutlich kleineren Upload besitzen. Die tatsächlich verfügbare Übertragungsrate und andere gleichzeitige Nutzungen müssen später am Anschluss betrachtet werden.

Rechnen wir mit angenommenen 20 Mbit/s Upload. Geteilt durch acht ergeben sich theoretisch 2,5 MB pro Sekunde. Die reine Übertragung von 2 MB würde damit unter idealisierten Bedingungen 0,8 Sekunden benötigen. Protokollaufwand, Verbindungsaufbau, Wartezeiten und das Darstellen im Browser sind darin noch nicht enthalten. Aus dieser Rechnung folgt keine zugesicherte Seitenladezeit.

Für die Monatsmenge setzen wir im Beispiel 10.000 vollständige Abrufe zu jeweils 2 MB an:

**10.000 × 2 MB = 20.000 MB = 20 GB.**

Gemeint sind vollständige Übertragungen des angenommenen Seitenumfangs, keine gezählten Personen. Wiederholte Aufrufe, Suchmaschinen und weitere Zugriffe können die Menge erhöhen; im Browser wiederverwendete Dateien können sie verringern. Auch Sicherungen und Downloads verursachen Übertragungen. Wir wählen für das Beispiel deshalb ein vorläufiges Datenbudget von 50 GB pro Monat und prüfen die tatsächliche Nutzung später.

Die übertragene Datenmenge ist auch eine Stellgröße für die Optimierung. Unnötig große Bilder erhöhen den Umfang jedes vollständigen Abrufs und belasten die verfügbare Übertragungsrate. Zusätzliche CPU-Ressourcen verringern diese Datenmenge nicht. Vor einer Erweiterung des Servers prüfen wir deshalb, welcher Teil des Ablaufs die Leistung tatsächlich begrenzt.

## 2. Den vorhandenen Betrieb und die Erweiterung zusammen rechnen

Der Server aus Band 1 bleibt die Grundlage. Übernehmen Sie dessen tatsächliches Jahresbudget in Ihr Betriebsheft, bevor Sie zusätzliche Anwendungen oder Labore einplanen. Rechnen Sie Server beziehungsweise gemessenen Stromverbrauch, Domain, unabhängige Sicherung und eingerichtete externe Dienste weiter. Ein neues Anwendungsprojekt macht diese bisherigen Kosten nicht entbehrlich.

Für eine Erweiterung ergänzen Sie die tatsächlich zusätzlich benötigten Ressourcen: Speicher für Datenbank und Uploads, passende Laufzeitreserven, Export- und Restorekopien, eventuelle Diensttarife und Betreuungszeit. Eine Begrenzung des Arbeitsspeichers ist keine Messung des normalen Verbrauchs. Ebenso wenig bedeutet ein kostenloses Programm, dass sein Betrieb keinen Aufwand verursacht.

Bei einer vorübergehenden zusätzlichen Testinstanz erfassen Sie Laufzeit, IP-Adressen, Speicher und Enddatum gesondert. Nach Abschluss wird deren Freigabe nach Kapitel 16 (Ressourcen ändern, retten und geordnet beenden) geprüft. Ein ausgeschalteter Mietserver ist kein Nachweis für beendete Kosten. Die historischen Anschaffungs- und Jahresbeispiele stehen bei Bedarf in Band 1, Kapitel 2 (Anforderungen, Aufwand und Kosten planen); für Ihre aktuelle Entscheidung zählt das vorliegende Angebot.

## 3. Wie viel Betreuung Sie einplanen sollten

Neben den Ausgaben bestimmt die verfügbare Arbeitszeit, ob sich der Dienst verlässlich betreuen lässt. Sie beeinflusst sowohl den laufenden Betrieb als auch die erreichbaren Wiederherstellungszeiten.

Einmalige Arbeit fällt beim Vorbereiten, Einrichten und Dokumentieren an. Regelmäßig kommen Updates, die Kontrolle von Sicherungen und die Prüfung wichtiger Funktionen hinzu. Eine Störung folgt dagegen keinem monatlichen Termin. Sie benötigt möglicherweise mehrere zusammenhängende Stunden, gerade dann, wenn Sie sie schlecht erübrigen können.

Für eine eigene erste Kalkulation können Sie beispielsweise **16 Stunden Einrichtung nach der Einarbeitung**, **zwei Stunden laufende Betreuung pro Monat** und **vier Wiederherstellungsübungen zu je zwei Stunden** eintragen. Zusammen sind das **48 Stunden im ersten Jahr**. Es handelt sich um ein selbst gesetztes Zeitbudget für eine kleine Website. Lernzeit, Inhaltserstellung und ungeplante Störungen kommen hinzu; die Zahlen sind keine gemessenen Durchschnittswerte oder Zusage, dass Sie damit auskommen.

Die Arbeit verteilt sich bei den beiden Wegen unterschiedlich. Zu Hause müssen Sie auch Hardware, Stromversorgung und Anschluss prüfen. Beim Mietserver kümmern Sie sich unter anderem um Anbieterzugang, Vertragsressourcen und mögliche Rettungswege. Betriebssystem, Webserver und eigene Inhalte bleiben bei beiden Wegen in Ihrer Verantwortung.

Für einen wirtschaftlichen Vergleich können Sie die eigene Arbeitszeit mit einem Stundenwert ansetzen. Bei angenommenen 20 Euro pro Stunde entsprechen die 48 Stunden **960 Euro**. Dieser kalkulatorische Wert ist von tatsächlichen Ausgaben zu unterscheiden. Er hilft jedoch zu beurteilen, ob ein teureres Angebot durch enthaltene Betreuung einen Teil der eigenen Arbeit sinnvoll ersetzen kann.

Auch Ausfallfolgen lassen sich als Szenario notieren. Nehmen wir an, bei einer späteren Buchungsanwendung müssten nach einem Ausfall sechs Vorgänge telefonisch nachgearbeitet werden, jeweils zehn Minuten. Das ergibt eine Stunde Zusatzarbeit. Ob darüber hinaus Termine entfallen oder Kunden abspringen, können wir aus der Serverbeschreibung nicht ableiten. Solche Folgen brauchen eigene Annahmen und dürfen nicht als sichere Einsparung verkauft werden.

Bei einem Lernprojekt ist die eigene Arbeit Teil des angestrebten Nutzens. Eine betriebswichtige Werkstattwebsite erfordert darüber hinaus eine Person, die bei Störungen erreichbar und handlungsfähig ist. Diese Verfügbarkeit muss zusätzlich zum monatlichen Wartungsaufwand organisiert werden.

Vor der Einführung verbindlicher Buchungen empfehle ich deshalb, Funktionsumfang und Betriebszusagen erneut mit der tatsächlich verfügbaren Betreuung abzugleichen. Solange wesentliche Zuständigkeiten ungeklärt sind, bietet die Informationswebsite einen sinnvollen ersten Projektabschluss.

Wenn Sie die Website nutzen möchten, aber wenig Zeit für ihre technische Betreuung haben, können Sie einen Teil der Arbeit abgeben. Band 1, Kapitel 12 (Mit Linux arbeiten und die erste Seite abrufen) zeigt dafür ein konkretes Webhosting-Angebot mit betreuter Systembasis. Für die spätere Terminplanung stellt Kapitel 6 (Eine bereitgestellte Webanwendung übernehmen) sowohl ein fertiges Drittanbieterpaket für einen eigenen Server als auch eine vollständig betreut angebotene Anwendung vor. Vergleichen Sie jeweils, welche Aufgaben tatsächlich enthalten sind; die eigene Website und eine extern betreute Buchungsseite lassen sich auch verbinden.

## 4. Das eigene Budget an einer Variante prüfen

### Ein Fall zum Weiterdenken

Verändern wir unsere Werkstattwebsite in zwei Punkten: Die Informationsseiten sollen zunächst nur einmal im Monat aktualisiert werden. Eine spätere Buchungsfunktion wäre jedoch für den täglichen Betrieb wichtig und müsste auch während Ihres Urlaubs betreut werden. Zur Verfügung stehen weiterhin zwei Stunden regelmäßige Wartung pro Monat; eine Vertretung ist nicht benannt.

Begründen Sie, welchen Funktionsumfang Sie unter diesen Bedingungen zuerst freigeben würden und was vor der Buchungsfunktion geklärt sein müsste. Unterscheiden Sie dabei technische Kapazitätsgrenzen von fehlenden Zuständigkeiten. Variieren Sie anschließend einen Kostenansatz und berechnen Sie die Auswirkung auf das Jahresbudget.

Eine begründete Lösung kann beim statischen Informationsangebot beginnen. Seine Inhalte lassen sich als freigegebener Dateistand vorbereiten und separat sichern. Für die verbindliche Buchungsfunktion bleibt zunächst die Betreuung während Abwesenheiten offen. Mehr CPU oder RAM ersetzt diese Zuständigkeit nicht. Erst wenn Betreuung, Datenhaltung und Wiederherstellung zur Bedeutung der Buchungen passen, ist die Erweiterung verantwortbar geplant.

Für den rechnerischen Teil greifen wir auf das Heimbeispiel aus Band 1, Kapitel 2, Abschnitt 3 — Band 1, Kapitel 2 (Anforderungen, Aufwand und Kosten planen) zurück: 20 Watt für den vorhandenen Server und 8 Watt für die Zusatzfirewall ergeben bei ganzjährigem Betrieb 175,2 beziehungsweise 70,08 kWh. Bei 0,30 Euro je kWh beträgt das vollständige erste Jahresbudget einschließlich der dort aufgeführten Anschaffungen und Dienste 365,58 Euro.

Verändern Sie nun ausschließlich den angenommenen Strompreis von 0,30 auf 0,40 Euro je kWh. Der Preis gilt für Server **und** Zusatzfirewall: Aus 175,2 kWh werden **70,08 Euro Serverstrom**, aus 70,08 kWh weitere **28,03 Euro Firewallstrom**. Das vollständige erste Jahresbudget beträgt dann **390,11 Euro**. Alternativ erhöht ein zusätzlich nötiger Anschlusstarif für 15 Euro pro Monat den ursprünglichen vollständigen Heimfall um **180 Euro auf 545,58 Euro**. Beide Varianten verändern jeweils nur die ausdrücklich genannte Voraussetzung.

### Eine freiwillige Gegenprüfung mit KI

Ein Textassistent kann Ihre Notiz auf Lücken prüfen oder Angebotspositionen sortieren. Nutzen Sie dafür ausschließlich bereinigte Angaben. Es genügen allgemeine Datenarten, neutrale Rollen und veröffentlichte Preise; Kontodaten, Vertragsnummern, Zugangsmittel und echte Kundendaten gehören nicht in die Eingabe.

Der folgende Prompt kann mit einem verfügbaren Assistenten verwendet werden. Ein kostenpflichtiges Abonnement oder Zugriff auf Ihren Server ist dafür nicht nötig.

```text
Prüfen Sie meine Planung für eine kleine selbst verwaltete Website.
Nutzen Sie ausschließlich die folgenden Angaben. Erfinden Sie keine Preise,
enthaltenen Leistungen, Vertragsbedingungen oder Leistungszusagen.

Erster Funktionsumfang: [Beschreibung]
Spätere Erweiterungen: [Beschreibung]
Betriebsweg und vorhandene Mittel: [Beschreibung]
Datenarten, Verlustgrenze und Ausfalldauer: [bereinigte Angaben]
Betreuung und Vertretung: [neutrale Rollen und verfügbare Zeiten]
Kostenpositionen mit Einheit und Zeitraum: [bereinigte Liste]
Quelle, Abrufdatum und Steuerdarstellung je Angebot: [Angaben]
Eigene Annahmen und offene Fragen: [Liste]

1. Ordnen Sie Anschaffung, laufende Kosten und Reserven getrennt.
2. Zeigen Sie Jahresrechnung und Zahlungszeitpunkte nachvollziehbar.
3. Benennen Sie fehlende Angaben zu Sicherungen, zeitweiligem Ersatz,
   Zusatzressourcen und Beendigung des Vertrags.
4. Prüfen Sie, ob Funktionen, Wiederherstellungsziele und Betreuung
   zusammenpassen. Kennzeichnen Sie jede unbelegte Annahme.
5. Nennen Sie die drei offenen Fragen mit der größten Auswirkung.
Führen Sie keine Bestellung oder Änderung an einem System aus.
```

Prüfen Sie die Antwort anschließend an Ihrer eigenen Rechnung und an den Angebotsseiten. Besonders aufschlussreich ist, ob der Assistent Jahresbindung und Stundenabrechnung auseinanderhält und eine Budgetreserve als solche behandelt. Ein rechnerisch korrektes Ergebnis bleibt unbrauchbar, wenn ihm ein erfundener Leistungsumfang zugrunde liegt.

Ohne KI können Sie dieselben fünf Schritte selbst oder mit einer zweiten Person durchgehen. Markieren Sie zuerst die Herkunft jedes Werts, rechnen Sie die Summen nach und lesen Sie danach nur die offenen Bedingungen. So erkennen Sie, welche davon die Standort- oder Funktionsentscheidung verändern könnten.

Die ergänzte Notiz verbindet Ihren bestehenden Betrieb mit der geplanten Erweiterung. So erkennen Sie, welche zusätzlichen Ressourcen und Betreuungsaufgaben tatsächlich hinzukommen und ob die bisherigen Angebote weiterhin passen.

Führen Sie mit den passenden Werten den vorhandenen Budgetplan aus Band 1, Kapitel 2 (Anforderungen, Aufwand und Kosten planen) fort. Die übrigen Varianten dienen Ihnen später als Vergleich, wenn sich Anschluss, Hardware oder Funktionsumfang ändern. Eine [kopierbare Arbeitsfassung mit leerem Kostenblatt und zwei ausgefüllten Standortbeispielen](BL01_betriebsheft_anforderungen_und_kosten.md) steht ergänzend zur Verfügung. Die Werte gehören in Ihr bestehendes Betriebsheft; ein zweiter Budgetstand ist nicht nötig.

## Zusätzliche private Fernverwaltung

Der optionale Weg aus Band 1, Kapitel 28 (Den Webserver unterwegs privat verwalten) benötigt keinen zweiten VPS und keine zusätzliche Heimhardware. Er ergänzt jedoch einen externen VPN-Dienst. Dessen kostenloser Personal-Tarif war beim Abruf am 20.09.2026 auf nichtkommerzielle Nutzung beschränkt; die konkrete Tarifprüfung steht mit Quelle in Band 1, Kapitel 28 (Den Webserver unterwegs privat verwalten). Für eine reale Werkstatt ist daher ein geeigneter geschäftlicher Vertrag zu kalkulieren.

Ergänzen Sie im eigenen Jahresbudget den tatsächlich vereinbarten VPN-Gesamtbetrag. Bei gleichbleibender monatlicher Abrechnung lautet die eigene Rechnung **12 × monatlicher Gesamtbetrag**; berücksichtigen Sie bezahlte Nutzerplätze, Mindestmengen, Steuern und Zahlungswährung aus Ihrem Angebot. Die bisherigen Beispielbudgets enthalten diesen optionalen Betrag noch nicht. Ein kostenloser Testzeitraum ist kein Jahrespreis. Wer nur am bisherigen Verwaltungsplatz arbeitet, benötigt diese zusätzliche Leistung für den Buchgrundaufbau nicht.

## Ressourcen der optionalen nativen Anwendung

Das Aufgabenboard aus Kapitel 2 (Eine Anwendung verstehen und ohne Container betreiben) verwendet denselben vorhandenen Server und den bestehenden Sicherungsspeicher. Es verlangt keinen zusätzlichen VPS und keinen weiteren öffentlichen Domainnamen. Es beansprucht jedoch eigene Rechenleistung, Speicher und Betreuungszeit.

Die dort gewählten Dienstgrenzen betragen 384 MiB für PHP-FPM und 256 MiB für den täglichen Aufgabenlauf. Bei gleichzeitiger Ausführung ergeben diese beiden Vorgaben rechnerisch **640 MiB**. Das ist weder ein gemessener Verbrauch noch die gesamte Serverauslastung: Betriebssystem, Caddy und gegebenenfalls weitere Anwendungen kommen hinzu. Eine höhere Zahl zulässiger PHP-Prozesse vergrößert die Dienstgrenze nicht automatisch.

Beim freien Datenträgerplatz berücksichtigen Sie Programmreleases, Anhänge, Datenbank, das vollständige lokale Exportpaket und die Rückhol-/Rückwegkopien einer Restoreübung. Ein erfolgreich entpacktes kleines Programmarchiv belegt nicht, dass für diese späteren Kopien genügend Platz bleibt. Prüfen Sie vor der Übung die tatsächlichen Bestandsgrößen und den freien Speicher. Wer das Board nur als Lerngegenmodell benötigt, beendet es nach dem vollständigen Ablauf; eine dauerhafte zusätzliche Anwendung ist keine Buchvoraussetzung.

## Ressourcen der zusätzlichen Messhistorie

Der lokale Weg aus Kapitel 11 (Messreihen speichern und sinnvoll alarmieren) verwendet den vorhandenen Server. Für seine wenigen Ziele sind etwa 1 GiB RAM-Reserve und 2 GiB zusätzlicher lokaler Platz als Planungsannahmen vorgesehen; tatsächlicher Verbrauch wird nach Einrichtung kontrolliert. 14 Tage und 512 MB begrenzen die Zeitreihenaufbewahrung, nicht als harte Dateisystemquote den Gesamtbedarf aller Schreibdaten.

Ein zusätzlicher Healthchecks-Prüfpunkt und Alarmmails nutzen vorhandene Anbieter; deren Tarifplätze und gemeinsame Versandgrenzen müssen reichen. Die alternative betreute Sammlung und ihre aktuellen Tarif-/Datenbedingungen stehen am Lernort. Keiner dieser Zusatzbedarfe ist bereits als gemessener Verbrauch in den ursprünglichen Kostenbeispielen enthalten.

## Ressourcen der begrenzten Last- und Cacheübung

Kapitel 12 (Leistung messen und gezielt verbessern) verwendet einen eigenen Debian-Lernstand mit ausschließlich synthetischen Daten. Eine anfängliche Reserve von 512 MiB verfügbarem RAM und 100 MiB freiem lokalen Platz ist eine Buchannahme. Die beiden vorübergehenden Prozesse erhalten gesonderte Grenzen: Caddy 25 Prozent einer CPU/256 MiB RAM, Lastwerkzeug 50 Prozent einer CPU/128 MiB RAM. Diese Obergrenzen sind kein gemessener Normalverbrauch und keine Empfehlung für die öffentliche Website. Das Paket benötigt keinen zusätzlichen Apache-Webdienst, Tarif oder Monitoringaccount.

Die Sitzung umfasst höchstens 720 Lastanfragen und bleibt mit Vorbereitungs-/Inhaltsabrufen unter 800. Bei 512 KiB Ausgangsinhalt liegt die entsprechende unkomprimierte Menge unter 400 MiB; der Versuch überträgt die komprimierte Fassung lokal. Er misst weder Heimupload noch öffentliche VPS-Leistung. Ist der vorhandene Server bereits produktiv, gehört eine getrennte eigene Testinstallation zur Planung. Deren tatsächliche Bereitstellungs- und eventuelle Mietkosten sind vorab zu klären; aus dem Buchauftrag entsteht keine Bestellung.

## Ressourcen des optionalen Agentenlabors

Das Agentenlabor aus Kapitel 15 (Automatisierung und begrenzte KI-Agenten) verwendet vorhandene geeignete Testhardware oder einen bereits bewusst eingeplanten eigenen Test-VPS. Es begründet keinen zusätzlichen Kauf und kein Pflichtabonnement. Prüfen Sie vor der Modellvorbereitung, ob der Testrechner genügend freie Ressourcen besitzt. Die dort angesetzten 16 GiB freie Platte und 4 GiB Gesamtspeicher sind Planungsreserven für Archiv, Entpacken, Modell und Betriebssystem; die einzelne Agentenausführung bleibt zusätzlich auf 2 GiB RAM, eine CPU und acht Minuten begrenzt. Das ist keine gemessene Leistungszusage.

Ein lokales Modell verursacht weiterhin Rechenzeit, Stromverbrauch beziehungsweise VPS-Laufzeit und Pflegeaufwand. Seine Übertragungs- und Speichergröße folgt dem konkret gewählten Stand. Beenden Sie einen nur dafür angelegten Mietserver nach Sicherung der benötigten Ergebnisse einschließlich seiner Nebenressourcen. Die im Kapitel vollständig beschriebene manuelle Lösung benötigt weder Modellbestand noch Modellserver. Für wiederholte echte Konfigurationen bleibt das vorhandene Ansible-Verfahren aus Kapitel 14 (Konfiguration wiederholbar herstellen und Änderungen geprüft bereitstellen) die gepflegte Alternative.

[Q0015]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0025]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0024]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0032]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0033]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0029]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0031]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0030]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0026]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0425]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0426]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0427]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail
[Q0428]: BL07_quellen_und_links.md#anhang-kosten-und-ressourcen-im-detail


## Ressourcen der wiederholbaren Bereitstellung

Kapitel 14 (Konfiguration wiederholbar herstellen und Änderungen geprüft bereitstellen) verwendet einen frisch vorbereiteten eigenen Testserver, ein zusätzliches Konto und zeitlich begrenzte lokale Webdienste. Eine Anwendungsdatenbank, ein Container-Daemon und ein externer CI-Vertrag sind dafür nicht erforderlich. Der Steuerknoten läuft auf demselben Debian-Testsystem. Ein geeigneter vorhandener Rechner kann diese Rolle übernehmen; bei einem zusätzlichen VPS fallen dessen tatsächliche Laufzeit und Nebenressourcen an.

100 MiB freier Platz sind im Kapitel eine eigene anfängliche Reserve für die kleinen Dateien und Prüfläufe, keine gemessene Mindestanforderung einschließlich aller Pakete. Mehrere aufbewahrte Kandidaten und Protokolle belegen weiteren Platz. Prüfen Sie Paketbedarf und freie Ressourcen vor Beginn, stoppen Sie die Laborinstanzen nach der Sitzung und planen Sie den Ressourcenabschluss ein. Wer später eine CI-Plattform wählt, muss Runner, Speicherung, Betreuung und gegebenenfalls Tarif gesondert einrechnen.
