# A3 · Eine Fehlermeldung erklären und gezielt weiterprüfen

**Buchstelle:** Band 1, Kapitel 29 „HTTP, TLS und Reverse Proxy gezielt untersuchen“, Abschnitte zur abgegrenzten Probe, zu Pfadfehlern und zur Antwortzeitüberschreitung.

## Vor dem Beginn

Verwenden Sie die zusätzliche lokale Probe aus dem Kapitel. Sie läuft getrennt von der eigentlichen Website und ausschließlich auf den dort genannten Loopback-Ports. Die [kopierbaren Ausgangsdateien](../band-1/beispiele/proxy-labor/README.md) helfen beim Einstieg. Freie Ports, richtiges Konto und Arbeitsverzeichnis prüfen Sie wie im Buch beschrieben.

## Ihre Aufgabe

1. Stellen Sie zunächst den funktionierenden Ausgang her: statische Seite und Probedienst antworten mit dem erwarteten Inhalt.
2. Bearbeiten Sie den **404-Fall** des Kapitels. Halten Sie fest, ob eine lokale Datei oder eine Ressource des nachgelagerten Dienstes fehlt.
3. Stellen Sie den funktionierenden Ausgang wieder her. Bearbeiten Sie danach den **Verbindungsfehler zum Backend** und die **angenommene Verbindung ohne rechtzeitige Antwort** nacheinander.
4. Kehren Sie nach jeder gezielten Änderung zum funktionierenden Ausgang zurück. Beenden Sie anschließend die zusätzliche Probe.

## Daran erkennen Sie das Ergebnis

Sie können für jeden Fall benennen, welche Grenze bereits funktioniert und welche Beobachtung den nächsten Schritt begründet. In der beschriebenen Caddy-Probe erwarten wir beim nicht erreichbaren Backend **502**, beim Antwortzeitlimit **504**. Beide Fälle dürfen nicht allein wegen eines ähnlichen Browserbilds gleich behandelt werden.

Eine Fehlermeldung ist in dieser Übung das beabsichtigte Ergebnis. Entscheidend ist, dass Sie die Ursache nachvollziehen und die positive Rückkehr beobachten können. Schutzregeln werden dafür nicht pauschal abgeschaltet.

## Falls noch kein geeigneter Lernserver bereitsteht

Bearbeiten Sie stattdessen die [DNS-Denkaufgabe](../band-1/BL04_diagnose_und_alarmfaelle.md). Kennzeichnen Sie Ihre Rückmeldung als **Textfall**, nicht als ausgeführten Serverversuch. Auch damit lässt sich beurteilen, ob die Erklärungen zu einer begründeten nächsten Prüfung führen.

[Ergebnis festhalten](RUECKMELDEBLATT.md) · [Zur Übersicht](README.md)
