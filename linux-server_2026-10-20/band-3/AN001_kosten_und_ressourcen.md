# Kosten und Ressourcen im Detail

Eine Materialliste benötigt wenig Platz. Aus ihr kann im Alltag jedoch eine Ablage mit Bildern, Zeichnungen und jahrelang gesammelten Unterlagen werden. Ähnlich verhält es sich mit den Postfächern: Die erste Testnachricht ist klein; der dauerhaft aufbewahrte Schriftverkehr kann den Platzbedarf später bestimmen. Die Auswahl eines Servers wird deshalb verständlicher, wenn wir den Datenbestand und seinen Rückweg gemeinsam betrachten.

Dieser Anhang führt die Planung aus Band 1 für die neuen Rollen weiter. Sie rechnen nur die Erweiterung, die Sie tatsächlich wählen. Ein Dateiserver verlangt keinen eigenen Mailserver. Werden beide Dienste eingerichtet, haben sie im Buch getrennte Betriebssystemumgebungen. Die Kosten für einen bisherigen Webserver verschwinden dadurch nicht; sie stehen weiterhin im vorhandenen Kostenblatt.

Alle Zahlen in den folgenden Rechenbeispielen sind **eigene konstruierte Planungsannahmen**. Es sind keine aktuellen Anbieterpreise, Verbrauchsmessungen oder Leistungszusagen. Für eine Bestellung setzen Sie das konkrete Angebot mit Datum, Leistungsumfang, Laufzeit, Steuerdarstellung und möglichen Zusatzkosten ein. Die Rechnung soll Ihnen helfen, diese Angaben einzuordnen.

## 1. Vom heutigen Bestand zur benötigten Ablage

Beginnen wir mit einer angenommenen Dateiablage von 120 GiB. Im Beispiel kommen im Durchschnitt 4 GiB im Monat hinzu. Für das Ende des ersten Jahres ergeben sich damit 168 GiB: der vorhandene Bestand plus zwölfmal der angenommene Zuwachs. Löschen und Überschreiben können diese Entwicklung verändern. Für die erste Planung wollen wir jedoch erkennen, was bei fortgesetztem Wachstum geschieht.

Die Datenplatte soll dann nicht bis zum letzten freien Block gefüllt sein. Möchten wir ein Viertel ihrer gesamten Kapazität frei halten, dürfen die 168 GiB höchstens drei Viertel belegen. Die Rechnung lautet 168 GiB geteilt durch 0,75. Sie ergibt 224 GiB benötigte Kapazität, noch ohne weitere auf diesem Dateisystem gespeicherte Bestände. Einfach 25 Prozent zum Datenbestand zu addieren ergäbe 210 GiB; darin wären nur 20 Prozent des Gesamtplatzes frei.

| Schritt im konstruierten Beispiel | Rechnung | Ergebnis |
|---|---|---:|
| Heutiger Dateibestand | Annahme | 120 GiB |
| Zuwachs im ersten Jahr | 12 × 4 GiB | 48 GiB |
| Erwarteter Nutzbestand | 120 + 48 GiB | 168 GiB |
| Kapazität bei 25 Prozent freier Gesamtfläche | 168 ÷ 0,75 GiB | 224 GiB |

Ein als 250 GB angebotenes Laufwerk hat nicht 250 GiB. Bei GB wird gewöhnlich mit einer Milliarde Bytes gerechnet, bei GiB mit 1.073.741.824 Bytes. 250 GB entsprechen vor weiteren Belegungen ungefähr 233 GiB. Deshalb vergleichen Sie Angebot, angezeigte Dateisystemgröße und Datenmessung in derselben Einheit. Die Reserve aus unserer Rechnung wäre bei diesem Laufwerk schon wesentlich kleiner, als die beiden Zahlen 224 und 250 zunächst vermuten lassen.

Zum belegten Platz kommen weitere Eigenschaften. Viele kleine Dateien benötigen Verwaltungsstrukturen und können das Einlesen oder Zurückholen stärker belasten als wenige große Dateien gleicher Gesamtlänge. Freie **Inodes**, die Dateieinträge eines entsprechenden Dateisystems, betrachten wir deshalb zusammen mit den freien Datenblöcken. Eine Dateianzahl oder ein großer freier Bytewert ersetzt den jeweils anderen Blick nicht.

Für die Mailrolle rechnen Sie den tatsächlich aufbewahrten Bestand aller Ordner. Ein gelöschter Brief kann zunächst im Papierkorb des Postfachs liegen. Gesendete Nachrichten, zusätzliche Ordner und große Anhänge gehören ebenfalls zum Bestand. Die Summe der Postfachquoten ist zudem eine Obergrenze für die Benutzerablagen, nicht automatisch eine ausreichende Größe der ganzen Datenplatte. Indexdateien, Betriebsreserven und andere zum gewählten Aufbau gehörende Daten brauchen ebenfalls Platz.

Quoten machen das Wachstum einzelner Konten vorhersehbarer. Sie legen aber zugleich fest, wann eine Person nicht mehr wie gewohnt arbeiten oder neue Nachrichten erhalten kann. Eine Warnung muss daher früh genug bei einer zuständigen Person ankommen, damit vor der Grenze noch gehandelt werden kann. Planen Sie mit ein, wer dann nachsieht und mit den Betroffenen klärt, ob mehr Platz benötigt wird oder entbehrliche Inhalte entfernt werden können.

## 2. Sicherung und Arbeitskopien mitrechnen

Der aktuelle Nutzbestand ist nur ein Teil der gespeicherten Daten. Eine Sicherung hält auch ältere Fassungen vor. Wie viel Platz diese benötigen, hängt unter anderem davon ab, welche Dateien sich verändern, wie viele Stände Sie behalten und welche Inhalte das Sicherungswerkzeug erneut verwenden kann. Eine feste Aussage wie „zehn Sicherungen brauchen zehnmal den Dateiplatz“ wäre ebenso ungenau wie die Annahme, dass alle späteren Stände fast kostenlos hinzukommen.

Ein nützlicher Anfang besteht aus drei getrennten Größen: dem heutigen Bestand, dem erwarteten Wachstum und den während der Aufbewahrungszeit veränderten Daten. Nachdem mehrere gewöhnliche Sicherungsläufe vorliegen, vergleichen Sie diese Annahmen mit der wirklichen Entwicklung des Repositorys. Eine erste erfolgreiche Sicherung liefert einen Ausgangswert. Sie sagt noch wenig über ein Jahr wechselnder Anhänge, gelöschter Ordner oder neu geschriebener großer Dateien aus.

Auch auf dem Server kann zusätzlicher Platz benötigt werden. Bei einem kontrollierten Umzug oder einer Rückholung bewahren Sie zunächst den aktuellen Bestand und legen daneben die zu prüfende Fassung ab. Wenn beide auf derselben Datenplatte liegen, muss diese beide aufnehmen können. Die 25 Prozent freie Fläche aus dem vorigen Beispiel würden nicht ausreichen, um einen zweiten vollständigen Bestand von 168 GiB daneben zu legen.

Planen Sie die Rückholprobe deshalb mit ihrem tatsächlichen Ziel. Ein getrennter leerer Ersatz kann den zurückgeholten Bestand aufnehmen, ohne den laufenden Server zu füllen. Er benötigt aber eigene Kapazität und gegebenenfalls eigene Mietkosten. Eine kleine Einzeldateiprobe untersucht eine andere Aufgabe: Sie zeigt den gezielten Rückweg eines Dokuments, während die übrige Ablage weiterbesteht. Beide Übungen sind wertvoll; sie ersetzen einander nicht.

Eine Spiegelung schützt vor bestimmten Laufwerksausfällen, hält aber gewöhnlich denselben aktuellen Stand auf beiden Seiten. Eine versehentliche Änderung kann dadurch ebenfalls auf beiden Seiten stehen. Für die Budgetrechnung bleiben Ausfallvorsorge und unabhängige Sicherung deshalb verschiedene Positionen. Ebenso hilft eine verschlüsselte Sicherung nur dann bei der Wiederherstellung, wenn ihr Geheimnis außerhalb des ausgefallenen Systems erreichbar bleibt.

## 3. Übertragungszeit als Teil des Rückwegs verstehen

Nehmen wir die 168 GiB aus unserem Beispiel und einen tatsächlich verfügbaren Durchsatz von 80 Mbit/s an. Acht Bit ergeben ein Byte. Für eine theoretische Übertragungszeit teilen wir die Bytezahl des Bestands durch zehn Millionen Bytes pro Sekunde. Das ergibt rund **5,01 Stunden** für eine einzige vollständige Übertragung.

Bei 40 Mbit/s wären es rund 10,02 Stunden. Bei 160 Mbit/s läge die rechnerische Zeit bei rund 2,51 Stunden. Diese Werte lassen Protokollaufwand, Abfragen vieler kleiner Dateien, Entschlüsselung, Schreibgeschwindigkeit und weitere Arbeitsschritte außer Betracht. Sie sind eine günstige Rechengrenze unter dem angenommenen konstanten Durchsatz, keine gemessene Wiederherstellungsdauer.

| Angenommener gleichbleibender Durchsatz | Reine Rechenzeit für 168 GiB |
|---|---:|
| 40 Mbit/s | etwa 10,02 Stunden |
| 80 Mbit/s | etwa 5,01 Stunden |
| 160 Mbit/s | etwa 2,51 Stunden |

Wenn der Betrieb spätestens nach vier Stunden wieder nutzbar sein soll, passt schon die reine Übertragung über den angenommenen 80-Mbit/s-Weg nicht zu diesem Ziel. Ein schnellerer Prozessor allein löst diese Grenze nicht. Sie könnten einen schnelleren Rückholweg vorsehen, einen passenden zusätzlichen Sicherungsort nutzen, die zuerst benötigten Daten genauer abgrenzen oder ein längeres Ausfallziel vereinbaren. Welche Lösung sinnvoll ist, hängt vom Arbeitsalltag ab.

Zur ganzen Ausfallzeit gehören außerdem Entdeckung, Reaktion, Bereitstellung des Ersatzes, Grundaufbau, Datenbezug und Funktionsprüfung. Eine Übung, bei der ein leerer Ersatz bereits bereitsteht und Sie den Ausfall sofort bemerken, misst einige dieser Anteile nicht. Halten Sie im Betriebsheft fest, was die gemessene Dauer tatsächlich umfasst. So bleibt die Zahl auch bei der späteren Planung aussagekräftig.

## 4. Datenverlust und Unterbrechung getrennt planen

Ein täglich gesicherter Dateibestand kann die Änderungen seit der letzten abgeschlossenen Sicherung vermissen. Wenn vier Stunden verlorener Arbeit bereits zu viel wären, passt ein täglicher Takt nicht zum gewünschten Datenstand. Ein häufiger ausgelöster Timer allein reicht wiederum nicht, falls die Läufe nicht erfolgreich abschließen oder ihr Ziel dauerhaft unerreichbar ist.

Beim Mailserver kommen Nachrichten auch dann hinzu, wenn gerade niemand am eigenen Arbeitsplatz sitzt. Ein früherer Sicherungsstand kann technisch einwandfrei sein und trotzdem später angenommene Nachrichten nicht enthalten. Dass der Server dem Absender zuvor eine erfolgreiche Annahme bestätigt hat, macht diese Nachrichten für den Rückweg besonders bedeutsam. Die Sicherungsentscheidung muss deshalb zum tatsächlich übernommenen Betrieb passen.

Für unsere kleinen Lernbestände lassen sich die ersten Schreibpausen gut überblicken. Bei größeren Datenmengen können sie länger dauern. Messen Sie den gewählten Ablauf unter Ihrer tatsächlichen Nutzung, bevor Sie aus einer kurzen Übung eine feste Zusage für einen größeren Bestand ableiten. Häufigere Sicherungen dürfen nicht unbemerkt so viel Unterbrechung verursachen, dass Menschen den vorgesehenen Dienst kaum noch verwenden können.

Im Betriebsheft stehen deshalb zwei verschiedene Ziele: welcher Verlust neuer Änderungen noch vertretbar ist und nach welcher gesamten Unterbrechung die Aufgabe wieder erfüllt werden muss. Die Wiederherstellungsprobe verbindet diese Ziele mit einem tatsächlichen Ablauf. Eine bestandene Einzeldateiprobe liefert dafür andere Informationen als der Wiederaufbau auf einem leeren Rechner.

## 5. Drei überschaubare Jahresrechnungen

Für die folgenden Beispiele verwenden wir Euro und eigene Annahmen einschließlich einer bereits eingerechneten Steuerbelastung. Ein bestehender Internetanschluss, Arbeitsrechner und die bisherige Webumgebung werden hier nicht nochmals berechnet. Zusätzliche Anschaffungen stehen gesondert darunter. Die Beträge bezeichnen jeweils die **zusätzlichen geplanten Ausgaben**, nicht die Gesamtkosten einer Werkstatt.

Beim Heim-Dateiserver nehmen wir 16 W mittlere zusätzliche Leistungsaufnahme an. Über 8.760 Stunden eines Jahres sind das 140,16 kWh. Bei angenommenen 0,30 EUR/kWh ergeben sich 42,05 EUR, auf Cent gerundet. Der Wert muss in einem tatsächlichen Aufbau Server und neu hinzugekommene Netztechnik sinnvoll erfassen. Er ist keine Messung eines bestimmten Geräts.

| Kostenposition | Datei zu Hause | Privater Datei-VPS | Eigene Mailrolle |
|---|---:|---:|---:|
| Laufender zusätzlicher Serverbetrieb | 42,05 EUR Stromannahme | 12 × 7,00 = 84,00 EUR Mietannahme | 12 × 9,00 = 108,00 EUR Mietannahme |
| Unabhängiger Sicherungsspeicher | 12 × 4,00 = 48,00 EUR | 12 × 4,00 = 48,00 EUR | 12 × 2,00 = 24,00 EUR |
| Zusätzlich benötigte Maildomain | entfällt in diesem Dateibeispiel | entfällt in diesem Dateibeispiel | 15,00 EUR Jahresannahme |
| Zeitweiliger Ersatz und Übertragungen für Übungen | 12,00 EUR eigenes Übungsbudget | 12,00 EUR eigenes Übungsbudget | 12,00 EUR eigenes Übungsbudget |
| **Geplante zusätzliche Jahresausgaben** | **102,05 EUR** | **144,00 EUR** | **159,00 EUR** |

Das Heimbeispiel setzt einen bereits vorhandenen geeigneten Rechner und eine passende Netztrennung voraus. Fehlen Datenplatte, zusätzliche Schnittstelle, Switch, Kabel oder eine geeignete Firewall, gehören die konkreten Anschaffungen hinzu. Ein vorhandenes Gerät ist außerdem nicht dauerhaft kostenlos ersetzbar. Eine dafür zurückgelegte Reserve bleibt eine eigene Planungsgröße; sie wird nicht zugleich als bereits ausgegebener Betrag verbucht.

Der Datei-VPS setzt geeignete Kapazität und einen privaten Zugang voraus. Im angenommenen Mietbetrag müssen die tatsächlich nötigen Adressen und Speicherleistungen enthalten sein. Ein großer Bestand kann außerdem Übertragungsgebühren oder einen anderen Tarif erforderlich machen. Die Mailrolle braucht zusätzlich die im Mailteil erläuterten Anschlussbedingungen. Ein niedriger Preis ist kein Ausgleich für einen ungeeigneten Empfangsweg.

Wählen Sie Heim-Dateien und die Mailrolle gemeinsam, ergeben diese voneinander unabhängigen Annahmen 261,05 EUR im Jahr. Für Datei-VPS und Mailrolle zusammen wären es 303,00 EUR. Eine gemeinsam genutzte Leistung darf dabei nur einmal gerechnet werden. Umgekehrt dürfen Sie eine gemeinsame Sicherungsablage nicht doppelt als voneinander unabhängigen Schutz zählen.

Ein externer Versandrelay, besondere Überwachung, kostenpflichtige VPN-Funktionen oder ein geänderter Anschluss sind in den Zahlen nicht enthalten. Tragen Sie sie ein, wenn Ihr gewählter Weg sie benötigt. Dass eine Testmenge in einem kostenlosen Angebot Platz findet, begründet keine dauerhafte Preisannahme für Ihren späteren Umfang. Bei einem tatsächlichen Angebot zählen unter anderem Freimengen, Mindestlaufzeit, Verlängerung und die Bedingungen beim Überschreiten eines Limits.

## 6. Den zeitweiligen Ersatz wieder beenden

Für eine Wiederherstellungsprobe kann eine zusätzliche Instanz nur für einen begrenzten Zeitraum nötig sein. Sie erhält einen eigenen Zweck, einen eigenen Datenbestand und einen geplanten Endzeitpunkt. Notieren Sie vor dem Start, welche Ergebnisse Sie behalten müssen und welche Ressourcen anschließend tatsächlich entfallen sollen.

Bevor Sie den Ersatz abschalten, sehen wir uns an, wo danach weitergearbeitet wird. Stellt der ursprüngliche Dienst wieder allein die aktuellen Dateien beziehungsweise Postfächer bereit? Sind neue Testdaten davon getrennt, und bleiben die benötigten Ergebnisse samt unabhängiger Sicherung erhalten? Wenn das geklärt ist, schließen Sie die Testzugänge, beenden ihre Zeitgeber und nehmen die nur für die Probe eingerichteten Verbindungen zurück.

Bei einem Anbieter ist eine ausgeschaltete Instanz nicht automatisch eine beendete Abrechnung. Datenträger, reservierte Adressen, Snapshots oder andere Zusatzleistungen können eigene Lebenszyklen haben. Vergleichen Sie die tatsächlich verbleibenden Ressourcen mit Ihrer Notiz. Der bestätigte Endzustand und eine spätere Abrechnung beantworten dabei unterschiedliche Fragen.

Die gleiche Sorgfalt gilt zu Hause. Ein für die Probe geliehener Datenträger enthält möglicherweise noch eine vollständige Kopie vertraulicher Unterlagen. Seine weitere Aufbewahrung und Rückgabe müssen zum beabsichtigten Umgang mit diesen Daten passen. Der technische Aufbau der Übung ist erst ein Teil ihres Abschlusses.

## 7. Die Planung nach den ersten echten Beobachtungen fortschreiben

Nach einigen gewöhnlichen Betriebswochen kennen Sie Ihren Aufbau besser. Sie sehen, welche Daten hinzukommen, wie lange die Sicherung arbeitet und welche Rückfragen tatsächlich entstehen. Vergleichen Sie diese Beobachtungen mit der anfänglichen Rechnung. Eine Abweichung ist ein Anlass, die passende Annahme zu ändern.

Halten Sie dabei fest, was gemessen, angeboten oder lediglich angenommen wurde. Eigene Arbeitszeit bleibt neben den Ausgaben sichtbar: Einrichtung, regelmäßige Betreuung und Wiederherstellungsübungen haben unterschiedliche Anlässe. Eine unerwartete Störung kann zusätzlich zusammenhängende Zeit beanspruchen. Wer diese Größen auseinanderhält, kann auch eine spätere Übergabe oder die Nutzung eines betreuten Dienstes genauer beurteilen.

Die ausfüllbare Ergänzung zum Betriebsheft im [digitalen Begleitmaterial zu Band 3](README.md) bietet dafür Platz in den vorhandenen vier Bereichen. Sie können ebenso Ihre bisherigen Notizen weiterführen. Die Rechnung bleibt damit Teil Ihres wirklichen Aufbaus und wächst mit den Aufgaben, die Sie ihm tatsächlich geben.
