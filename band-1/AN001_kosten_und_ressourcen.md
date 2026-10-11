# Kosten und Ressourcen im Detail

Dieser Anhang ergänzt die kurze Planung aus Kapitel 2 (Anforderungen, Aufwand und Kosten planen). Lesen Sie die Abschnitte, die Sie für eine Auswahl oder eine Rechnung benötigen. Die ausführlichen Herleitungen bleiben hier verfügbar, während der Haupttext zügig zur ersten eigenen Seite führt.

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

## 2. Die beiden Jahresbudgets im Detail

Die Rechnung betrachtet die erste statische Website einschließlich Sicherung und Wiederherstellungsübungen. Alle Budgetwerte sind eigene Annahmen für tatsächlich zu zahlende Endbeträge, soweit ein einzelner datierter Quellenwert ausdrücklich anders bezeichnet ist. Übernehmen Sie vor einem Kauf oder Vertrag Ihre eigenen Preise und Steuerverhältnisse. Wir rechnen mit zwölf Monaten und 8.760 Betriebsstunden.

Für beide Standorte reservieren wir 12 Euro im Jahr für die Domain und 60 Euro für einen externen Sicherungsspeicher. Die spätere Anleitung verwendet eine Storage Box als konkretes SFTP-Ziel; die 60 Euro sind ein Budget und kein zugesagter aktueller Tarif. Eine getrennt aufbewahrte Kopie am Arbeitsrechner bleibt als zusätzliche Rückfallebene erhalten. Zusätzliche Medien, Speicher oder kostenpflichtige Alarmkanäle werden bei Bedarf ergänzt.

### Fall A: Ein vorhandener Rechner zu Hause

Ein vorhandener Rechner kann den Einstieg in den Heimweg erleichtern. Welche Geräte infrage kommen, hängt von ihrer Ausstattung und den Betriebsanforderungen ab. Die folgende Übersicht verbindet typische Möglichkeiten mit den wichtigsten Auswahlfragen:

| Möglicher Rechner | Was Sie bei der Planung berücksichtigen sollten |
|---|---|
| **Raspberry Pi 5** | Ein kleiner Einplatinencomputer, bei dem die wesentlichen Bauteile auf einer Platine sitzen. Zum vollständigen Aufbau gehören auch ein passendes Netzteil, ein Datenträger sowie eine geeignete Lösung für Gehäuse und Kühlung. Rechnen Sie deshalb mit den Kosten des gesamten Aufbaus.[\[4\]][Q0032] |
| **Mini-PC oder kompakter Bürorechner** | Eine Möglichkeit, wenn der Server wenig Platz beanspruchen soll. Prüfen Sie beim konkreten Modell, ob Arbeitsspeicher, SSD und Netzwerkanschluss zu Ihrem Vorhaben passen und welche Erweiterungen möglich sind. |
| **Älterer Laptop** | Ein vorhandenes Gerät bringt Bildschirm und Tastatur für die Einrichtung bereits mit. Für den Serverbetrieb sind insbesondere Kühlung und Energiespareinstellungen zu prüfen: Die Website soll auch erreichbar bleiben, wenn niemand am Gerät arbeitet oder der Deckel geschlossen ist.[\[5\]][Q0033] |
| **Älterer Desktop-PC** | Kann eine vorhandene Ausstattung weiter nutzbar machen und bietet je nach Gehäuse Platz für zusätzliche Laufwerke. Beziehen Sie Strombedarf, Geräuschentwicklung und den Zustand der Bauteile in die Entscheidung ein. |

Den späteren Installationsweg im Buch zeigen wir an einem PC mit **x86-64-Prozessor**, wie er in vielen Intel- und AMD-Rechnern steckt. Der Raspberry Pi 5 verwendet dagegen **ARM**. Diese Namen bezeichnen unterschiedliche Prozessorarchitekturen: Betriebssystem und Programme müssen zur jeweiligen Architektur und zum Gerät passen.[\[4\]][Q0032][\[5\]][Q0033] Die genauere Auswahl behandeln wir in Kapitel 5 (Eigene Hardware passend auswählen) „Eigene Hardware passend auswählen“.

Im Rechenfall steht ein geeigneter Rechner für den Dauerbetrieb zur Verfügung; für Wiederherstellungsübungen kann zeitweise ein zweites geeignetes Gerät genutzt werden. Beide dürfen für das Projekt verwendet werden. Eine Neuanschaffung ist damit zunächst nicht erforderlich.

Der vorhandene Internetanschluss bleibt im Beispiel unverändert. Wir erfassen daher nur die **zusätzlichen Ausgaben durch das Projekt** und rechnen die bereits anfallende Anschlussgebühr nicht nochmals vollständig der Website zu. Ein erforderlicher Tarifwechsel oder Vermittlungsdienst würde mit seinen Mehrkosten in die Rechnung eingehen.

Zum Anschluss gehört außerdem die Frage, wie Besucher Ihre Website erreichen. Eine **IP-Adresse** ist eine numerische Adresse im Netzwerk. Eine **feste öffentliche IP-Adresse** vereinfacht die Zuordnung des Domainnamens zum Internetanschluss. Zwingend erforderlich ist eine unveränderliche Adresse jedoch nicht: Bei einer wechselnden öffentlichen Adresse kann **dynamisches DNS** die Zuordnung des Namens automatisch nachführen.[\[6\]][Q0029] Nach einem Wechsel können vorübergehend noch alte Zuordnungen verwendet werden, weil diese zwischengespeichert werden.[\[7\]][Q0031]

Entscheidend bleibt, ob die vorgesehenen Verbindungen den Server tatsächlich erreichen können. Einschränkungen im Netz des Internetanbieters lassen sich durch eine Namensaktualisierung allein nicht beheben.[\[8\]][Q0030] Die Anschlussprüfung in Kapitel 6 (Heimnetz und Internetanschluss verantwortbar vorbereiten) und die Veröffentlichungskapitel führen durch diese Entscheidung. Für Ihre erste Planung genügt es, mögliche Zusatzkosten zu kennen; einen Tarifwechsel oder Gerätekauf müssen Sie jetzt noch nicht auslösen.

### Den gesamten Heimaufbau einplanen

Für den geschützten Heim-Einstieg stehen der Gastbereich sowie zwei Ausführungen des getrennten Firewallaufbaus zur Verfügung. Besitzt Ihr Router einen geeigneten kabelgebundenen Gastbereich, nutzen Sie zunächst diesen; Kapitel 6 (Heimnetz und Internetanschluss verantwortbar vorbereiten) zeigt das an einer FRITZ!Box 7590 AX. Fehlt er, beschreibt Kapitel 7 (Das getrennte Heimnetz einrichten) den Einstieg über eine eigene Firewall vor der Linux-Installation; Kapitel 8 (Vorhandene Netztechnik mit VLANs weiterverwenden) ergänzt deren VLAN-Variante auf geeigneter vorhandener Hardware. Ein bestimmtes Gastnetz ist damit keine Voraussetzung für den Heimweg. Vor einer Anschaffung prüfen Sie zuerst, ob vorhandene Netztechnik die benötigte Trennung bereits leisten kann. Die ausführlich beschriebene Referenz des Buches verwendet eine Zusatzfirewall; daraus folgt keine allgemeine Kaufpflicht.

Den Lernserver richten wir zunächst ohne öffentliche Website ein. Dieser geschützte Einstieg gibt Ihnen Zeit, Ihren Rechner und den Verwaltungszugang kennenzulernen. Spätestens vor dem öffentlichen Heimaufbau trennen wir Server, Arbeitsrechner und übriges Privatnetz. Im konkreten Buchbeispiel übernimmt das eine zusätzliche kleine Firewall mit drei Netzwerkanschlüssen; vorhandene geeignete Netztechnik kann diese Aufgabe ebenfalls erfüllen, benötigt aber eine Prüfung ihrer tatsächlichen Trennung. Wer damit beginnt, behält diesen Aufbau später bei und spart sich den Netzumzug aus dem Gastbereich.

Die folgende Übersicht dient als Wegweiser für die Planung. Die technische Einrichtung folgt erst an ihrem jeweiligen Lernort.

| Gewählter Weg | Was vor der Veröffentlichung dazukommt | Bedeutung für Ihr Budget |
|---|---|---|
| Heimserver, direkt erreichbar | Eigene nutzbare öffentliche IPv4; bei wechselnder Adresse DDNS nach Kapitel 21 (Den Heimanschluss mit dynamischem DNS erreichbar halten), bei fester Adresse ohne Aktualisierer; getrenntes Netz nach Kapitel 7 (Das getrennte Heimnetz einrichten) oder Kapitel 8 (Vorhandene Netztechnik mit VLANs weiterverwenden), Übernahme in Kapitel 22 (Die Website über den Heimanschluss veröffentlichen) | Eventuelle Anschlussmehrkosten und tatsächlich noch fehlende Netztechnik samt Strombedarf |
| Heimserver, ausgehender Tunnel | Derselbe getrennte Serverbereich; zusätzlich ein Vermittlungsdienst nach Kapitel 23 (Den Heimserver über einen ausgehenden Tunnel veröffentlichen). Keine feste öffentliche Anschlussadresse nötig | Netztechnik und gegebenenfalls Vermittlungstarif; ein zusätzlicher gemieteter Website-Server ist nicht erforderlich |
| Direkt genutzter VPS | Anbieterzugang, öffentliche Adresse und die gewählten Ressourcen nach Kapitel 10 (Mietserver, Konto und Kostenrahmen auswählen)/Kapitel 11 (VPS geschützt bereitstellen und erstmals betreten) | Servermiete und gebuchte Zusatzleistungen; keine zusätzliche Heim-Firewall für den VPS |

Dynamisches DNS ist mit Kapitel 21 (Den Heimanschluss mit dynamischem DNS erreichbar halten) ein vollständig beschriebener direkter Buchweg. Eine feste öffentliche Adresse spart dessen Aktualisierer; beide Varianten benötigen einen geeigneten Anschluss und dieselbe Netztrennung. Falls Ihr Anschluss dafür ungünstig ist, bleibt der Tunnelweg eine eigenständige Möglichkeit. Website und Anwendungsdaten liegen dabei weiterhin auf Ihrem Heimserver.

Die folgende Rechnung umfasst den **vollständigen vorgesehenen öffentlichen Heimaufbau**: den vorhandenen Server, eine noch anzuschaffende Zusatzfirewall, Sicherung und Übungen. Für die Firewall setzen wir frei angenommene 180 Euro Anschaffung und 8 Watt mittlere Leistungsaufnahme an. Diese Werte sind keine Geräteempfehlung. Sie machen den zusätzlichen Posten sichtbar, bevor wir ihn technisch einrichten.

Für die Stromkosten nehmen wir an, dass unser Heimserver im laufenden Betrieb durchschnittlich **20 Watt an der Steckdose** aufnimmt. Damit erfassen wir den gesamten Rechner einschließlich der Verluste seines Netzteils. Mit diesem Beispielwert können wir nun berechnen, was ein Jahr Dauerbetrieb kostet.

Für Ihre eigene Planung messen Sie später den Verbrauch Ihres Rechners über einen Zeitraum, der seine typische Nutzung abbildet. Je nach Gerät, Ausstattung und Auslastung kann der Durchschnitt deutlich niedriger oder höher liegen. Gerade bei einem älteren Desktop-PC oder einem größeren System lohnt sich diese Messung, bevor Sie ihn rund um die Uhr betreiben. Wie sich höhere Werte auf das Budget auswirken, sehen wir gleich im Anschluss.

Leistung in Watt beschreibt den momentanen Bedarf. Multipliziert mit der Betriebszeit erhalten Sie Energie in Wattstunden; durch 1.000 geteilt ergibt sie **Kilowattstunden**, kurz **kWh**. Diese Energiemenge wird mit dem Preis je kWh verrechnet.[\[9\]][Q0026] Für das Beispiel sind sowohl die 20 Watt als auch 0,30 Euro je kWh Annahmen:

**0,020 kW × 24 Stunden × 365 Tage = 175,2 kWh pro Jahr.**

**175,2 kWh × 0,30 Euro/kWh = 52,56 Euro pro Jahr.**

| Position | Ansatz für das erste Jahr | Grundlage |
|---|---:|---|
| Bereits vorhandener Serverrechner | 0,00 Euro zusätzliche Anschaffung | Annahme: geeignet und verfügbar |
| Kabel und kleines Zubehör | 20,00 Euro einmalig | Budgetannahme |
| Serverstrom | 52,56 Euro laufend | Berechnung mit angenommenen Werten |
| Zusätzliche Firewall | 180,00 Euro einmalig | Budgetannahme für noch fehlende Netztechnik |
| Strom der zusätzlichen Firewall | 21,02 Euro laufend | 0,008 kW × 8.760 Stunden × 0,30 Euro/kWh, gerundet |
| Mehrkosten des Internetanschlusses | 0,00 Euro | Annahme: bisheriger Anschluss genügt |
| Domainname | 12,00 Euro laufend | Budgetannahme |
| Unabhängiges Sicherungsziel | 60,00 Euro laufend | 12 × 5,00 Euro, Budgetannahme |
| Wiederherstellungsübungen | 20,00 Euro für das Jahr | Budget für zusätzlichen Strom und gegebenenfalls Medien; Ersatzrechner bereits verfügbar |
| **Summe öffentlicher Heimaufbau** | **365,58 Euro** | **Einschließlich Zusatzfirewall, Zubehör und Übungsbudget** |

Für einen späteren Defekt oder den anderweitigen Bedarf am vorhandenen Rechner halten wir zusätzlich **250 Euro als angenommene Ersatzreserve** bereit. Diese Mittel bleiben verfügbar, bis Ersatz benötigt wird; sie zählen daher nicht zu den bereits angesetzten Jahresausgaben. Der Betrag ist eine Planungsannahme und kein geprüftes Geräteangebot.

Wären die 250 Euro bereits zu Beginn für einen Rechner auszugeben, stiege das erste Jahresbudget auf 615,58 Euro. Zusätzlich wäre wieder eine Reserve für einen späteren Defekt aufzubauen. Anschaffung und Ersatzvorsorge sind daher getrennt zu planen.

Wie stark der Serververbrauch die Summe verändert, zeigt dieselbe Rechnung mit zwei anderen Annahmen. Die Zusatzfirewall bleibt in allen drei Fällen mit 8 Watt und 180 Euro Anschaffung enthalten:

| Mittlere Serverleistung | Serverstrom pro Jahr | Gesamter Heimaufbau im ersten Jahr |
|---|---:|---:|
| 20 Watt | 52,56 Euro | **365,58 Euro** |
| 40 Watt | 105,12 Euro | **418,14 Euro** |
| 100 Watt | 262,80 Euro | **575,82 Euro** |

Das sind Rechenvarianten, keine Messwerte bestimmter Geräte. Ist die zusätzliche Firewall bereits vorhanden, entfallen in diesem Modell 180 Euro Neuanschaffung; mit ihren weiterhin angesetzten Stromkosten verbleiben 185,58 Euro. Kann dagegen ein ohnehin laufender geeigneter Router die erforderliche Trennung übernehmen, können Anschaffung **und zusätzlicher** Geräteverbrauch entfallen. Unter genau dieser Annahme wären es 164,56 Euro. Ein Mehrverbrauch durch die neue Aufgabe wird dabei nicht pauschal ausgeschlossen, sondern nach Möglichkeit gemessen.

Die günstigere Variante setzt dieselben nachgewiesenen Netzgrenzen voraus. Ein Server im ungetrennten Privatnetz wäre kein gleichwertiger Aufbau. Kapitel 8 (Vorhandene Netztechnik mit VLANs weiterverwenden) ergänzt eine konkret beschriebene weitere Ausführung mit OPNsense auf einem Ein-Port-Rechner und einem verwaltbaren Switch; andere Geräte benötigen weiterhin ihre passende Konfiguration und Prüfung. Zusätzlicher Anschlusstarif oder kostenpflichtiger Vermittlungsdienst werden bei Bedarf als weitere Posten ergänzt.

### Rechenvariante mit vorhandener VLAN-Ausstattung

Für den Aufbau aus Kapitel 8 (Vorhandene Netztechnik mit VLANs weiterverwenden) nehmen wir an, dass sowohl ein geeigneter Firewallrechner als auch der passende verwaltbare Switch bereits vorhanden, bisher aber ausgeschaltet sind. Für beide fällt kein neuer Kaufpreis an. Als **freie Rechenannahmen** setzen wir 25 Watt für den Firewallrechner und 5 Watt für den Switch an, jeweils als mittlere Aufnahme an der Steckdose. Das sind keine gemessenen Werte eines Buchgeräts und keine Übernahme einer Hersteller-Maximalangabe.

Zusammen entstehen 30 Watt zusätzlicher Dauerverbrauch: **0,030 kW × 8.760 Stunden × 0,30 Euro = 78,84 Euro im Jahr**. Die übrigen Positionen des ursprünglichen Heimbeispiels einschließlich Website-Server bleiben bei 164,56 Euro. Daraus werden **243,40 Euro im ersten Jahr**. Fehlende Kabel oder eine notwendige Neuanschaffung würden hinzukommen; die angenommenen 20 Euro Zubehör müssen für den eigenen Aufbau ausreichen.

Dieser Fall spart die angesetzte Neuanschaffung, benötigt aber mehr Strom als die angenommene kleine Drei-Port-Firewall. Im Folgejahr entfallen beim ursprünglichen Aufbau die 180 Euro für die Firewall und die 20 Euro einmaliges Zubehör; es bleiben **165,58 Euro**. Bei der VLAN-Variante entfällt nur das einmalige Zubehör, sodass **223,40 Euro** bleiben. Strom, Domain, Sicherung und jährliches Übungsbudget sind dabei unverändert angesetzt. Bereits vorhanden bedeutet deshalb nicht automatisch auf Dauer günstiger. Läuft ein geeigneter Switch ohnehin, unterscheiden Sie seine ohnehin anfallenden Kosten vom gemessenen Mehrverbrauch durch das Websiteprojekt.

Die Beispiele vergleichen denselben Schutzbedarf bei verschiedener Ausstattung. Zusätzliche Reserveports, eine zweite Firewall oder eine umfangreiche Bürosegmentierung gehören zu einem weitergehenden Bedarf und nicht pauschal zu jeder kleinen Website.

### Fall B: Derselbe Hetzner-VPS wie im Einrichtungsweg

Für die Einordnung verwenden wir **Hetzner Cloud CX23**: Die Produktseite nennt 2 vCPU, 4 GB RAM und 40 GB NVMe-Speicher. Das entspricht unserem kleinen x86-Einstieg. Die Anbieterbezeichnung GB wird unverändert übernommen; 4 GiB wären eine andere Mengenangabe. Verfügbarkeit und Eignung für später hinzugefügte Anwendungen prüfen Sie vor der Bestellung.[\[10\]][Q0425]

Die am 20. September 2026 gelesene Preistabelle nennt für Deutschland und Finnland seit dem 15. Juni 2026 **5,49 Euro monatlich beziehungsweise 0,0088 Euro je Stunde**, jeweils **ohne Umsatzsteuer und ohne IPv4**. Dieser Wert erklärt die Größenordnung, ist jedoch noch kein vollständiger persönlicher Endpreis.[\[11\]][Q0426] Für unser Jahresbudget setzen wir ausdrücklich angenommene **8 Euro im Monat für Server und eine öffentliche IPv4 zusammen** ein. Die Budgetannahme schließt die anfallenden Steuern ein. Zeigt Ihr Angebot einen höheren Endbetrag, erhöhen Sie das Budget entsprechend.

| Position | Erstes Jahr | Grundlage |
|---|---:|---|
| VPS samt Systemdisk und öffentlicher IPv4 | 96,00 Euro | 12 × 8 Euro, Budgetannahme |
| Einrichtung | 0,00 Euro | Annahme, im Bestellvergleich bestätigen |
| Domain | 12,00 Euro | Budgetannahme |
| Unabhängiger Sicherungsspeicher | 60,00 Euro | Budgetannahme |
| Zeitweilige Ersatzinstanzen für vier Übungen | 40,00 Euro | 4 × 10 Euro, Budgetannahme |
| **Summe** | **208,00 Euro** | **Erstes Betriebsjahr im Rechenmodell** |

Hetzner berechnet den Server nach angefangenen Nutzungsstunden bis zur monatlichen Obergrenze. Auch ein ausgeschalteter Server wird weiter berechnet; die Abrechnung endet erst mit seiner Löschung. Eine gesonderte Primary IPv4 ist beim Abschluss ebenfalls zu berücksichtigen.[\[12\]][Q0427][\[13\]][Q0428]

Mit den angenommenen Einzelsätzen aus Kapitel 10 (Mietserver, Konto und Kostenrahmen auswählen) — 0,012 Euro je Serverstunde bis 7 Euro monatlich sowie 0,002 Euro je IPv4-Stunde bis 1 Euro — kosten 48 abgerechnete Stunden innerhalb eines Monats 0,672 Euro vor Rundung. Vier solche Übungen ergeben rechnerisch rund 2,69 Euro. Die Reserve von 40 Euro lässt Raum für längere Versuche oder eine andere Ersatzkonfiguration. Weitere kostenpflichtige Ressourcen werden zusätzlich erfasst. Eine Monatsgrenze teilt die Rechnung in zwei Abrechnungsabschnitte.

### Den Vergleich einordnen

| Erstes Jahr | Eigene Hardware | Mietserver |
|---|---:|---:|
| Ausgaben einschließlich Sicherung und Übungen | **365,58 Euro** | **208,00 Euro** |
| Zusätzlich verfügbare Hardware-Ersatzreserve | 250,00 Euro | In diesem Beispiel nicht erforderlich |
| Tragende Annahme | Geeigneter Rechner und Ersatzgerät vorhanden, Firewall wird gekauft | Kleiner Hetzner-VPS, monatlich 8 Euro Budget samt IPv4 |

Ein vorhandener Firewallrechner spart im Heimfall die angenommenen 180 Euro Anschaffung. Ein nötiger anderer Internetvertrag erhöht dessen Kosten. Beim VPS ändern ein größerer Tarif oder zusätzlicher Speicher die Rechnung. Der Vergleich hilft Ihnen deshalb vor allem, fehlende Positionen im eigenen Vorhaben zu erkennen.

## 3. Wie viel Betreuung Sie einplanen sollten

Neben den Ausgaben bestimmt die verfügbare Arbeitszeit, ob sich der Dienst verlässlich betreuen lässt. Sie beeinflusst sowohl den laufenden Betrieb als auch die erreichbaren Wiederherstellungszeiten.

Einmalige Arbeit fällt beim Vorbereiten, Einrichten und Dokumentieren an. Regelmäßig kommen Updates, die Kontrolle von Sicherungen und die Prüfung wichtiger Funktionen hinzu. Eine Störung folgt dagegen keinem monatlichen Termin. Sie benötigt möglicherweise mehrere zusammenhängende Stunden, gerade dann, wenn Sie sie schlecht erübrigen können.

Für eine eigene erste Kalkulation können Sie beispielsweise **16 Stunden Einrichtung nach der Einarbeitung**, **zwei Stunden laufende Betreuung pro Monat** und **vier Wiederherstellungsübungen zu je zwei Stunden** eintragen. Zusammen sind das **48 Stunden im ersten Jahr**. Es handelt sich um ein selbst gesetztes Zeitbudget für eine kleine Website. Lernzeit, Inhaltserstellung und ungeplante Störungen kommen hinzu; die Zahlen sind keine gemessenen Durchschnittswerte oder Zusage, dass Sie damit auskommen.

Die Arbeit verteilt sich bei den beiden Wegen unterschiedlich. Zu Hause müssen Sie auch Hardware, Stromversorgung und Anschluss prüfen. Beim Mietserver kümmern Sie sich unter anderem um Anbieterzugang, Vertragsressourcen und mögliche Rettungswege. Betriebssystem, Webserver und eigene Inhalte bleiben bei beiden Wegen in Ihrer Verantwortung.

Für einen wirtschaftlichen Vergleich können Sie die eigene Arbeitszeit mit einem Stundenwert ansetzen. Bei angenommenen 20 Euro pro Stunde entsprechen die 48 Stunden **960 Euro**. Dieser kalkulatorische Wert ist von tatsächlichen Ausgaben zu unterscheiden. Er hilft jedoch zu beurteilen, ob ein teureres Angebot durch enthaltene Betreuung einen Teil der eigenen Arbeit sinnvoll ersetzen kann.

Auch Ausfallfolgen lassen sich als Szenario notieren. Nehmen wir an, bei einer späteren Buchungsanwendung müssten nach einem Ausfall sechs Vorgänge telefonisch nachgearbeitet werden, jeweils zehn Minuten. Das ergibt eine Stunde Zusatzarbeit. Ob darüber hinaus Termine entfallen oder Kunden abspringen, können wir aus der Serverbeschreibung nicht ableiten. Solche Folgen brauchen eigene Annahmen und dürfen nicht als sichere Einsparung verkauft werden.

Bei einem Lernprojekt ist die eigene Arbeit Teil des angestrebten Nutzens. Eine betriebswichtige Werkstattwebsite erfordert darüber hinaus eine Person, die bei Störungen erreichbar und handlungsfähig ist. Diese Verfügbarkeit muss zusätzlich zum monatlichen Wartungsaufwand organisiert werden.

Vor der Einführung verbindlicher Buchungen empfehle ich deshalb, Funktionsumfang und Betriebszusagen erneut mit der tatsächlich verfügbaren Betreuung abzugleichen. Solange wesentliche Zuständigkeiten ungeklärt sind, bietet die Informationswebsite einen sinnvollen ersten Projektabschluss.

Wenn Sie die Website nutzen möchten, aber wenig Zeit für ihre technische Betreuung haben, können Sie einen Teil der Arbeit abgeben. Kapitel 12 (Mit Linux arbeiten und die erste Seite abrufen) zeigt dafür ein konkretes Webhosting-Angebot mit betreuter Systembasis. Für eine optionale spätere Terminplanung stellt Band 2, Kapitel 6 (Eine bereitgestellte Webanwendung übernehmen) sowohl ein fertiges Drittanbieterpaket für einen eigenen Server als auch eine vollständig betreut angebotene Anwendung vor. Vergleichen Sie jeweils, welche Aufgaben tatsächlich enthalten sind; die eigene Website und eine extern betreute Buchungsseite lassen sich auch verbinden.

## 4. Das eigene Budget an einer Variante prüfen

### Ein Fall zum Weiterdenken

Verändern wir unsere Werkstattwebsite in zwei Punkten: Die Informationsseiten sollen zunächst nur einmal im Monat aktualisiert werden. Eine spätere Buchungsfunktion wäre jedoch für den täglichen Betrieb wichtig und müsste auch während Ihres Urlaubs betreut werden. Zur Verfügung stehen weiterhin zwei Stunden regelmäßige Wartung pro Monat; eine Vertretung ist nicht benannt.

Begründen Sie, welchen Funktionsumfang Sie unter diesen Bedingungen zuerst freigeben würden und was vor der Buchungsfunktion geklärt sein müsste. Unterscheiden Sie dabei technische Kapazitätsgrenzen von fehlenden Zuständigkeiten. Variieren Sie anschließend einen Kostenansatz und berechnen Sie die Auswirkung auf das Jahresbudget.

Eine begründete Lösung kann beim statischen Informationsangebot beginnen. Seine Inhalte lassen sich als freigegebener Dateistand vorbereiten und separat sichern. Für die verbindliche Buchungsfunktion bleibt zunächst die Betreuung während Abwesenheiten offen. Mehr CPU oder RAM ersetzt diese Zuständigkeit nicht. Erst wenn Betreuung, Datenhaltung und Wiederherstellung zur Bedeutung der Buchungen passen, ist die Erweiterung verantwortbar geplant.

Für den rechnerischen Teil könnten Sie den angenommenen Strompreis von 0,30 auf 0,40 Euro je kWh ändern. Der Preis gilt für Server **und** Zusatzfirewall: Aus 175,2 kWh werden **70,08 Euro Serverstrom**, aus 70,08 kWh weitere **28,03 Euro Firewallstrom**. Das vollständige erste Jahresbudget beträgt dann **390,11 Euro**. Alternativ erhöht ein zusätzlich nötiger Anschlusstarif für 15 Euro pro Monat den ursprünglichen vollständigen Heimfall um **180 Euro auf 545,58 Euro**. Beide Varianten verändern jeweils nur die ausdrücklich genannte Voraussetzung.

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

Die ergänzte Notiz bildet die Grundlage für Hardware- und Tarifauswahl. Sie hält Anforderungen, Kostenannahmen und offene Bedingungen zusammen, sodass sich spätere Angebote daran prüfen und Änderungen gezielt nachrechnen lassen.

Übertragen Sie die für Ihr Vorhaben passenden Werte in den knappen Budgetplan aus Kapitel 2 (Anforderungen, Aufwand und Kosten planen). Die übrigen Varianten dienen Ihnen später als Vergleich, wenn sich Anschluss, Hardware oder Funktionsumfang ändern. Eine [kopierbare Arbeitsfassung mit leerem Kostenblatt und zwei ausgefüllten Standortbeispielen](BL01_betriebsheft_anforderungen_und_kosten.md) steht ergänzend zur Verfügung. Die Werte gehören in Ihr bestehendes Betriebsheft; ein zweiter Budgetstand ist nicht nötig.

## Zusätzliche private Fernverwaltung

Der optionale Weg aus Kapitel 28 (Den Webserver unterwegs privat verwalten) benötigt keinen zweiten VPS und keine zusätzliche Heimhardware. Er ergänzt jedoch einen externen VPN-Dienst. Dessen kostenloser Personal-Tarif war beim Abruf am 20.09.2026 auf nichtkommerzielle Nutzung beschränkt; die konkrete Tarifprüfung steht mit Quelle in Kapitel 28 (Den Webserver unterwegs privat verwalten). Für eine reale Werkstatt ist daher ein geeigneter geschäftlicher Vertrag zu kalkulieren.

Ergänzen Sie im eigenen Jahresbudget den tatsächlich vereinbarten VPN-Gesamtbetrag. Bei gleichbleibender monatlicher Abrechnung lautet die eigene Rechnung **12 × monatlicher Gesamtbetrag**; berücksichtigen Sie bezahlte Nutzerplätze, Mindestmengen, Steuern und Zahlungswährung aus Ihrem Angebot. Die bisherigen Beispielbudgets enthalten diesen optionalen Betrag noch nicht. Ein kostenloser Testzeitraum ist kein Jahrespreis. Wer nur am bisherigen Verwaltungsplatz arbeitet, benötigt diese zusätzliche Leistung für den Buchgrundaufbau nicht.

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
