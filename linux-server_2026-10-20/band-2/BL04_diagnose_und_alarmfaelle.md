# Drei Störungen verstehen und gezielt eingrenzen

**Zugehörige Manuskriptfassung:** Linux-Server – Das umfassende Praxisbuch, Band 2, Markdown-Stand vom 20. Oktober 2026. Die einzelnen Quellen behalten ihre angegebenen Prüfdaten.

**Für beide Betriebswege · optionale Übungen zur Diagnose**  
**Ursprünglicher Text- und Quellenstand der Übungen:** 22. September 2026.

Eine Website kann bei Ihnen funktionieren und bei einem Besucher stocken. Ein grüner Monitor kann den Ausfall eines Dienstes übersehen. Und eine besonders schnelle Antwort kann genau die Information enthalten, die inzwischen falsch geworden ist. Solche Beobachtungen wirken zunächst widersprüchlich. Verständlich werden sie, sobald wir genauer fragen, **welcher Weg zu welchem Zeitpunkt tatsächlich beobachtet wurde**.

Die drei Fälle knüpfen an die Werkstattwebsite an. Sie brauchen dafür weder einen laufenden Server noch ein zusätzliches Konto. Alle Angaben, Zeiten und Ergebnisse sind **didaktisch konstruiert**; es handelt sich nicht um aufgezeichnete Störungen oder bereits bestandene Versuche. Die technischen Rollen entsprechen den Anleitungen des Buchs. DNS- und Browserwerte sind bewusst aufbereitet, keine originalgetreuen Ausgaben einer bestimmten Programmversion.

Ich würde jeweils mit der Aufgabenstellung beginnen und erst dann einen Hinweis öffnen, wenn Ihnen für die nächste Entscheidung etwas fehlt. Die Hilfen und Lösungen stehen weiter hinten, damit Sie Ihre eigene Vermutung zunächst in Ruhe entwickeln können. Ein paar Stichworte reichen: Was wissen wir? Was vermuten wir? Welche einzelne Beobachtung würde den Unterschied klären?

| Fall | Vorwissen zum Nachschlagen | Einstieg |
|---|---|---|
| Unterschiedliche Abrufe derselben Website | Systematische Diagnose (Kapitel 11), getrennte IPv4-/IPv6-Prüfung (Band 1, Kapitel 25, Abschnitt „9. Einen falschen AAAA-Eintrag aus Beobachtungen erkennen“) | [Fall 1](BL04_diagnose_und_alarmfaelle.md#1-die-website-funktioniert-nur-auf-einem-weg) |
| Ein grünes Signal trotz ausgefallener Messkette | Messreihen und Alarme (Kapitel 12, Abschnitt „9. Was passiert, wenn die Beobachtung selbst ausfällt?“) | [Fall 2](BL04_diagnose_und_alarmfaelle.md#2-die-überwachung-bleibt-grün) |
| Eine korrigierte Terminanzeige bleibt im Browser falsch | Cache und fachliche Aktualität (Kapitel 13, Abschnitt „Caches brauchen eine fachliche Grenze“) | [Fall 3](BL04_diagnose_und_alarmfaelle.md#3-der-server-ist-korrigiert-die-anzeige-noch-nicht) |

Die Fälle lassen sich einzeln bearbeiten. Auch ohne gewählte IPv6-Erweiterung können Sie den ersten Fall als Denkaufgabe lesen. Die vollständigen technischen Verfahren bleiben in den verlinkten Kapiteln; diese Beilage ergänzt deren Anwendung auf neue Beobachtungen. Falls Sie später selbst nachstellen möchten, verwenden Sie deren abgegrenzte Lernumgebung und tatsächlich installierte Softwarestände. Aus den Beispieldaten folgt kein Auftrag, Ihren laufenden Betrieb zu verändern.

## 1. Die Website funktioniert nur auf einem Weg

Die Werkstattseite wird direkt vom Heimserver oder vom VPS ausgeliefert. Beide Adressfamilien sind bereits eingerichtet. Nach einer notwendigen Änderung der IPv6-Adresse wurde um 10:00:00 UTC der AAAA-Eintrag berichtigt. Der IPv4-Zugang blieb unverändert. Im konstruierten Fall ist die bisherige IPv6-Adresse seit dieser Umschaltung nicht mehr erreichbar.

Um 10:01 meldet jemand einen stockenden Aufruf. Ihre eigene Kontrolle zeigt dagegen die richtige Seite. Sie haben noch nichts neu gestartet und sammeln zunächst folgende Angaben:

| Zeitpunkt in UTC | Beobachtung |
|---|---|
| 10:01:00 | Externer Websitecheck: HTTP 200, erwarteter Werkstatttext; die protokollierte Verbindung verwendete IPv4 |
| 10:01:05 | Vom betroffenen Prüfanschluss: gezielter IPv4-Abruf erfolgreich |
| 10:01:15 | Vom selben Anschluss: gezielter IPv6-Abruf über den Webnamen läuft ins Zeitlimit |
| 10:01:20 | Aktuelle Serveradresse und vorgesehene IPv6-Webfreigabe stimmen überein |
| 10:01:30 | Alle autoritativen Nameserver liefern die aktuelle AAAA-Adresse, TTL 300 Sekunden |
| 10:01:30 | Der vom betroffenen Test verwendete Resolver liefert noch die vorherige AAAA-Adresse, Rest-TTL 120 Sekunden |

Ein **autoritativer Nameserver** veröffentlicht den zuständigen Zonenbestand. Der **Resolver** beschafft Antworten für einen Client und kann sie zwischenspeichern. Diese Rollen sind schon in der DNS-Einführung getrennt; in diesem Fall entscheidet gerade ihr Unterschied.

Die beiden IPv6-Adressen sind ausschließlich Dokumentationswerte:

~~~text
Vorherige AAAA-Adresse: 2001:db8:1234:ab80::10
Aktuelle AAAA-Adresse:  2001:db8:5678:cd80::10
Webname im Lernfall:    werkraum.example.org
~~~

Für die Aufgabe gelten ein direkter DNS-only-Weg, keine vorgeschaltete Webproxy-Adresse und kein abweichender lokaler Hosts-Eintrag. Die genannten Prüfaufrufe verwenden den untersuchten Resolver. Das Browsergefühl war der Anlass; die getrennten Abrufe sind die präziseren Beobachtungen.

### Ihre Entscheidung

1. Welche Aussage erlaubt der grüne Websitecheck, und welche erlaubt er nicht?
2. Welche Gegenprobe trennt einen Fehler am **aktuellen IPv6-Ziel** von einer noch alten **Namenszuordnung**? Lassen Sie die Zertifikatsprüfung dabei eingeschaltet.
3. Würden Sie den AAAA-Eintrag jetzt nochmals ändern, Caddy neu starten oder zunächst eine gezielte Wiederholungsprüfung planen? Begründen Sie den nächsten Schritt mit den Zeiten.

Sie müssen keinen vollständigen Reparaturplan erraten. Eine begründete nächste Beobachtung genügt zunächst.

[Erster Hinweis](BL04_diagnose_und_alarmfaelle.md#4-hinweise-zu-fall-1) · [Vollständige Lösung](BL04_diagnose_und_alarmfaelle.md#7-lösung-zu-fall-1)

## 2. Die Überwachung bleibt grün

Für die Werkstatt läuft die lokale Messkette aus dem Buch: Prometheus wertet Regeln aus, Alertmanager sendet gewöhnliche Alarme per SMTP und ein regelmäßiges Watchdog-Signal per HTTPS an Healthchecks. Der externe Websiteabruf hat weiterhin seine eigene Aufgabe.

Nun wird ein Ersatzserver mit synthetischen Daten vorbereitet. Das aktive System nennen wir **Betriebsserver**, die noch nicht umgeschaltete Kopie **Probeserver**. Diese Rollen gelten unabhängig vom Standort. Ein Heimserver kann einen Ersatz in einer eigenen Lernumgebung erhalten; ebenso können zwei eigene VPS während einer beaufsichtigten Wiederaufbauprobe nebeneinander bestehen. Für die Denkaufgabe muss nichts davon bestellt oder aufgebaut werden.

Während der Vorbereitung wurde auch eine Konfiguration der Messkette übernommen. Danach ergibt sich diese Folge:

| Zeitpunkt in UTC | Beobachtung |
|---|---|
| 14:00:00 | Messdienste auf dem Probeserver gestartet |
| 14:01:00 | Healthchecks-Prüfpunkt „Lokale Messkette“ erhält ein Signal |
| 14:02:00 | Im beaufsichtigten Versuch wird ausschließlich Alertmanager auf dem Betriebsserver gestoppt |
| 14:03:00 bis 14:14:00 | Derselbe Prüfpunkt erhält weiterhin jede Minute ein Signal |
| 14:14:15 | Betriebsserver: Alertmanager weiterhin inaktiv; dessen Listener 9093 fehlt |
| 14:14:20 | Healthchecks zeigt den Prüfpunkt als gesund; keine Ausbleibemeldung empfangen |
| 14:14:25 | Die öffentliche Werkstattseite ist weiter erreichbar |

Der Prüfpunkt verwendet wie im Buch **Period 5 Minuten und Grace 2 Minuten**. Seine Benachrichtigungsintegration wurde vor diesem Versuch einmal erfolgreich geprüft. In diesem Fall wurde kein Prüfpunkt pausiert.

### Ihre Entscheidung

1. Warum ist die weiterhin erreichbare Website hier kein Widerspruch?
2. Welche zwei Angaben benötigen Sie, um die fortlaufenden Watchdog-Signale einem System zuzuordnen?
3. Ist nach diesen Beobachtungen bereits ein Fehler beim Mailversand belegt? Welche Änderung würde die Überwachung wieder eindeutig machen?

Eine Vermutung wie „Der externe Dienst ist unzuverlässig“ wäre möglich, erklärt aber die registrierten Signale noch nicht. Suchen Sie zuerst eine Beobachtung, mit der sich ihre Herkunft prüfen lässt.

[Erster Hinweis](BL04_diagnose_und_alarmfaelle.md#5-hinweise-zu-fall-2) · [Vollständige Lösung](BL04_diagnose_und_alarmfaelle.md#8-lösung-zu-fall-2)

## 3. Der Server ist korrigiert, die Anzeige noch nicht

Wir bleiben in der lokalen Cacheprobe des Buchs. Der Browser erreicht die eigene Caddy-Lerninstanz über den geschützten SSH-Weg. Hinter der Terminanzeige liegt nur eine Textdatei mit erfundenen Angaben. Sie enthält weder eine echte Reservierung noch Kundendaten.

Ein Besucher dieser Lernseite hat um 11:00:00 UTC den Knopf zum Abruf des synthetischen Terminstands gedrückt. Die Antwort lautete „Dienstag 10:00 ist frei“. Danach wurde der Inhalt geändert und die zuvor absichtlich ungeeignete Cache-Regel berichtigt.

| Zeitpunkt in UTC | Beobachtung |
|---|---|
| 11:00:00 | Browser erhält `/termine.txt` mit HTTP 200 und `Cache-Control: public, max-age=120` |
| 11:00:30 | Textdatei auf dem Lernserver auf „Dienstag 10:00 ist inzwischen belegt“ geändert |
| 11:00:40 | Für dieselbe URL ist nun `Cache-Control: private, no-store` eingerichtet |
| 11:00:45 | Einzelner direkter Abruf vom Lernserver: HTTP 200, neuer Text und neue Cache-Regel |
| 11:01:00 | Erneuter Knopfdruck im bereits offenen Browser: weiterhin „frei“; Netzwerkansicht zeigt Übernahme aus dem Speicher-Cache, keine neue Übertragung |
| 11:01:10 | Ein frisches Browserprofil ohne bisherige Kopie erhält „belegt“ |

Wir nehmen für die überschaubare Zeitrechnung an, dass die erste Antwort beim Empfang ein berechnetes Alter von null hatte und die Uhren übereinstimmen. Die beiden späteren Browserabrufe verwenden denselben Pfad und Ursprung wie der erste; kein Service Worker und keine Erweiterung greift ein. Die Option zum Deaktivieren des Caches in den Entwicklerwerkzeugen ist ausgeschaltet.

### Ihre Entscheidung

1. Ist die neue Serverkonfiguration nachweislich unwirksam, weil der erste Browser noch „frei“ zeigt?
2. Welche Regel kennt dieser Browser um 11:01:00 tatsächlich? Berechnen Sie das Alter seiner gespeicherten Antwort.
3. Wie erreicht die korrigierte Lernseite einen bereits betroffenen Browser, ohne von allen Besuchern das Löschen sämtlicher Browserdaten zu verlangen?
4. Welche fachliche Aufgabe bliebe selbst dann zu prüfen, wenn jeder Abruf den neuesten Terminstand liefert?

[Erster Hinweis](BL04_diagnose_und_alarmfaelle.md#6-hinweise-zu-fall-3) · [Vollständige Lösung](BL04_diagnose_und_alarmfaelle.md#9-lösung-zu-fall-3)

## 4. Hinweise zu Fall 1

### Hinweis 1: Beobachtungen auf denselben Weg beziehen

Der erfolgreiche Abruf hat IPv4 verwendet. Der fehlgeschlagene Abruf hat ausdrücklich IPv6 gewählt. Die Webseite darf denselben Namen tragen und dennoch über verschiedene Adressen erreicht werden.

Vergleichen Sie als Nächstes den IPv6-Abruf über den Namen mit einem Abruf desselben Namens an der aktuell vorgesehenen IPv6-Adresse. Die Anleitung zur getrennten Außenprüfung (Band 1, Kapitel 25, Abschnitt „7. Erst die Adresse prüfen, dann den Namen veröffentlichen“) erklärt den gezielten Test. Eine ausgeschaltete Zertifikatsprüfung würde dessen Aussage schwächen.

### Hinweis 2: Die fehlende Gegenprobe

Für unseren Fall erhalten Sie diese zusätzlichen **konstruierten** Angaben:

- 10:01:45 UTC: Derselbe Client erreicht mit gezielt zugeordneter aktueller IPv6-Adresse und unverändertem HTTPS-Namen den erwarteten Werkstatttext. Die Zertifikatsprüfung gelingt.
- Der Resolver hatte den alten AAAA-Datensatz um 09:58:30 UTC mit einer TTL von 300 Sekunden übernommen.
- 10:03:40 UTC: Eine erneute Abfrage dieses Resolvers liefert die neue Adresse. Der gewöhnliche IPv6-Abruf desselben Clients gelingt jetzt ebenfalls.
- Zwischen den letzten beiden Prüfungen wurden weder DNS-Bestand noch Webdienst oder Filter verändert.

Rechnen Sie von **09:58:30** aus. Die Umschaltung um 10:00 beginnt die Lebensdauer einer bereits gespeicherten alten Antwort nicht neu.

[Zur Aufgabe zurück](BL04_diagnose_und_alarmfaelle.md#1-die-website-funktioniert-nur-auf-einem-weg) · [Zur Lösung](BL04_diagnose_und_alarmfaelle.md#7-lösung-zu-fall-1)

## 5. Hinweise zu Fall 2

### Hinweis 1: Der Name des Prüfpunktes ist keine Absenderprüfung

Ein Prüfpunkt mit dem Namen „Lokale Messkette“ weiß nicht allein dadurch, welcher Server gemeint ist. Entscheidend ist, wohin das Signal geschickt wird und welcher Prozess es tatsächlich sendet.

Vergleichen Sie daher die Zuordnung in den beiden geladenen Alertmanager-Konfigurationen und die vertraulichen Zieldateien. Es genügt, intern festzustellen, ob beide **denselben Prüfpunkt** verwenden. Die vollständige geheime URL gehört weder in die Übungsnotiz noch in einen Chat.

### Hinweis 2: Eine übernommene Zuständigkeit

Im konstruierten Fall ergibt der geschützte Vergleich:

- Beide Systeme haben dieselbe Watchdog-Erfolgs-URL übernommen.
- Der Probeserver führt seine Messkette weiter aus und versendet im fraglichen Zeitraum die zugehörigen Signale.
- Der gestoppte Alertmanager des Betriebsservers sendet nicht mehr.
- Das Ziel in den beiden Konfigurationen ist gültig; im externen Konto werden die Signale tatsächlich beim selben Prüfpunkt registriert.

Damit erklärt sich das grüne Signal bereits, ohne einen Defekt des externen Dienstes anzunehmen. Eine gemeinsame öffentliche Ausgangsadresse wäre kein Gegenbeweis: Hinter demselben Heimrouter können zwei unterschiedliche Systeme senden.

[Zur Aufgabe zurück](BL04_diagnose_und_alarmfaelle.md#2-die-überwachung-bleibt-grün) · [Zur Lösung](BL04_diagnose_und_alarmfaelle.md#8-lösung-zu-fall-2)

## 6. Hinweise zu Fall 3

### Hinweis 1: Hat dieser Abruf den Server erreicht?

Beim wiederholten Knopfdruck zeigt die Netzwerkansicht eine Wiederverwendung aus dem Speicher. Die neu eingestellte Serverregel kann diesen Abruf deshalb noch gar nicht erreicht haben.

Stellen Sie sich die alte Antwort als ein Paket aus **Inhalt und damaligen Antwortregeln** vor. Eine spätere Änderung am Ursprung schreibt dieses bereits gespeicherte Paket nicht aus der Ferne um.

### Hinweis 2: Die neue Regel braucht einen neuen Kontakt

Um 11:01:00 ist die gespeicherte Antwort 60 Sekunden alt. Ihre ursprüngliche Frischezeit beträgt 120 Sekunden. In der Aufgabenannahme sind damit noch 60 Sekunden übrig.

Für die Korrektur bietet das vorhandene Cachelabor bereits `/termine-aktuell.txt` mit `private, no-store`. Diese Adresse wurde im betroffenen Profil noch nicht abgerufen. Das HTML muss nun tatsächlich auf diesen Pfad verweisen; ein weiterhin geöffnetes altes Dokument erhält den neuen Verweis nicht allein durch eine Änderung auf dem Server.

[Zur Aufgabe zurück](BL04_diagnose_und_alarmfaelle.md#3-der-server-ist-korrigiert-die-anzeige-noch-nicht) · [Zur Lösung](BL04_diagnose_und_alarmfaelle.md#9-lösung-zu-fall-3)

## 7. Lösung zu Fall 1

Der grüne Check bestätigt einen erfolgreichen **IPv4-Abruf mit richtigem Inhalt zu diesem Zeitpunkt**. Er bestätigt weder den IPv6-Weg noch die Namensauflösung jedes Besuchers. Das ist keine nutzlose Überwachung; ihre Reichweite ist nur enger als die Aussage „Die Website funktioniert überall“.

Die entscheidende Gegenprobe gelingt um 10:01:45: Der gleiche Client erreicht das aktuelle IPv6-Ziel unter dem vorgesehenen HTTPS-Namen und erhält den richtigen Inhalt. Damit ist ein allgemeiner Ausfall dieses IPv6-Ziels für die Probe widerlegt. Die curl-Option `--resolve` kann eine solche gezielte Zuordnung für einen Namen und Port vorgeben; der URL-Name und die reguläre Zertifikatsprüfung bleiben dabei erhalten.[[2]](BL07_quellen_und_links.md#beilage-drei-störungen-verstehen-und-gezielt-eingrenzen) Sie ersetzt für diesen Abruf die gewöhnliche Adressauswahl, ändert aber nicht die öffentliche Zone.

Der Unterschied liegt hier im **bereits zwischengespeicherten AAAA-Datensatz**. Der zuständige Zonenbestand ist schon richtig. Der untersuchte Resolver besitzt noch eine zuvor gültige Antwort. Die TTL beschreibt deren Cache-Lebensdauer; eine neue Veröffentlichung entfernt die alte Kopie dort nicht augenblicklich.[[1]](BL07_quellen_und_links.md#beilage-drei-störungen-verstehen-und-gezielt-eingrenzen)

Die Rechnung lässt sich vollständig nachvollziehen:

- 09:58:30 plus 300 Sekunden ergibt **10:03:30 UTC**.
- Um 10:01:30 sind 180 Sekunden vergangen; **120 Sekunden Rest-TTL** passen zur Beobachtung.
- Der erfolgreiche normale IPv6-Abruf um 10:03:40 folgt zehn Sekunden nach diesem rechnerischen Ende.

Die beobachtete Erholung ohne weiteren Eingriff stützt die Erklärung. Sie ist nicht schon deshalb bewiesen, weil irgendwann fünf Minuten vergangen sind: Erst die neue Resolverantwort **und** der anschließend erfolgreiche Abruf verbinden Zeitablauf und Wirkung.

### Was wäre jetzt die passende Reaktion?

In diesem Fall bleibt der bereits korrekte DNS-Bestand bestehen. Sie halten die vorübergehende Einschränkung fest und wiederholen nach dem erwarteten Ablauf die konkrete Resolver- und Abrufprüfung. Ein Caddy-Neustart würde die gespeicherte DNS-Antwort nicht berichtigen. Ein erneutes Hin- und Herschalten von AAAA würde weitere Zustände schaffen, die wir anschließend auseinanderhalten müssten.

Auch das nachträgliche Kürzen der TTL in der Zone ändert den damals gespeicherten Wert nicht. Für eine geplante Umschaltung lässt sich eine kürzere TTL vorbereiten; sie muss aber vorab wirksam werden, während der bisherige Dienst noch nutzbar ist. Ein unerwarteter Heim-Präfixwechsel lässt diese Vorbereitung unter Umständen nicht zu. Die TTL ist deshalb keine allgemeine Zusage zur maximalen Ausfalldauer.[[1]](BL07_quellen_und_links.md#beilage-drei-störungen-verstehen-und-gezielt-eingrenzen)

**Wenn die Gegenprobe anders ausgefallen wäre:** Scheitert auch das aktuelle IPv6-Ziel, reicht Warten auf DNS nicht. Dann folgen Listener, Netzregeln und Rückweg gemäß der IPv6-Anleitung. Liefert schon ein autoritativer Nameserver noch die falsche Adresse, ist ebenfalls nicht nur der hier beschriebene Resolvercache betroffen. Eine fortbestehende falsche Antwort nach der geplanten Wiederholung verlangt neue Beobachtungen; sie wird nicht endlos als „DNS braucht Zeit“ erklärt.

### Was unterscheidet Heimserver und VPS?

Im direkten Heimweg müssen aktuelle Serveradresse, Firewallalias und zuständiger AAAA-Aktualisierer zusammenpassen. Der IPv4-Aktualisierer pflegt diesen zweiten Datensatz nicht mit. Beim direkten VPS vergleichen Sie stattdessen die tatsächlich zugewiesene IPv6-Adresse, die Konfiguration des Systems und die Anbieterregeln. Ein normaler VPS-Neustart begründet noch keinen angenommenen Adresswechsel.

Diese Denkaufgabe setzt für beide Wege eine bereits erfolgte IPv6-Änderung voraus; sie behauptet keine typische Häufigkeit. Beim vermittelten Heimweg wäre die öffentliche Adresse die des Vermittlers. Dafür ist der direkte Zielvergleich dieses Falls nicht unverändert geeignet.

Ein knapper **Musterbefund zum Lernfall** lautet: „IPv4 erreichbar. Aktuelles IPv6-Ziel direkt bestätigt; untersuchter Resolver bis 10:03:30 noch mit altem AAAA. Nach Ablauf neue Zuordnung und erfolgreicher IPv6-Abruf um 10:03:40, ohne weitere Konfigurationsänderung.“ Über weitere Netze oder die nächste Adressrotation sagt diese Notiz nichts aus.

[Weiter zu Fall 2](BL04_diagnose_und_alarmfaelle.md#2-die-überwachung-bleibt-grün) · [Zur Übersicht](BL04_diagnose_und_alarmfaelle.md#drei-störungen-verstehen-und-gezielt-eingrenzen)

## 8. Lösung zu Fall 2

Der Probeserver hält den gemeinsamen Prüfpunkt am Leben. Healthchecks ordnet ein Erfolgssignal anhand der Kennung in seiner Ziel-URL zu.[[3]](BL07_quellen_und_links.md#beilage-drei-störungen-verstehen-und-gezielt-eingrenzen) Aus derselben URL auf zwei aktiven Systemen entsteht deshalb keine getrennte Überwachung beider Systeme. **Unsere Zuordnung ist fehlerhaft**, obwohl der externe Dienst die erhaltenen Signale wie vorgesehen verarbeitet.

Um 14:14 ist seit dem letzten Signal um 14:14:00 kaum Zeit vergangen. Die sieben Minuten aus Period und Grace laufen nicht pauschal ab dem Stopbefehl auf dem Betriebsserver. Maßgeblich ist bei diesem einfachen Zeitplan das letzte beim Prüfpunkt registrierte Signal.[[4]](BL07_quellen_und_links.md#beilage-drei-störungen-verstehen-und-gezielt-eingrenzen) Jede weitere Meldung der Probe verschiebt den Zeitpunkt erneut. Eine kürzere Grace-Zeit würde diese falsche Zuordnung nicht heilen.

Dass Caddy weiter die Werkstattseite ausliefert, passt zum Versuch: Gestoppt wurde Alertmanager. Die Website hängt nicht von dessen Listener ab. Der öffentliche Abruf kann daher erfolgreich sein, während die lokale Alarmzustellung bereits ausgefallen ist.

### Die Zuständigkeit wieder eindeutig machen

Zuerst endet der ungewollte Parallelbetrieb mit derselben Watchdog-URL. Die Probe wird aus dieser Zuordnung genommen; der Betriebsserver erhält seine funktionierende Messkette zurück. Für einen weiterlaufenden Probeserver ist ein **eigener, eindeutig benannter Prüfpunkt** im vorhandenen Konto nötig. Die bereits im Haupttext verlangte Prüfung freier Tarifplätze bleibt dabei bestehen. Steht kein eigener Platz zur Verfügung, bleibt die zusätzliche sendende Probekette bis zur Klärung angehalten; der produktive Prüfpunkt wird nicht geteilt.

Der vorhandene Ablauf unter Sicherung, Ersatzsystem und geordnetes Ende (Kapitel 12, Abschnitt „Sicherung, Ersatzsystem und geordnetes Ende“) beschreibt diese Trennung. Bei einer späteren echten Umschaltung endet die alte Zuständigkeit ausdrücklich. Ein kopierter Anzeigename oder ein neues Rechnerlabel ersetzt die getrennten Zielkennungen nicht.

Für eine praktische Bestätigung würde anschließend der bereits erklärte begrenzte Ausfallversuch folgen: eine Messkette unterbrechen, den anderen Prüfpunkt weiter beobachten und auf den richtigen Ausbleibealarm warten. Der Rückweg ist der Wiederstart des genau gestoppten Dienstes; eine Rückkehr zur gemeinsamen URL wäre keine sinnvolle Rücknahme.

### Welche Zeitfolge würde die Korrektur bestätigen?

Die folgende zweite Folge ist wiederum **eine konstruierte Lösung**, kein bereits ausgeführter Alarmtest. Beide Server haben jetzt eigene Prüfpunkte, und der Probeserver sendet durchgehend nur an seinen eigenen:

| Zeitpunkt in UTC | Beobachtung am Prüfpunkt des Betriebsservers |
|---|---|
| 14:22:00 | Letztes registriertes Signal |
| 14:22:10 | Alertmanager des Betriebsservers gestoppt |
| 14:27:00 | Fünf Minuten seit dem letzten Signal verstrichen; Toleranzzeit beginnt |
| 14:29:00 | Weitere zwei Minuten verstrichen; Warnung ist nun fällig |
| 14:29:08 | Externe Ausbleibemeldung für genau diesen Prüfpunkt empfangen |
| 14:30:00 | Alertmanager des Betriebsservers wieder gestartet |
| 14:30:30 | Neues Signal am zugehörigen Prüfpunkt registriert |
| 14:30:40 | Externe Erholungsmeldung empfangen |

Die konkreten Empfangssekunden sind gewählte Beispieldaten. Dienstverarbeitung und Nachrichtentransport garantieren keinen sekundengenauen Eingang. Entscheidend wären im eigenen Versuch der richtige Prüfpunkt, die tatsächlich empfangene Nachricht, das weiterhin getrennte Signal der Probe und die Wiederaufnahme des Betriebsservers. Im Hauptverfahren ist die Sitzung zeitlich begrenzt; eine ausbleibende Warnung verlängert sie nicht unbegrenzt.

### Und was wissen wir jetzt über E-Mail?

Der erste fehlende Alarm beweist keinen SMTP-Fehler: Der externe Prüfpunkt hatte durch die fremden Lebenszeichen gar keine Ausbleibebedingung. Umgekehrt beweist die korrigierte Healthchecks-Mail noch nicht, dass **Alertmanager über SMTP2GO** gewöhnliche Alarme zustellen kann. Watchdog-Webhook und E-Mail-Empfänger sind getrennte Zweige der Konfiguration.[[5]](BL07_quellen_und_links.md#beilage-drei-störungen-verstehen-und-gezielt-eingrenzen)

Dafür bleibt die eigene synthetische Speicherprobe (Kapitel 12, Abschnitt „7. Speicherwachstum mit ungefährlichen Beispieldaten verfolgen“) mit empfangenem Alarm und Entwarnung erforderlich. Der Gedanke lässt sich unmittelbar auf Sicherungen übertragen: Auch zwei Sicherungsjobs mit derselben Erfolgs-URL könnten gegenseitig ihr Ausbleiben verdecken. Ein grüner Zustand bekommt erst durch die eindeutige Zuständigkeit seine gewünschte Bedeutung.

[Weiter zu Fall 3](BL04_diagnose_und_alarmfaelle.md#3-der-server-ist-korrigiert-die-anzeige-noch-nicht) · [Zur Übersicht](BL04_diagnose_und_alarmfaelle.md#drei-störungen-verstehen-und-gezielt-eingrenzen)

## 9. Lösung zu Fall 3

Die neue Serverkonfiguration erreicht einen direkten Abruf und das frische Browserprofil. Diese beiden Beobachtungen sprechen für die wirksame Korrektur am Ursprung. Der bereits benutzte Browser muss deshalb nicht dieselbe Antwort zeigen: Er verwendet in unserem Fall noch sein zuvor empfangenes Paket.

Um 11:01:00 ist dieses Paket 60 Sekunden alt. Die ursprüngliche Regel erlaubt im vereinfachten Fall Wiederverwendung während einer Frischezeit von 120 Sekunden. Das Paket ist damit **technisch noch frisch, fachlich bereits veraltet**. HTTP-Frische beschreibt die Verwendbarkeit nach Cache-Regeln; sie verspricht keine unveränderte Verfügbarkeit eines Werkstatttermins.[[6]](BL07_quellen_und_links.md#beilage-drei-störungen-verstehen-und-gezielt-eingrenzen)

Die um 11:00:40 eingeführte Regel `private, no-store` hat die bereits gespeicherte Antwort nicht rückwirkend entfernt.[[7]](BL07_quellen_und_links.md#beilage-drei-störungen-verstehen-und-gezielt-eingrenzen) Solange der betroffene Abruf gar nicht zum Server führt, kann dessen neue Antwortregel auch nicht an dieser Entscheidung mitwirken. Der sichtbare Cachetreffer ist hier daher der entscheidende Hinweis. Ein angezeigtes HTTP 200 allein hätte ihn nicht geliefert.

### Die Korrektur bis zur Anzeige verfolgen

Für unser vorhandenes Labor besteht die vollständige Korrektur aus einem zusammengehörigen Stand:

1. Unter `/termine-aktuell.txt` liegt der aktuelle synthetische Text. Die Antwort verwendet von Anfang an `private, no-store`.
2. Die HTML-Funktion ruft diese neue Adresse auf. Es reicht nicht, nur die Datei auf dem Server anzulegen.
3. Im betroffenen Browser wird das aktualisierte HTML tatsächlich abgerufen. Dessen reguläre `no-cache`-Behandlung verlangt für eine HTTP-Wiederverwendung die Bestätigung; ein bereits geöffnetes Dokument wird durch die Serveränderung nicht selbst neu ausgeführt.[[6]](BL07_quellen_und_links.md#beilage-drei-störungen-verstehen-und-gezielt-eingrenzen)
4. Die Netzwerkansicht bestätigt den **neuen Pfad**, die tatsächlich empfangene Antwort und den passenden Text. Ein weiterer künstlicher Inhaltswechsel mit anschließendem Knopfdruck muss erneut sichtbar werden.

Die vollständige Browserprobe (Kapitel 13, Abschnitt „Eine schnelle, aber falsche Terminanzeige erzeugen und korrigieren“) führt diese Schritte aus. Für die Nachkontrolle bleibt die gewöhnliche Cacheverwendung eingeschaltet. Ein Test mit „Disable cache“ könnte den Fehler verdecken, den wir gerade ausschließen wollen.[[8]](BL07_quellen_und_links.md#beilage-drei-störungen-verstehen-und-gezielt-eingrenzen)

In einem **konstruierten erfolgreichen Abschluss** würde der betroffene Browser nach dem neuen HTML zuerst „Dienstag inzwischen belegt“ von `/termine-aktuell.txt` erhalten. Nach einer weiteren Änderung auf „Mittwoch 11:00 ist frei“ würde ein erneuter Knopfdruck diesen Text über denselben neuen Pfad liefern. Es wären zwei aktuelle Abrufe, nicht nur ein neuer Dateiname auf dem Server.

### Was bleibt beim Rückweg zu beachten?

Die alte Terminantwort kann bis zum Ende ihrer Frischezeit weiterhin in einem Profil liegen. In unserer vereinfachten Rechnung ist sie um 11:02:00 nicht mehr frisch. Das ist kein allgemeiner Löschzeitpunkt für Browserdaten. Vor allem können alte geöffnete Seiten weiterhin den alten Pfad anfragen.

Die korrigierte Regel bleibt daher auch auf `/termine.txt` bestehen, damit ein späterer neuer Kontakt dort den bereinigten Stand erhält. Ein Rückweg der Gestaltung darf nicht zugleich die frühere öffentliche Frischezeit für Termine zurückbringen. Für die synthetische Sitzung endet der technische Rückbau wie im Kapitel mit dem eigenen Lern-Caddy und dem SSH-Tunnel. Sichtbarer Text in einem noch geöffneten Browser beweist danach keinen weiterhin laufenden Server.

Bei einer echten Anwendung muss die vergleichbare Änderung deren API, vorhandene Clients und weitere Cacheebenen berücksichtigen. Ein beliebiger neuer Pfad ist dort kein allgemeiner Ersatz für Produktkenntnis. Unser Textdateiversuch ist bewusst kleiner: Er lässt den Zusammenhang zwischen Antwortregel, gespeicherter Kopie und erreichter Korrektur unmittelbar erkennen.

### Eine aktuelle Anzeige ist noch keine Buchung

Auch ein gerade bestätigter freier Termin kann beim nächsten Augenblick bereits vergeben sein. Eine echte Anwendung muss bei der Buchung Berechtigung und Verfügbarkeit prüfen und konkurrierende Schreibvorgänge korrekt behandeln. Der Cacheheader übernimmt diese Aufgabe nicht; sie bleibt im [Termin-Prüfverfahren](BL08_terminreferenz_abnahme.md#3-erst-eine-gültige-buchung-dann-konkurrenz), im Datenbankkapitel (Kapitel 5) und im gewählten Anwendungsweg.

Ebenso ist `private` kein Login. Es untersagt die gemeinsame Speicherung nach HTTP-Regeln, während `no-store` die Speicherung der betreffenden Antwort begrenzt.[[6]](BL07_quellen_und_links.md#beilage-drei-störungen-verstehen-und-gezielt-eingrenzen) Wer die URL aufrufen darf, entscheidet weiterhin die Anwendung. Damit können Sie drei Fragen auseinanderhalten: **Ist die Anzeige aktuell? Ist der Zugriff erlaubt? Ist der Termin verbindlich gespeichert?**

[Zur Übersicht](BL04_diagnose_und_alarmfaelle.md#drei-störungen-verstehen-und-gezielt-eingrenzen)

## 10. Was Sie aus den Fällen mitnehmen können

Die Lösungen beruhen auf unterschiedlichen technischen Ursachen. Gemeinsam ist ihnen eine kleine Gewohnheit: Wir lesen eine Beobachtung so genau, wie sie gemacht wurde. Ein erfolgreicher IPv4-Abruf, ein eingegangenes Lebenszeichen und eine Antwort aus dem Browsercache sind jeweils nützlich. Unzuverlässig wird erst die zu weit gehende Schlussfolgerung.

Wenn Sie Ihre Antworten vergleichen, achten Sie daher weniger auf dieselben Formulierungen als auf drei Dinge: Haben Sie den entscheidenden Unterschied erkannt? Haben Sie eine passende Gegenprobe benannt? Passt die vorgeschlagene Maßnahme zu deren Ergebnis? Ein zunächst falscher Verdacht ist kein Scheitern der Übung, wenn Sie ihn anhand neuer Angaben nachvollziehbar korrigieren.

Für eine spätere eigene Störung genügt der kurze Eintrag aus dem Diagnosekapitel: Beobachtung, begründete Ursache, gezielte Änderung und Ergebnis der Wiederholungsprüfung. Die fiktiven Erfolge dieser Beilage werden nicht in das eigene Betriebsheft übernommen.


