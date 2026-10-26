# Diagnosefälle für Dateien und Nachrichten

Diese Beilage ergänzt die Diagnosekapitel des Buches um vier Fälle zum Mitdenken. Sie finden sie im [digitalen Begleitmaterial zu Band 3](README.md) und können sich für eigene Notizen eine Arbeitskopie anlegen.

Die folgenden Fälle sind **konstruierte Übungen**. Ihre Angaben und Ausgaben beschreiben keine tatsächlich ausgeführten Prüfungen. Sie können die Zusammenhänge zunächst auf Papier verfolgen. Für eine praktische Wiederholung verwenden Sie ausschließlich die entbehrlichen Lerninhalte und die geschützten Wege des jeweiligen Kapitels.

Zu jedem Fall gehören Ausgangslage, Hinweise und eine erläuterte Lösung. Lesen Sie zuerst die Beobachtungen und überlegen Sie, wo Sie als Nächstes nachsehen würden. Was bereits funktioniert, hilft dabei: Lässt sich eine Datei öffnen, ist der Weg bis zum Lesen gelungen. Liegt eine Nachricht in der lokalen Warteschlange, können wir ihren Zustellauftrag dort wiederfinden und weiterverfolgen.

## 1. Die Materialliste lässt sich lesen, aber nicht verändern

### Ausgangslage

Die Dateirolle ist über den vorgesehenen privaten Weg erreichbar. `datei01` gehört zur Gruppe `werkpflege` und soll die Materialliste bearbeiten dürfen. `datei02` soll sie nur lesen. Beide Personen besitzen eigene Zugänge. Es geht um eine einzelne entbehrliche Testdatei unter `/srv/werkdateien/unterlagen/materialliste.txt`.

Nach einer Rückholung kann `datei01` die Datei öffnen. Ein direkter Schreibzugriff auf diese bestehende Datei wird abgewiesen. Eine neu angelegte Testdatei im selben Ordner lässt sich dagegen schreiben und wieder öffnen. Der alte und der neu aufgebaute SMB-Zugang wurden bereits getrennt geprüft; der Server ordnet beide tatsächlich `datei01` zu. Die beabsichtigte Gruppenmitgliedschaft ist ebenfalls vorhanden. Samba lässt Änderungen grundsätzlich zu; die ACL des umgebenden Ordners gibt `werkpflege` das vorgesehene Schreibrecht.

Die übrigen Dateien bleiben während der Untersuchung unverändert. Die Prüfung der betroffenen Datei ergibt folgenden konstruierten ACL-Ausschnitt:

~~~text
# file: /srv/werkdateien/unterlagen/materialliste.txt
# owner: root
# group: werkdateien
user::rw-
group::r--
group:werkpflege:rw-              #effective:r--
mask::r--
other::---
~~~

Welche Beobachtung erklärt den Unterschied zwischen der vorhandenen und der neu angelegten Datei? Was würden Sie vor einer Änderung noch vergleichen?

### Hinweise

Beim Öffnen der Datei haben der Netzwerkweg, die Anmeldung und das Lesen bereits funktioniert. Sehen wir uns deshalb genauer an, was beim Schreiben dieser einen Datei anders ist. Der vorhandene private Zugang bleibt dabei unverändert; ein zusätzlicher öffentlicher Port oder eine weiter gefasste VPN-Regel würde uns bei dieser Frage nicht helfen.

In der ACL steht bei `werkpflege` zwar `rw-`. Daneben sehen Sie jedoch eine wirksame Berechtigung von `r--`. Die **Maske** begrenzt die betreffenden Gruppen- und benannten ACL-Einträge. Vergleichen Sie diesen Zusammenhang mit dem Rechtekapitel und mit den tatsächlichen Rechten des umgebenden Ordners. Eine neue Datei kann einen anderen ACL-Stand erhalten als eine zuvor zurückgeholte Datei.

Beachten Sie außerdem die untersuchte Handlung. Ein direkter Schreibzugriff auf eine vorhandene Datei ist nicht dasselbe wie das Erstellen einer neuen Datei und anschließende Umbenennen. Eine Anwendung kann beim Speichern mehrere dieser Vorgänge kombinieren. Deshalb soll die Beschreibung festhalten, welcher Vorgang tatsächlich scheitert.

### Erläuterte Lösung

Im angegebenen Fall begrenzt `mask::r--` das für `werkpflege` eingetragene Schreibrecht. Das erklärt den abgewiesenen direkten Schreibzugriff, sofern die genannten weiteren Voraussetzungen tatsächlich geprüft wurden. Die korrekte Gruppenmitgliedschaft allein hebt diese Begrenzung nicht auf.

Zunächst halten Sie den vorhandenen ACL-Stand der einen Testdatei fest und vergleichen ihn mit der beabsichtigten Rechteverteilung. Die lesende Gruppe soll weiterhin nur lesen; `werkpflege` soll schreiben dürfen. Für genau diese Zuordnung kann die Maske der Testdatei auf `rw-` angepasst werden. Der im Rechtekapitel erklärte `setfacl`-Weg führt diese gezielte Änderung aus. Ein rekursives `chmod` auf die ganze Ablage würde dagegen viele bislang passende Entscheidungen verändern.

Danach prüfen Sie die ursprüngliche Schreibhandlung erneut mit `datei01`. Ein neuer Inhalt soll gespeichert und wieder gelesen werden können. Mit einer getrennten Anmeldung als `datei02` bleibt derselbe Inhalt lesbar; die entsprechende direkte Änderung soll weiterhin abgewiesen werden. Prüfen Sie auch die im Kapitel besprochenen Umbenennungs- und Löschhandlungen entsprechend dem gewünschten Ordnerrecht. So wird deutlich, ob die Änderung die beabsichtigte Aufgabe erfüllt.

Der Fall ist damit fachlich geklärt, aber die Herkunft des unpassenden ACL-Stands bleibt noch interessant. Wurde beim Rückholen nur der Inhalt kopiert? Stammen die Rechte aus einem anderen Bestand? Wurde nach der Rückholung eine pauschale Modusänderung ausgeführt? Eine Antwort verhindert, dass dieselbe Abweichung bei der nächsten Datei erneut entsteht. Im Betriebsheft genügen Ursache, gezielter Eingriff und die beobachteten Handlungen beider Konten.

## 2. Nach dem Neustart scheint die ganze Ablage leer zu sein

### Ausgangslage

Im zweiten Fall war die gemeinsame Ablage vor dem Neustart vorhanden. Danach meldet Samba einen fehlgeschlagenen Start. Eine lesende Kontrolle findet das Verzeichnis `/srv/werkdateien`; darunter ist jedoch der erwartete Bestand nicht sichtbar. Der Mountschutz des Dienstes hat angeschlagen.

Die Startkonfiguration erwartet ein eigenes Dateisystem mit der im Betriebsheft notierten UUID. Die Kontrolle des tatsächlich eingehängten Pfads zeigt stattdessen das Wurzeldateisystem des Servers. Das Datenlaufwerk ist nicht an `/srv/werkdateien` eingehängt. Noch wurde nichts in diesen Ordner zurückkopiert und der Mountschutz wurde nicht geändert.

Welche Aussage lässt sich daraus über die fehlenden Unterlagen treffen? Weshalb wäre es ungünstig, jetzt sofort neue Dateien in den vorhandenen Ordner zu kopieren?

### Hinweise

Ein vorhandener Verzeichnisname belegt noch keine eingehängte Datenplatte. Unter einem Mountpunkt liegt auch auf dem Systemlaufwerk ein Verzeichnis. Wenn das gewünschte Dateisystem fehlt, sehen Sie dessen darunterliegenden Inhalt. Diese Beobachtung sagt zunächst etwas über die Einhängung, nicht über den Zustand sämtlicher Dateien auf dem Datenlaufwerk.

Der fehlgeschlagene Dienststart hat in diesem Fall eine nützliche Wirkung. Samba stellt nicht versehentlich einen anderen leeren Bestand unter dem vertrauten Freigabenamen bereit. Die Nutzer sollen nicht unbemerkt anfangen, auf dem Systemlaufwerk eine zweite Ablage zu füllen.

### Erläuterte Lösung

Sehen wir zunächst nach, ob Linux das erwartete Laufwerk erkennt. Vergleichen Sie dazu die notierte UUID, die erkannten Geräte und die Mountkonfiguration mit dem Speicheraufbau in Ihrem Betriebsheft. Falls Sie die Verschlüsselung eingerichtet haben, gehört auch ihr Zustand dazu. Wird das Laufwerk erkannt, ist aber noch gesperrt, gehen Sie anders weiter als bei einem Gerät, das überhaupt nicht mehr erscheint. Die lesende Kontrolle hilft Ihnen, diese beiden Fälle auseinanderzuhalten.

Der Mountschutz bleibt während dieser Klärung erhalten. Eine leere neue Ablage würde den ursprünglichen Fehler verdecken und einen zweiten Datenstand schaffen. Auch die pauschale Neuformatierung eines erkannten Laufwerks wäre kein sinnvoller Versuch, die vorhandenen Dateien wiederzufinden.

Kann das richtige Dateisystem wieder in den vorgesehenen Zustand gebracht werden, vergleichen Sie den sichtbaren Bestand und die Rechte, bevor der Dienst startet. Anschließend folgt eine kleine tatsächliche Nutzerprobe. Bei einem ausgefallenen Datenträger führt der dokumentierte Rückweg dagegen auf einen geeigneten Ersatz. Dort werden Daten und Identitäten aus der unabhängig erreichbaren Sicherung zurückgeholt.

Der Fall endet mit genau einem erklärbaren Bestand. Wurden während einer früheren Fehlersuche bereits Dateien in den darunterliegenden Ordner geschrieben, gehören diese zu einer gesonderten Abgleichaufgabe. Sie werden nicht durch das erneute Einhängen automatisch mit dem ursprünglichen Bestand vereinigt. Gerade deshalb war die frühe Startgrenze in unserem Beispiel hilfreich.

## 3. Die Nachricht wurde angenommen und ist trotzdem noch nicht angekommen

### Ausgangslage

Eine Person verschickt eine entbehrliche Testnachricht aus ihrem Mailprogramm an ein eigenes externes Testpostfach. Die verschlüsselte Verbindung zu ihrem Mailserver funktioniert. Der Server bestätigt die Annahme und vergibt eine lokale Queue-ID. Der Empfänger sieht zunächst keine Nachricht.

Die folgenden Angaben sind ein vereinfachter, konstruierter Befund:

| Beobachtung | Aussage des Falls |
|---|---|
| Anmeldung über Submission | Die Anmeldung war erfolgreich; die erlaubte Absenderadresse wurde angenommen. |
| Antwort nach der Übertragung | Der eigene Server hat die vollständige Nachricht angenommen und eine Queue-ID genannt. |
| Lokale Warteschlange | Für genau diese Queue-ID besteht ein noch nicht abgeschlossener Empfängerauftrag. |
| Letzter Zustellversuch | Die Verbindung zum zuständigen äußeren SMTP-Ziel lief in eine Zeitüberschreitung. |
| Andere Funktion | Das eigene Postfach lässt sich über IMAP lesen. |

Was ist bereits gelungen? Welchen Teil des Wegs sollten Sie als Nächstes untersuchen? Würde ein neues Passwort im Mailprogramm die fehlende äußere Verbindung erklären?

### Hinweise

Die bestätigte Annahme gehört zum eigenen Server. Sie ist kein Empfangsbeleg des äußeren Postfachs. Die lokale Queue-ID hilft, genau diesen Auftrag auf genau diesem Server wiederzufinden. Ein anderer Server kann derselben Nachricht eine andere lokale Kennung geben. Für die Verbindung mehrerer Beobachtungen sind deshalb auch Zeitpunkt, Empfänger und die Nachrichtenkennung hilfreich.

Die erfolgreiche IMAP-Nutzung beantwortet eine andere Frage: Der Benutzer kann seinen vorhandenen Mailbestand lesen. Sie prüft weder den ausgehenden SMTP-Port noch den Zustand der äußeren Gegenstelle. Auch eine funktionierende Webseite auf demselben Standort würde diese Mailstrecke nicht belegen.

### Erläuterte Lösung

Für diesen Fall beginnt die Untersuchung hinter der lokalen Annahme. Vergleichen Sie den vorgesehenen Versandweg mit der tatsächlichen Konfiguration: Soll der Server die Mail direkt zum Empfänger transportieren oder an einen festgelegten Relay übergeben? Welcher nächste Host wurde wirklich gewählt? Dazu gehören der aktuelle DNS-Befund, die entsprechende Adressfamilie und die erlaubte ausgehende Verbindung.

Eine einzelne Zeitüberschreitung kann mehrere Ursachen haben. Vielleicht ist die äußere Gegenstelle vorübergehend unerreichbar; vielleicht verhindern ein lokaler Filter, eine Anbietergrenze oder eine ungeeignete Adressfamilie den Versuch. Im Standort- und Diagnoseweg sehen wir uns diese Möglichkeiten einzeln an. Prüfen Sie dabei die betroffene SMTP-Strecke. Dass sich eine Website über HTTPS öffnen lässt, hilft uns bei der Frage nach dieser Mailverbindung noch nicht weiter.

Unser Server hat die Nachricht bereits angenommen und bewahrt sie für die weitere Zustellung auf. Lassen Sie diesen Auftrag während der Untersuchung erhalten. Beim Leeren der ganzen Queue ginge er verloren; beim Erzwingen aller Zustellungen würden Sie auch andere Nachrichten einbeziehen. Nach der begründeten Korrektur verwenden Sie deshalb den gezielten Weg aus dem Diagnosekapitel für genau Ihre Testnachricht und verfolgen deren weiteren Zustand.

Verfolgen Sie den Versuch bis zum eigenen externen Testpostfach. Zunächst soll der nächste Maildienst die Annahme bestätigen; anschließend sehen Sie im Postfach nach, wo die erwartete Nachricht angekommen ist. Vielleicht finden Sie sie im Spamordner. Dann hat die Übertragung funktioniert, und wir haben eine weitere Frage zu untersuchen: warum der empfangende Dienst sie dort eingeordnet hat. Seine vorherige SMTP-Annahme legt den Ordner noch nicht fest.

Im Betriebsheft halten Sie den ursprünglichen Befund, die bestätigte Ursache, die einzelne Änderung und das Ergebnis fest. Zugangsdaten und Nachrichteninhalte, die für diese Zuordnung nicht benötigt werden, gehören nicht in einen weitergegebenen Diagnoseauszug.

## 4. Der Sicherungslauf schweigt und die Warnung bleibt aus

### Ausgangslage

Der Mailserver sollte nachts sichern. Am Morgen ist kein neuer Sicherungsstand zu sehen. Die betreuende Person hat auch keine Warnung erhalten. Der einzige eingetragene Alarmempfänger liegt auf genau diesem eigenen Mailserver. Ob der Zeitgeber ausgelöst hat, wurde noch nicht geprüft.

Wir gehen hier zwei Fragen nach: Weshalb fehlt die neue Sicherung, und weshalb blieb auch die Warnung aus? Möglicherweise hängen beide Beobachtungen zusammen. Falls der Mailserver keine Nachrichten zustellen kann, erreicht auch seine eigene Alarmmail das gewählte Postfach nicht. Aus der still gebliebenen Mailbox lässt sich deshalb noch kein erfolgreicher Sicherungslauf ableiten.

### Hinweise und Lösung

Zuerst wird lesend festgestellt, welche Sicherungsstände tatsächlich vorhanden sind. Danach folgen der notierte Zeitplan, der letzte Dienstlauf und dessen Ergebnis. Eine gestartete Sicherung kann fehlschlagen; ein ausgebliebener Start erzeugt möglicherweise überhaupt kein lokales Sicherungsergebnis. Für diese beiden Fälle benötigt die Beobachtung unterschiedliche Auslöser.

Der im Buch eingerichtete unabhängige Lebenszeichenweg kann einen ausbleibenden Erfolg erkennen, auch wenn der betreffende Server keine eigene Fehlermeldung mehr sendet. Sein Empfänger muss jedoch außerhalb des betroffenen Mailbetriebs erreichbar sein. Im konstruierten Fall wäre genau diese letzte Strecke ungünstig gewählt.

Nachdem der unabhängige Empfänger eingetragen ist, probieren Sie den Weg wie im Sicherungskapitel beschrieben aus. Bei einer beaufsichtigten, zeitlich begrenzten Ausbleibeprobe soll die Warnung dort ankommen. Nach der Rückkehr prüfen Sie den erfolgreichen Sicherungslauf, seinen neuen Stand und das passende Lebenszeichen. Halten Sie im Heft auch fest, ob Sie die Warnung tatsächlich empfangen haben. Die Anzeige im Dashboard hilft bei der Untersuchung; sie allein zeigt noch nicht, ob die Meldung Sie erreicht hat.

## Die Fälle auf den eigenen Aufbau übertragen

Alle vier Fälle beginnen mit etwas, das Sie am eigenen Aufbau beobachten können: Eine Datei lässt sich lesen, ein Volume fehlt oder eine Nachricht wartet noch auf die Zustellung. Von dort aus fragen wir weiter und behalten im Blick, welcher Teil bereits funktioniert. Mit diesem Vorgehen können Sie auch einer Störung nachgehen, die in unseren Beispielen nicht vorkommt.

Wenn Sie eigene Übungsfälle ergänzen möchten, beschreiben Sie zuerst den erlaubten Ausgangszustand und die betroffene Handlung. Halten Sie fest, welche Gegenprobe die vermutete Ursache von einer anderen unterscheidet. Der Wert der Übung liegt in diesem erklärbaren Unterschied und in einer nachvollziehbaren Rückkehr zum vorgesehenen Betrieb.
