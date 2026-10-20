# Die Materialdateien lesend prüfen

Dieses optionale Werkzeug kontrolliert lokale Markdown-Links, vorhandene Abschnittsziele, die Dateiprüfsummen, sämtliche Bandmanifeste und alle ZIP-Dateien auch in den datierten Unterordnern. Jedes ZIP-Mitglied wird vollständig gelesen. Aktuelle Pakete werden mit den örtlichen Dateien verglichen, die früheren Webhosting-Pakete mit ihrer eingebetteten vollständigen Prüfsummenliste. Es verändert keine Datei, greift nicht auf Server zu und benötigt keine zusätzlichen Python-Pakete.

Vom entpackten Repository aus:

```sh
python3 werkzeuge/pruefe_material.py
```

Unter Windows kann je nach Installation `py -3` anstelle von `python3` verwendet werden. Ein leeres Feld `errors` und Exit-Code 0 bedeuten, dass diese Dateiprüfungen erfolgreich waren. Sie sagen nichts über die Funktion einer Serveranleitung oder die Verständlichkeit des Buchs aus.

Die normalen Bandpakete benötigen dieses Werkzeug nicht. Ihre Aufgaben stehen in der [Materialübersicht](../README.md).
