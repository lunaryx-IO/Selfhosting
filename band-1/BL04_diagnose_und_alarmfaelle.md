# Eine DNS-Störung verstehen und gezielt eingrenzen

**Band 1 · vollständige optionale Diagnoseübung.** Alle Beobachtungen sind didaktisch konstruiert. Sie benötigen keinen laufenden Server und kein zusätzliches Konto. Beginnen Sie mit dem Fall und lesen Sie Hinweise und Lösung erst danach.

Die Grunddiagnose aus Kapitel 30 (Störungen eingrenzen und sicher reagieren) und die getrennte IPv4-/IPv6-Prüfung aus Kapitel 25 (Die Website über IPv4 und IPv6 erreichbar machen) bilden die Grundlage. Auch ohne eingerichtetes IPv6 können Sie den Fall als Denkaufgabe bearbeiten. Die Daten sind keine aufgezeichneten Prüfergebnisse und kein Auftrag, den eigenen laufenden DNS-Stand zu verändern.

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

[Erster Hinweis](#2-hinweise-zu-fall-1) · [Vollständige Lösung](#3-lösung-zu-fall-1)


## 2. Hinweise zu Fall 1

### Hinweis 1: Beobachtungen auf denselben Weg beziehen

Der erfolgreiche Abruf hat IPv4 verwendet. Der fehlgeschlagene Abruf hat ausdrücklich IPv6 gewählt. Die Webseite darf denselben Namen tragen und dennoch über verschiedene Adressen erreicht werden.

Vergleichen Sie als Nächstes den IPv6-Abruf über den Namen mit einem Abruf desselben Namens an der aktuell vorgesehenen IPv6-Adresse. Die Anleitung zur getrennten Außenprüfung — Kapitel 25 (Die Website über IPv4 und IPv6 erreichbar machen) erklärt den gezielten Test. Eine ausgeschaltete Zertifikatsprüfung würde dessen Aussage schwächen.

### Hinweis 2: Die fehlende Gegenprobe

Für unseren Fall erhalten Sie diese zusätzlichen **konstruierten** Angaben:

- 10:01:45 UTC: Derselbe Client erreicht mit gezielt zugeordneter aktueller IPv6-Adresse und unverändertem HTTPS-Namen den erwarteten Werkstatttext. Die Zertifikatsprüfung gelingt.
- Der Resolver hatte den alten AAAA-Datensatz um 09:58:30 UTC mit einer TTL von 300 Sekunden übernommen.
- 10:03:40 UTC: Eine erneute Abfrage dieses Resolvers liefert die neue Adresse. Der gewöhnliche IPv6-Abruf desselben Clients gelingt jetzt ebenfalls.
- Zwischen den letzten beiden Prüfungen wurden weder DNS-Bestand noch Webdienst oder Filter verändert.

Rechnen Sie von **09:58:30** aus. Die Umschaltung um 10:00 beginnt die Lebensdauer einer bereits gespeicherten alten Antwort nicht neu.

[Zur Aufgabe zurück](#1-die-website-funktioniert-nur-auf-einem-weg) · [Zur Lösung](#3-lösung-zu-fall-1)


## 3. Lösung zu Fall 1

Der grüne Check bestätigt einen erfolgreichen **IPv4-Abruf mit richtigem Inhalt zu diesem Zeitpunkt**. Er bestätigt weder den IPv6-Weg noch die Namensauflösung jedes Besuchers. Das ist keine nutzlose Überwachung; ihre Reichweite ist nur enger als die Aussage „Die Website funktioniert überall“.

Die entscheidende Gegenprobe gelingt um 10:01:45: Der gleiche Client erreicht das aktuelle IPv6-Ziel unter dem vorgesehenen HTTPS-Namen und erhält den richtigen Inhalt. Damit ist ein allgemeiner Ausfall dieses IPv6-Ziels für die Probe widerlegt. Die curl-Option `--resolve` kann eine solche gezielte Zuordnung für einen Namen und Port vorgeben; der URL-Name und die reguläre Zertifikatsprüfung bleiben dabei erhalten.[\[2\]][Q0159] Sie ersetzt für diesen Abruf die gewöhnliche Adressauswahl, ändert aber nicht die öffentliche Zone.

Der Unterschied liegt hier im **bereits zwischengespeicherten AAAA-Datensatz**. Der zuständige Zonenbestand ist schon richtig. Der untersuchte Resolver besitzt noch eine zuvor gültige Antwort. Die TTL beschreibt deren Cache-Lebensdauer; eine neue Veröffentlichung entfernt die alte Kopie dort nicht augenblicklich.[\[1\]][Q0031]

Die Rechnung lässt sich vollständig nachvollziehen:

- 09:58:30 plus 300 Sekunden ergibt **10:03:30 UTC**.
- Um 10:01:30 sind 180 Sekunden vergangen; **120 Sekunden Rest-TTL** passen zur Beobachtung.
- Der erfolgreiche normale IPv6-Abruf um 10:03:40 folgt zehn Sekunden nach diesem rechnerischen Ende.

Die beobachtete Erholung ohne weiteren Eingriff stützt die Erklärung. Sie ist nicht schon deshalb bewiesen, weil irgendwann fünf Minuten vergangen sind: Erst die neue Resolverantwort **und** der anschließend erfolgreiche Abruf verbinden Zeitablauf und Wirkung.

### Was wäre jetzt die passende Reaktion?

In diesem Fall bleibt der bereits korrekte DNS-Bestand bestehen. Sie halten die vorübergehende Einschränkung fest und wiederholen nach dem erwarteten Ablauf die konkrete Resolver- und Abrufprüfung. Ein Caddy-Neustart würde die gespeicherte DNS-Antwort nicht berichtigen. Ein erneutes Hin- und Herschalten von AAAA würde weitere Zustände schaffen, die wir anschließend auseinanderhalten müssten.

Auch das nachträgliche Kürzen der TTL in der Zone ändert den damals gespeicherten Wert nicht. Für eine geplante Umschaltung lässt sich eine kürzere TTL vorbereiten; sie muss aber vorab wirksam werden, während der bisherige Dienst noch nutzbar ist. Ein unerwarteter Heim-Präfixwechsel lässt diese Vorbereitung unter Umständen nicht zu. Die TTL ist deshalb keine allgemeine Zusage zur maximalen Ausfalldauer.[\[1\]][Q0031]

**Wenn die Gegenprobe anders ausgefallen wäre:** Scheitert auch das aktuelle IPv6-Ziel, reicht Warten auf DNS nicht. Dann folgen Listener, Netzregeln und Rückweg gemäß der IPv6-Anleitung. Liefert schon ein autoritativer Nameserver noch die falsche Adresse, ist ebenfalls nicht nur der hier beschriebene Resolvercache betroffen. Eine fortbestehende falsche Antwort nach der geplanten Wiederholung verlangt neue Beobachtungen; sie wird nicht endlos als „DNS braucht Zeit“ erklärt.

### Was unterscheidet Heimserver und VPS?

Im direkten Heimweg müssen aktuelle Serveradresse, Firewallalias und zuständiger AAAA-Aktualisierer zusammenpassen. Der IPv4-Aktualisierer pflegt diesen zweiten Datensatz nicht mit. Beim direkten VPS vergleichen Sie stattdessen die tatsächlich zugewiesene IPv6-Adresse, die Konfiguration des Systems und die Anbieterregeln. Ein normaler VPS-Neustart begründet noch keinen angenommenen Adresswechsel.

Diese Denkaufgabe setzt für beide Wege eine bereits erfolgte IPv6-Änderung voraus; sie behauptet keine typische Häufigkeit. Beim vermittelten Heimweg wäre die öffentliche Adresse die des Vermittlers. Dafür ist der direkte Zielvergleich dieses Falls nicht unverändert geeignet.

Ein knapper **Musterbefund zum Lernfall** lautet: „IPv4 erreichbar. Aktuelles IPv6-Ziel direkt bestätigt; untersuchter Resolver bis 10:03:30 noch mit altem AAAA. Nach Ablauf neue Zuordnung und erfolgreicher IPv6-Abruf um 10:03:40, ohne weitere Konfigurationsänderung.“ Über weitere Netze oder die nächste Adressrotation sagt diese Notiz nichts aus.

[Zur Übersicht](#eine-dns-störung-verstehen-und-gezielt-eingrenzen)


[Q0031]: BL07_quellen_und_links.md#beilage-eine-dns-störung-verstehen-und-gezielt-eingrenzen
[Q0159]: BL07_quellen_und_links.md#beilage-eine-dns-störung-verstehen-und-gezielt-eingrenzen
[Q0420]: BL07_quellen_und_links.md#beilage-eine-dns-störung-verstehen-und-gezielt-eingrenzen
[Q0421]: BL07_quellen_und_links.md#beilage-eine-dns-störung-verstehen-und-gezielt-eingrenzen
[Q0607]: BL07_quellen_und_links.md#beilage-eine-dns-störung-verstehen-und-gezielt-eingrenzen
[Q0625]: BL07_quellen_und_links.md#beilage-eine-dns-störung-verstehen-und-gezielt-eingrenzen
[Q0278]: BL07_quellen_und_links.md#beilage-eine-dns-störung-verstehen-und-gezielt-eingrenzen
[Q0624]: BL07_quellen_und_links.md#beilage-eine-dns-störung-verstehen-und-gezielt-eingrenzen
