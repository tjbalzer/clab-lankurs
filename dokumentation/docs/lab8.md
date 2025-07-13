# Lab 8: Dynamic Host Configuration Protocol (DHCP)

Quelle: Orginalaufgabe als Ergänzung zu „Computer Networking: A Top-Down Approach“, 8. Auflage von J.F. Kurose und K.W. Ross (ins Deutsche übersetzt mit Hilfe von ChatGPT).

© 2005–2021, J.F. Kurose und K.W. Ross. Alle Rechte vorbehalten.

## Einführung

In diesem Lab werfen wir einen kurzen Blick auf das **Dynamic Host Configuration Protocol (DHCP)**.

Erinnere dich: DHCP wird in Unternehmens-, Hochschul- und Heimnetzwerken (LANs, egal ob Kabel oder WLAN) umfassend eingesetzt, um Hosts dynamisch IP-Adressen und andere Netzwerkinformationen zuzuweisen.  

Bevor du startest, sollte dir der Ablauf der Anforderung einer IP-Adresse über DHCP klar sein. Besonders die folgende Abbildung ist wichtig, da wir hier genau die Nachrichten **DHCP Discover, Offer, Request und ACK** untersuchen, die in dieser Abbildung gezeigt werden.

![Ablauf DCHP](img/dhcp-discover-offer-request-ack.svg#only-light)
![Ablauf DCHP](img/dhcp-discover-offer-request-ack-dark.svg#only-dark)

/// caption
Lab Topology
///

Wie in den früheren Wireshark-Labs wirst du ein paar gezielte Aktionen auf deinem Rechner ausführen, die DHCP in Gang setzen, und dann **Wireshark** verwenden, um den Datenverkehr aufzuzeichnen und zu analysieren.

## Paketmitschnitt erstellen

Die ersten beiden Schritte in Abbildung (Discover und Offer) sind technisch optional (d. h. sie müssen nicht immer auftreten, z. B. beim Verlängern einer bestehenden Adresse). Die Nachrichten **Request** und **ACK** sind jedoch immer erforderlich.

Damit du einen Mitschnitt bekommst, der **alle vier Nachrichtentypen** enthält, musst du ein paar Kommandos auf deinem Rechner ausführen.

### Auf einem Linux-Rechner

#### Variante 1 (aktuelle Ubuntu Versionen mit Network Manager, wie auf den Schulungs-Notebooks installiert)

- Öffne ein Terminalfenster und gib ein: `ip link`
!!! example "Beispiel-Ausgabe auf einem der Ubuntu Schulungs-Notebooks"
    ```
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    2: enp0s25: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc fq_codel state DOWN mode DEFAULT group default qlen 1000
        link/ether 28:d2:44:16:13:3f brd ff:ff:ff:ff:ff:ff
    3: wlp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DORMANT group default qlen 1000
        link/ether 6c:88:14:bf:13:c8 brd ff:ff:ff:ff:ff:ff
    4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
        link/ether 02:42:f1:45:2a:b0 brd ff:ff:ff:ff:ff:ff
    ```
- `wlp3s0` ist hier z.B. das WLAN-Interface, das du mitschneiden willst (prüfbar in Wireshark unter `Capture -> Options`)
- Gib als nächstes den folgenden Befehl ein: `sudo nmcli device disconnect wlp3s0`
    * Dieser Befehl deaktiviert das Interfaces (Bestätigung durch Meldung `Gerät "wlp3s0" wurde erfolgreich getrennt`)
- Nun muss die Lease-Datei gelöscht werden, da sonst die wieder gleiche IP-Adresse beim DHCP-Server angefordert wird (nur **Request und ACK** statt **Discover, Offer, Request und ACK**)
    * Befehl: `sudo ls /var/lib/NetworkManager/`
!!! example "Beispiel-Ausgabe auf einem der Ubuntu Schulungs-Notebooks"
    ``` SHELL
    ubuntu@t430-1:~$ sudo ls /var/lib/NetworkManager/
    internal-8fe6427d-8255-4205-8175-cc9d6cc6fb92-wlp3s0.lease NetworkManager.state seen-bssids
    NetworkManager-intern.conf  secret_key timestamps
    ```
- Löschen der Lease-Datei (hier: `internal-8fe6427d-8255-4205-8175-cc9d6cc6fb92-wlp3s0.lease`)
    * Befehl: `sudo rm /var/lib/NetworkManager/internal-8fe6427d-8255-4205-8175-cc9d6cc6fb92-wlp3s0.lease`
    * Leider ist es nicht möglich, den Dateinamen automatisch über ++tab++ zu ergänzen, weshalb dieser con Hand korrekt eingetippt werden muss
- Starte Wireshark und beginne mit der Aufzeichnung auf dem oben ermittelten Interface (hier: `wlp3s0`)
- Als nächstes folgt der Befehl: `sudo nmcli device connect wlp3s0`
    * Dieser Befehl reaktiviert das WALN-Interface `wlp3s0`
- Warte ein paar Sekunden und stoppe die Wireshark-Aufzeichnung

#### Variante 2 (wenn `dhclient` installiert ist)

- Öffne ein Terminalfenster und gib ein: `ip addr flush eth0`
    * `eth0` ist auch hier das Interface, das du mitschneiden willst (prüfbar in Wireshark unter `Capture -> Options`)
    * Dieser Befehl entfernt die aktuelle IP-Adresse des Interfaces 
- Als nächstes folgt der Befehl: `dhclient -r`
    * Dieser Befehl gibt bestehende DHCP-Leases frei
- Starte Wireshark und beginne mit der Aufzeichnung auf diesem Interface
- Gib anschließend ein: `sudo dhclient eth0`
    * Damit fordert dein Rechner vom DHCP-Server eine neue IP-Adresse und Konfigurationsdaten an
- Warte ein paar Sekunden und stoppe die Wireshark-Aufzeichnung

### Auf einem Windows-PC bzw. Smart Client (nur wenn Wireshark installiert ist)

- Öffne die Eingabeaufforderung und gib ein: `ipconfig /release`
    * Damit gibst du deine aktuelle IP-Adresse auf
- Starte Wireshark
- Gib in der Eingabeaufforderung ein: `ipconfig /renew`
    * Das startet eine neue DHCP-Anfrage und holt eine neue IP-Adresse samt Konfigurationsdaten vom DHCP-Server
- Warte ein paar Sekunden und stoppe dann die Wireshark-Aufzeichnung

### Auf einem Mac

- Öffne ein Terminalfenster und gib ein: `sudo ipconfig set en0 none`
    * `en0` steht hier beispielhaft für das Interface, auf dem du in Wireshark mitschneiden möchtest
    * Die Liste deiner Interfaces kannst du in Wireshark unter `Capture -> Options` einsehen 
    * Dieser Befehl entfernt die aktuelle Netzwerkkonfiguration des Interfaces
- Starte Wireshark und beginne mit der Aufzeichnung auf diesem Interface
- Gib danach im Terminal ein: `sudo ipconfig set en0 dhcp`
    * Dadurch fordert dein Rechner eine IP-Adresse und andere Netzwerkinformationen vom DHCP-Server an
- Warte ein paar Sekunden und stoppe dann die Wireshark-Aufzeichnung

### Nach der Aufzeichnung

- Überprüfe dein Wireshark-Fenster, um sicherzustellen, dass du tatsächlich DHCP-Pakete mitgeschnitten hast
- Gib in das Filterfeld ein: `dhcp`

Dein Bildschirm sollte dann alle relevanten DHCP-Nachrichten anzeigen.

!!! warning "Wichtig"
    Falls du Wireshark nicht auf einem Live-Netzwerk verwenden kannst, **oder nicht alle vier Nachrichtentypen in der Aufzeichnung enthalten sind**, kannst du stattdessen auch das vorgefertigte Tracefile `dhcp-wireshark-trace1-1.pcapng` verwenden, das alle vier Nachrichtentypen enthält.

## Analysefragen

Beantworte die folgenden Fragen zu deinem eigenen Mitschnitt **oder** zum bereitgestellten Tracefile.  

### DHCP Discover

1. Wird das DHCP Discover über UDP oder TCP transportiert?
2. Welche Quell-IP-Adresse wird im Discover-Datagramm verwendet?  
    * Was ist besonders an dieser Adresse? Erkläre.
3. Welche Ziel-IP-Adresse wird verwendet?  
    * Was ist besonders an dieser Adresse? Erkläre.
4. Welchen Wert hat das **Transaction ID**-Feld in der Discover-Nachricht?
5. Sieh dir das **Options-Feld** im DHCP Discover an.  
    * Nenne fünf Informationen (außer der IP-Adresse), die der Client darin vorschlägt oder anfordert.

### DHCP Offer

1. Woran erkennst du, dass diese Offer-Nachricht eine Antwort auf die zuvor untersuchte Discover-Nachricht ist?
2. Welche Quell-IP-Adresse wird im Offer-Datagramm verwendet?  
    * Was ist daran besonders? Erkläre.
3. Welche Ziel-IP-Adresse wird verwendet?  
    * Was ist daran besonders? Erkläre.  
    * **Hinweis:** Achte hier genau auf deinen Trace. Wenn du tiefer eintauchen willst, schau dir den [DHCP RFC 2131](https://www.rfc-editor.org/rfc/rfc2131.txt), Kapitel 4.3, an.
4. Sieh dir das Options-Feld im DHCP Offer an.  
    * Welche fünf Infos liefert der DHCP-Server dem Client darin?

### DHCP Request

1. Welche UDP-Quell- und Zielportnummern werden im DHCP Request verwendet?
2. Welche Quell-IP-Adresse hat das Request-Datagramm?  
    * Was ist daran besonders? Erkläre.
3. Welche Ziel-IP-Adresse wird verwendet?  
    * Was ist daran besonders? Erkläre.
4. Welchen Wert hat das **Transaction ID**-Feld im DHCP Request?  
    * Passt es zu den IDs der vorherigen Discover- und Offer-Nachrichten?
5. Sieh dir die **Parameter Request List** im Options-Feld an.  
    * Was steht dort?  
    * Welche Unterschiede erkennst du gegenüber der gleichen Liste im Discover-Paket?

### DHCP ACK

1. Welche Quell-IP-Adresse hat das ACK-Datagramm?  
    * Was ist daran besonders? Erkläre.
2. Welche Ziel-IP-Adresse wird im ACK verwendet?  
    * Was ist daran besonders? Erkläre.
3. Wie heißt das Feld in der DHCP ACK-Nachricht (im Wireshark-Fenster), das die **zugewiesene Client-IP-Adresse** enthält?
4. Für welchen Zeitraum (Lease Time) wird die IP-Adresse dem Client zugewiesen?
5. Welche IP-Adresse wird dem Client als **Standard-Gateway** (erste Hop-Adresse auf dem Weg ins Internet) mitgeteilt?
