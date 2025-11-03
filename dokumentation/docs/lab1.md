# Lab 1: Containerlab & Wireshark

Der [Network Protocol Analyzer _Wireshark_](https://wireshark.org) ist die am meisten genutzte Software für die Netzwerk Paketanalyse. Wireshark ist ein Open Source Programm, das für private und kommerzielle Zwecke frei genutzt werden kann. Ein Network Protcol Analyzer kann Netzwerk Pakete aufzeichnen sowie die in den Paketen übertragenen Netzwerkprotokolle analysieren und unterstützt Netzwerkadminstratoren somit bei der Fehlersuche. Die Funktionen von Wireshark sind auch hervoragend geeignet, um den Aufbau von Netzwerkframes, -paketen und -segmenten sowie die Funktionsweise von Netzwerkprotokollen auf den verschieden Schichten des ISO/OSI Modells darzustellen, weshalb _Wireshark_ hervorragend für Ausbildungszwecke geeignet ist.

In dieser Übung gehen wir die ersten Schritte mit Wireshark. Hierzu arbeiten wir wieder mit Containerlab im GitHub Codespace, starten ein Labornetzwerk und zeichen mit Wireshark einen _Ping_ von PC1 nach PC3 auf.

!!! info
    Der _Ping-Befehl_ basiert auf dem _ICMP-Protokoll_, welches im Rahmen dieses Kurses zu einem späteren Zeitpunkt detailliert behandelt wird. Für den Moment soll genügen, dass der Ping-Befehl genutzt werden kann, um z.B. die Funktion einer Netzwerkverbindung zwischen zwei Endgeräten im Netzwerk zu überprüfen. Hierzu schickt ein Endgerät einen sog. _Ping-Request_ an ein anderes Endgerät im Netzwerk. Funktioniert die Netzwerkverbindung, erreicht der Ping-Request des ersten Endgeräts das zweite Endgerät und letzteres antwortet auf den empfangenen _Ping-Request_ mit einem _Ping-Reply_ an das erste Endgerät.

    Ein Ping, z.B. von PC1 nach PC3 wird auf der Kommandozeile von PC1 durch die Eingabe des Befehls `ping 192.168.12.11` gestartet, wobei `192.168.12.11` die IP-Adresse von PC3 darstellt, über welche PC3 für andere Endgeräte im Netzwerk erreichbar ist.

![Toplogy Lab-1](img/lankurs-lab2.svg#only-light)
![Toplogy Lab-1](img/lankurs-lab2-dark.svg#only-dark)

/// caption
Lab Topology
///

Die dafür notwendigen Schritte sind:

- GitHub Codespace starten
- Containerlab _Lab-1_ starten (Deploy)
- Mit Kommandozeile von PC1 verbinden
- Ping-Befehl zwischen PC1 und PC3 starten
- Ping-Pakete zwischen PC1 und PC3 mit Wireshark aufzeichen
- Ping-Befehl und Wireshark-Aufzeichnung stoppen
- Paketaufbau Ping Request Paket
- Paketaufbau Ping Response Paket
- Containerlab _Lab-1_ stoppen (Destroy)
- _GitHub Codespace_ stoppen

## Codespace starten

Um mit der Laborumgebung zu arbeiten, wird der angelegte GitHub Codespace aus dem geforkten Repository gestartet. Während des Starts wird eine Browserversion von Visual Studio Code mit integriertem _Containerlab_ Plugin gestartet:

??? info "Screenshots: _GitHub Codespace starten_"
    ![start-codespace-1](img/github-codespace-starten-01-hell.png)
    ![start-codespace-1](img/github-codespace-starten-02-hell.png)
    ![start-codespace-1](img/github-codespace-starten-03-hell.png)
    ![start-codespace-1](img/github-codespace-starten-04-hell.png)
    ![start-codespace-1](img/github-codespace-starten-05-hell.png)
    ![start-codespace-1](img/github-codespace-starten-06-hell.png)

## Containerlab _Lab-1_ starten (Deploy)

- Containerlab-Bereich auswählen (über Containerlab Symbol im linken Randmenü)
- Im Bereich `UNDEPLOYED LOCAL LABS` das Verzeichnis `labs/Lab-1` öffnen
- Rechtsklick auf Datei `topology.clab.yml` und Start des Labors über Menüeintrag `Deploy`
- Optional: Im Informations-Dialog unten rechts `View Logs` klicken, danach kann man die Logmeldungen während des Starts im Bereich `OUTPUT` beobachten:
    * Fehlende Conatainer-Images werden aus der GitHub Docker Registry `ghcr.io` heruntergeladen und gespeichert
    * Labor Nodes werden gestartet und Verbindungen zwischen den Nodes etabliert
- Nach dem Start im Bereich `RUNNING LABS`:
    * Node Status wird farbig bzw. als `Up`/`Down` angezeigt
    * Status der einzelen Nodes durch _aufklappen_ des Labs angezeigt
- Alternativ kann die ausgewähle Topology Datei über die folgende Tastenkombination _deployed_ werden: ++ctrl+alt+d++

??? info "Screenshots: _Lab starten_"
    ![start-codespace-1](img/deploy-lab2-1.png)
    ![start-codespace-1](img/deploy-lab2-2.png)
    ![start-codespace-1](img/deploy-lab2-3.png)
    ![start-codespace-1](img/deploy-lab2-4.png)
    ![start-codespace-1](img/deploy-lab2-5.png)
    ![start-codespace-1](img/deploy-lab2-6.png)
    ![start-codespace-1](img/deploy-lab2-7.png)
    ![start-codespace-1](img/deploy-lab2-8.png)
    ![start-codespace-1](img/deploy-lab2-9.png)


## Ping-Befehl zwischen PC1 und PC3 starten

- Shell-Verbindung zu PC1 aufbauen (Attach)
- Ping-Befehl in der Shell von PC1 starten

??? info "Screenshots: _Attach Shell PC1 und Ping starten_"
    ![start-codespace-1](img/attach-shell-var2.png)
    ![start-codespace-1](img/ping-lab2-pc1-pc3.png)

## Ping-Pakete zwischen PC1 und PC3 mit Wireshark aufzeichen

- Interface-Ansicht von PC1 im Bereich `RUNNING LABS` aufklappen
- Rechtsklick auf Interface `eth1`
- Im Kontektmenü von PC1 `Capture interface (Edgeshark VNC)` auswählen
- Der Network Packet Analyzer Wireshark wird gestartet und zeichnet die von PC1 ausgehenden Ping-Pakete auf

!!! info
    Die PCs in den _Containerlab_ Labs haben zwei Interfaces:

    - `eth0`: Containerlab Management Interface
    - `eth1`: Mit Labornetzwerk verbundenes Interace

??? info "Screenshots: _Ping-Pakete mit Wireshark aufzeichnen_"
    ![start-codespace-1](img/wireshark-capture-ping-01.png)
    ![start-codespace-1](img/wireshark-capture-ping-02.png)
    ![start-codespace-1](img/wireshark-capture-ping-03.png)

## Ping-Befehl und Wireshark-Aufzeichnung stoppen

- Im Terminalfenster von PC1 im Bereich `TERMINAL` über ++ctrl+c++ den Ping-Befehl beenden
- Wiresharkaufzeichnung über das rote Stopp-Symbol in der Symbolleiste von Wireshark beenden (Aufzeichnung kann bei Bedarf über das Symbol der blauen Haifischflosse wieder gestartet werden)

??? info "Screenshots: _Aufgezeichnete Ping-Pakete anzeigen_"
    ![start-codespace-1](img/stop-ping.png)
    ![start-codespace-1](img/wireshark-stopp-capture-symbol.png)
    ![start-codespace-1](img/wireshark-start-capture-symbol.png)

## Paketaufbau Ping Request Paket

Im aufgezeichneten Ping Request Paket (Paket-Nr. 3) sind die einzelnen Paketbestandteile zu sehen. Im der oberen Hälfte des Fensters wird die Paketliste angezeigt, in der unteren Hälfte die Details des in der Pakeztliste selektierten Pakets.

Im Detailfenster erkennt man die wesentlichen Bestandteile von Datenpaketen im Netzwerk:

- Ethernet Frame mit MAC-Adressem (Quell- und Zieladresse)
- IP Paket mit IP-Adressen (Quell- und Zieladresse)
- Payload, hier: ICMP Ping Request (Type 8, Code 0)

Ein Ping Request 

??? info "Screenshots: _Paket-Details ping Request_"
    ![start-codespace-1](img/ping-request-packet-1.png)
    ![start-codespace-1](img/ping-request-packet-2.png)
    ![start-codespace-1](img/ping-request-packet-3.png)

## Paketaufbau Ping Reply Paket

Die Details der Anwort der Gegenstelle auf das Ping-Paket (Ping-Reply in Paket-Nr. 4) sind analog aufgebaut. Auch finden wir:

- Ethernet Frame mit MAC-Adressem (Quell- und Zieladresse)
- IP Paket mit IP-Adressen (Quell- und Zieladresse)
- Payload, hier: ICMP Ping Reply (Type 0, Code 0)

??? info "Screenshots: _Paket-Details ping Reply_"
    ![start-codespace-1](img/ping-reply-paket.png)

## Containerlab _Lab-1_ stoppen (Destroy)

Das gestartete Labor kann über die Auswahl des Befehls `Destroy` im Kontextmenü von Lab-1 im Bereich `RUNNING LABS` beendet werden.

??? info "Screenshot: _Stopp (Desroy) Lab-1_"
    ![start-codespace-1](img/destroy-containerlab-lab-2-1.png)
    ![start-codespace-1](img/destroy-containerlab-lab-2-2.png)

!!! warning
    Wird dss Containerlab Labor nicht gestoppt, wird es nach einem Neustart des GitHub Codespaces automatisch wieder gestartet. Wurde das Labor vor dem Beenden des Codespaces gestoppt, wird es beim Neustart des Codespaces nicht automatisch wieder gestartet.

!!! tip
    Am Ende einr Laborübung das Containerlab stoppen, um beim Neustart des Codespaces vor der Bearbeitung einer neuen Laborübung wieder die gleichen Bedingungen vorzufinden.

## Codespace im GitHub Repository _clab_lankurs_ stoppen

- Ansicht __clab-lankurs__ GitHub Repository öffnen
- Über grünen Button `<> Code` + Reiter `Codespaces` (Codespace wird als `Active` angezeigt) + `...`-Menü im Bereich `On current branch` den Eintrag `Stop codespace` auswählen
- Codespace mit Simulationsumgebung wird gestoppt

??? info "Screenshots: _Stopp Codespace (GitHub)_"
    ![start-codespace-1](img/stop-codespace-var2-1.png)
    ![start-codespace-2](img/stop-codespace-var2-2.png)
    ![start-codespace-3](img/stop-codespace-var2-3.png)
