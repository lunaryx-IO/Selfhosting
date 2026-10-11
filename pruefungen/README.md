# Was wurde tatsächlich geprüft?

**Stand: 12. Oktober 2026 · Materialfassung 2026.10.12**

Die folgenden Berichte beschreiben ausgeführte Versuche zur Anleitung in beiden Bänden. Sie nennen Aufbau, Beobachtung und Aussagegrenze. Die Lerninhalte und Anwendungsdaten waren synthetisch; private Kontodaten und Rohprotokolle gehören nicht in diese Veröffentlichung.

## Der schnelle Überblick

| Bereich | Tatsächlich belegter Umfang | Bericht |
|---|---|---|
| Linux, Zugänge und Netze | Native Clients, virtuelle Installation, Hostfilter, OPNsense, zusätzliche physische VLAN-/Trunk-Probe und reale VPS-Rettung | [Systeme, Netze und Rettung](NETZE_UND_RETTUNG.md) |
| Website und Außenwege | Geschützter Betrieb, öffentliches HTTPS über IPv4/IPv6 am VPS, Heim-VPN, feste Tunnelroute und iPhone über Mobilfunk | [Systeme, Netze und Rettung](NETZE_UND_RETTUNG.md) |
| Anwendungen | Daten, Rollen, Updates, Rückwege, echter Mailversand, CAPTCHA und begrenzte Termin-Konkurrenzprüfung | [Anwendungen und Daten](ANWENDUNGEN.md) |
| Sicherung und Betrieb | Unabhängige Rückholung, tatsächliche reguläre Sicherungstermine, Fehler-/Ausbleibealarme und getrennte Diagnosefälle | [Sicherung, Diagnose und Betrieb](BETRIEB.md) |
| Automatisierung | Geprüfte Übernahme, Rückweg, begrenzte Werkzeuge und unabhängige Kontrolle von Modellvorschlägen | [Automatisierung](AUTOMATISIERUNG.md) |

**Bestanden** bedeutet jeweils: Die vorher festgelegte Erwartung wurde im genannten Versuch erfüllt. Es ist keine Freigabe für jede Hardware, Softwareversion und Betriebsform. Eine Aufgabe für künftige Testleser ist noch kein beobachtetes Ergebnis.

## Fehler, die für die Einordnung wichtig bleiben

- Die ursprüngliche parallele Termin-Rezeptur erzeugte Doppelbuchungen. Die korrigierte Buchkonfiguration mit einer einzigen gleichzeitig bearbeiteten Anfrage bestand die begrenzten Gegenproben. Weitere schreibende Integrationen und mehrere Instanzen sind davon nicht erfasst.
- Die Termin-Anwendung zeigte eine falsche Sommerzeitbeschriftung und unpassende Kalender-Metadaten. Diese Herstellergrenze bleibt dokumentiert; richtige UTC-Zeiten einzelner Ereignisse beheben sie nicht.
- Der Antworttimeout der Proxyprobe wurde zunächst als 502 erwartet. Die beobachtete 504-Antwort führte zur Korrektur der Buchstelle.
- Zwei frühe Modellversuche behaupteten einen Abschluss ohne die verlangte Änderung. Die unabhängige Prüfung erkannte das. Die korrigierte begrenzte Vorlage bestand vier spätere Durchgänge; daraus folgt keine allgemeine Modellzuverlässigkeit.

## Was noch nicht abgenommen ist

Die unabhängige Leser- und Fachprüfung ist offen. Weitere Geräte- und Anbietervarianten, vollständige physische Drei-Port-Firewall, einzelne native VPN-Clientvarianten, Kontowiederherstellung sowie langfristiger Dauerbetrieb und natürliche Zertifikatserneuerung sind nicht mitgeprüft. Die konkreten Grenzen stehen bei den jeweiligen Ergebnissen.

Am vorhandenen Heimanschluss stellt der Anbieter kein IPv6 bereit. Der native Heimweg und dessen Providerpräfixwechsel waren deshalb dort nicht durchführbar. Getrennte virtuelle IPv6- und reale VPS-IPv6-Versuche bleiben gültig. Eine Wiederholung gewöhnlicher Datei-, Editor- oder Browserbedienung ist kein eigener Prüfauftrag.

Die Gesamtpraxisabnahme bleibt **teilgeprüft**. Das ist die Summe dieser benannten Grenzen, kein offener Auftrag, das abgeschlossene Labor erneut aufzubauen. [Aufgaben für die unabhängigen Personen](../mitmachen/README.md).

[Zur Startseite](../README.md)
