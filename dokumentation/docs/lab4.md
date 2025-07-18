# Lab 4: Ethernet, ARP & IP Adressen

![Toplogy Lab-2](img/lankurs-lab2.svg#only-light)
![Toplogy Lab-2](img/lankurs-lab2-dark.svg#only-dark)

/// caption
Lab Topology
///

# Wireshark-Lab: Ethernet und ARP

In dieser Übung analysierst du das **Ethernet-Protokoll** und das **Address Resolution Protocol (ARP, RFC 826)**. Bevor du startest, stelle sicher, dass du die Grundlagen des Ethernet-MAC-Layers und von ARP verstanden hast.

ARP wird von einem IP-System verwendet, um zu einer bekannten IP-Adresse die passende MAC-Adresse zu ermitteln.

## Vorbereitung

- Verbinde VS Code mit dem GitHub Codespace
- Starte das Lab-4 im GitHub Codespace
- Installiere Edgeshark im GitHub Codespace

## Erste Aufgabe: Ping-Test mit Wireshark-Mitschnitt

Nach dem Lab-4 erfolgreich gestartet wurde:

- Verbinde dich mit der Kommandozeile von PC1 (Attach)
- Starte einen Wireshark-Mitschnitt auf dem Interface `eth1` von PC1 (damit werden die Pakete auf dem Link zwischen PC1 und SW1 aufgezeichnet)
- Führe auf PC1 folgenden Ping-Befehl aus (Ziel ist die IP-Adresse von PC3 hinter dem Router R1 an SW2):
    * `ping 192.168.12.11`
- Ping-Befehl nach ca. 5 Pings mit ++ctrl+c++ stoppen
- Wireshark Aufzeichnung stoppen

## Analyse der ersten Ping-Anfrage

Suche in der Wireshark-Paketliste das **erste Ping-Paket (ICMP Echo Request)**. Markiere es und beantworte die folgenden Fragen:

!!! question "Fragen"
    - Welche 48-Bit-Ethernet-Adresse hat der Sender?
    - Wie lautet die Ethernet-Adresse des Empfängers?
        * Ist das die Ethernet-Adresse von PC3? Wenn nein: Wessen Ethernet-Adresse ist es?
    - Welcher hexadezimale Wert steht im Ethernet Frametyp-Feld?
        * Was bedeutet dieser Wert?

## Analyse der Ping-Antwort

Suche das **erste Ping-Antwortpaket (ICMP Echo Reply)** und beantworte die folgenden Fragen:

!!! question "Fragen"
    - Wie lautet die Ethernet-Adresse des Senders?
        * Gehört die Ethernet-Adresse dem Sender oder dem Empfänger? Wenn nein: Von Welchem Gerät stammt die Ethernet-Adresse?
    - Welche Ziel-Ethernet-Adresse steht im Paket?
        * Ist das die Adresse von PC1?
    - Welcher hexadezimale Wert steht im 2-Byte Ethernet Frametyp-Feld?
        * Was bedeutet dieser Wert?
        * Welche weiteren Typfeld-Werte kennst du?

## ARP-Tabelle betrachten

- Mit dem Befehl `arp -a` auf PC1 die ARP-Tabelle anzeigen
- Für den Fall, dass die Tabelle leer ist (nach 5 Minuten ist die Lebenszeit der Einträge abgelaufen) oder keine Einträge mehr enthalten sind, die mit `192.168.` beginnen:
    * Wiederhole den Ping von PC1 nach PC3
    * Dann erneut auf PC1 `arp -a` ausführen

!!! question "Aufgabe"
    Notiere die ARP-Tabelle und erkläre:
    - Die Bedeutung der Spalten
    - Die Bedeutung der Einträge

## ARP-Tabelle löschen

- Lösche die ARP-Tabelle durch Eingabe des Befehls `arp -d <ip-adresse>` auf PC1 (einzeln für jede Adresse die mit `192.168.` beginnt)
- Kontrolliere den Inhalt der ARP-Tabelle: `ip neighbor show`
- Die Tabelle sollte nun leer sein

## Erneuter Mitschnitt mit Wireshark

- Starte Wireshark auf Interface `eth1` von PC1
- Wiederhole den Ping von PC1 nach PC3
- Stoppe den Ping-Befehl auf PC1 nach 4-5 Pings über ++ctrl+c++
- Achte darauf: Du willst diesmal **nur Ethernet- und ARP-Pakete** sehen
    * Hierfür passen wir die Wireshark-Ansicht entsprechend an und schalten die Protkollunterstützung für IPv4 aus

## Protokollunterstützung für IPv4 deaktivieren

- Gehe im Wireshark-Menü auf: `Analyse >> Protokolle aktivieren`
- Deaktiviere **IPv4** durch Abwählen des entsprechenden Kästchens

## Analyse des ARP-Requests

Suche in Wireshark das **ARP-Request-Paket**, markiere es und beantworte die folgenden Fragen:

!!! question "Fragen"
    - Wie lauten die Werte für Quell- und Zieladresse im Ethernet-Frame?
    - Welchen hexadezimalen Wert hat das Ethernet Frametyp-Feld und welche Bedeutung hat dieser Wert?
    - Nach wie vielen Bytes ab Frame-Beginn beginnt das Opcode-Feld („Operation“)? => Byteansicht in Wireshark einblenden
    - Welcher Wert steht im Opcode/Operation-Feld?
        * Welche Art ARP-Paket ist das?
    - Enthält das ARP-Request-Paket die IP-Adresse des Senders?
    - Wo steht im ARP-Request die IP-Adresse des Systems, dessen MAC-Adresse erfragt wird?

## Analyse des ARP-Replies

Finde das **ARP-Reply-Paket** und beantworte die folgenden Fragen:

!!! question "Fragen"
    - Nach wie vielen Bytes ab dem Beginn des ARP-Replies beginnt das Opcode-Feld? => Byteansicht in Wireshark einblenden
    - Welcher Wert steht im Opcode/Operation-Feld?
    - Wo im ARP-Reply-Paket steht die Antwort auf die im ARP-Request gestellte Frage?
        * Wo im Paket findet man die IP-Adresse, die zur MAC-Adresse gehört?
    - Welches sind die hexadezimale Werte der Quell- und Zieladressen des ARP-Replies?
        * Welchen Systemen gehören diese Adressen?

## Wireshark-Ansicht zurücksetzen

- Gehe im Wireshark-Menü wieder auf: `Analyse >> Protokolle aktivieren`
- Aktiviere Protokollunterstützung für IPv4 wieder durch Anwahl des entsprechenden Kästchens

## Bonus-Aufgabe: Tracefile-Analyse

- Öffne in Wireshark das Tracefile: `ethernet-wireshark-trace-1.pcapng`
- Betrachte die ersten beiden ARP-Pakete:
    * ARP-Request deines Rechners mit Wireshark
    * ARP-Reply des PCs, nach dessen MAC-Adresse im ARP-Request gefragt wurde 

!!! info
    In diesem Szenario läuft Wireshark auf dem Rechner, welcher den ARP-Request gesendet hat.

!!! question "Frage"
    In diesem Netzwerk hat ein weiterer Rechner einen ARP-Request (siehe Paket Nr. 6) gesendet. Warum ist dazu kein passender ARP-Reply im Tracefile enthalten?

!!! note
    Diese Aufgabe ist unabhängig von den vorherigen Übungen.
    Der PC mit Wireshark war an einem **Standard-Switchport** und nicht an einem Mirror-Port angeschlossen.







