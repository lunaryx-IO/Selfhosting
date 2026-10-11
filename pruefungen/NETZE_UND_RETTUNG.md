# Systeme, Netze und Rettung

**Beobachtungszeitraum:** September bis 12. Oktober 2026.  
**Bezug:** Band 1: Arbeitsrechner, Linux-Grundstand, geschützte Website, Hostfilter, Heimnetz, VLAN, IPv6 und Fernzugang. Band 2: Rettung und Standortwechsel.

## Der untersuchte Aufbau

Native Clients mit Windows 11 Pro, macOS und Debian; isolierte Debian-13-amd64-Gäste auf einem eigenen Laborhost. Caddy 2.11.7, OPNsense nach dem geprüften Update 26.7.5 mit Kernel/Basis 26.7.4, SystemRescue 13.02. Für den Anbieterweg zwei eigene Debian-VPS an verschiedenen deutschen Standorten. Für die physische VLAN-Probe ein TP-Link SG3428X, Hardware 1.30, Firmware 1.30.0 Build 20231019 Rel.60485, und zwei zusätzliche physische Ethernet-Verbindungen.

Cloudflared 2026.10.0 und Tailscale 1.104.1 auf der Heim-Lern-VM; der getrennte Mac-Testprozess nutzte Tailscale 1.102.5 im Userspace-Modus. Die iPhone-Probe verwendete die native App und Safari. Konten und Netze für die Versuche waren vom privaten VPN getrennt.

## Was durchgeführt wurde

| Versuch | Beobachtung | Ergebnis und Reichweite |
|---|---|---|
| Dateien und Identität prüfen | Native Hash-/Signaturprüfungen erkannten veränderte Eingaben. Schlüssel, Rechte, unabhängig verglichene Hostidentität und gesicherte Rückkopie wurden tatsächlich verwendet. | Bestanden für die genannten Clients und Zugänge. |
| Linux frisch installieren | Neues virtuelles System von geprüftem Medium installiert, von der Platte gestartet, Konsole, SSH/sudo, Updates, Filter und Neustart geprüft. | Softwareumfang bestanden; kein zusätzlicher USB-/Firmwaretest eines Laptops. |
| Zugriff begrenzen | Erlaubte Verbindungen, absichtlich gesperrte Wege, passender Filterbefund und positive Rückkehr beobachtet. | Hostfilter und virtuelle OPNsense-Grenzen bestanden. |
| Physische VLAN-/Trunk-Strecke | Gemeinsames Access-VLAN, getrennte VLANs, getaggter Trunk, fremde Kennungen, ungetaggter Trunkeingang und Rückkehr geprüft. | 17 aussagekräftige Einzelproben bestanden: 48 erwartete Frames empfangen, 54 unerlaubte Testframes nicht an der jeweils tatsächlich zugeordneten Gegenstelle empfangen. |
| Virtuelles IPv6 | DHCPv6-PD, Routerankündigungen, SLAAC, Standardroute, Hostfreigabe, HTTPS mit privater CA, PMTUD, Präfixwechsel und Neustarts. | Im abgeschlossenen virtuellen Netz bestanden; IPv4-Ausgang anschließend wiederhergestellt. |
| Echte Anbieterrettung | Originalserver in die Anbieter-Rettungsumgebung gestartet, eigene Systempartition nur lesend eingebunden, Archiv unabhängig gerettet. | Wiederzugang und unveränderte ursprüngliche SSH-Identität bestanden. |
| Öffentlicher VPS-Weg | Eigene DNS-Testeinträge, gültiges ACME-Zertifikat, HTTP-Weiterleitung, Inhalte, IPv4/IPv6, Neustart und Wechsel zwischen beiden Standorten. | Begrenzte öffentliche Abrufe und Rückwege vor/nach neuen Zieldaten bestanden. |
| Privater Heim-VPN | Enge Geräte-/Dienstfreigabe, unabhängige Anbieter- und Hostfiltersperre, SSH/SFTP, Website, Neustart, Geräteentzug und erneute Aufnahme. | Bestanden; die bestehende Testsitzung endete im beobachteten Entzugsversuch nach 9,269 Sekunden. Keine allgemeine Anbieterzeit zugesagt. |
| Mobilfunk und feste Tunnelroute | iPhone über 5G; später zusätzlich feste geschützte Cloudflare-Adresse mit Start- und Terminseite. Normales DNS, gültiges HTTPS, Ursprungsausfall, Connectorstopp und positive Rückkehr getrennt geprüft. | Die jeweiligen Browser-/Außenwege bestanden. Der frühe reine VPN-HTTP-Abruf allein ist kein Zertifikatsnachweis. |
| Connector-Zugang widerrufen | Alter Token nach Rotation bei neuer Verbindung abgewiesen; aktueller Zugang verbunden und unabhängig gesichert. | Widerruf für neue Verbindungen bestanden. |

## Rückweg und Abschluss

Nach der Switchprobe wurden alle 28 ursprünglichen Portwerte und ausschließlich VLAN 1 wiederhergestellt und gespeichert. Die zusätzlichen Serveranschlüsse wurden deaktiviert, eigene Laufzeitnetze und Hilfen entfernt. Die bestehende Verwaltung und andere laufende Arbeiten blieben erhalten.

Alle öffentlichen Laborrouten, eigenen DNS-Testeinträge und zusätzlichen Webfreigaben wurden wieder geschlossen. Testgeräte im Lern-VPN entfernt, eigene Heim-VMs ausgeschaltet. Das Mietlabor wurde nach unabhängiger Archivprüfung beendet. Die Berichte beschreiben abgeschlossene Versuche, keine dauerhaft erreichbare Vorführumgebung.

## Wo die Aussage endet

Die physische Switchprobe belegt die untersuchte Layer-2-/Port-/Tag-Strecke. Sie ist kein vollständiger physischer OPNsense-Drei-Port-Aufbau. Zwei zusätzliche Beobachtungen ohne geeigneten Empfangspunkt im Privat-VLAN wurden ausdrücklich nicht als Sperrnachweis gezählt. Ein vollständiger unabhängiger Switch-Konfigurationsdownload konnte nicht bestätigt werden; die konkreten ursprünglichen Port- und VLAN-Werte wurden dagegen zurückgelesen und gespeichert.

USB-Start, konkrete Firmwaremenüs, weitere Treiber, Temperatur-/Verbrauchsmessungen und andere Switchmodelle sind nicht mitgeprüft. Virtuelle Gäste teilen eine Hypervisor-Ausfallgrenze. Ein geprüftes archiviertes VM-Abbild wird nicht als daraus gestartete VM ausgegeben.

Am vorhandenen Heimanschluss wird nach Anbieterklärung kein IPv6 bereitgestellt. Virtuelle Dokumentationspräfixe und ein statischer Laboralias beweisen weder einen realen Providerpräfixwechsel noch dessen dynamischen Alias. Andere Anbieter, kostenpflichtige Skalierung, vollständiger Kontoverlust und alle nativen Desktop-VPN-Varianten bleiben getrennte Umfänge.

[Zur Prüfübersicht](README.md)
