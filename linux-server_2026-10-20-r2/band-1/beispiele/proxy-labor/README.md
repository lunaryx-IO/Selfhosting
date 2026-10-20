# Die geschützte Proxyprobe

Die `Caddyfile` und `www/index.html` stammen aus **Band 1, Kapitel 29 „HTTP, TLS und Reverse Proxy gezielt untersuchen“ (K042)**. `www/infos.html` enthält die im Kapitel beschriebene zweite Überschrift und den abweichenden Beispieltext.

Der vollständige Ausgang enthält zwei lokale HTTP-Eingänge auf `127.0.0.1:9180` und `127.0.0.1:9181`. Die Dokumentwurzel der Vorlage lautet `/home/webadmin/webhosting-proxy-labor/www`. Benutzer, Verzeichnis und freie Ports müssen zum beschriebenen Lernaufbau passen.

Verwenden Sie die Dateien ausschließlich im separaten Laborordner. **Ersetzen Sie damit nicht `/etc/caddy/Caddyfile` Ihrer eigentlichen Website.** Vorbereitung, Validierung, Start im Vordergrund, einzelne Fehlerfälle und Beendigung erklärt das Kapitel. Der spätere schweigende Listener auf Port 9182 ist ein eigener Übungsschritt und wird durch diesen Download nicht gestartet.

[Zum Material von Band 1](../../README.md)
