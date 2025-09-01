# Lab 2: Ethernet Frameformate 

![Toplogy Lab-2](img/lankurs-lab2.svg#only-light)
![Toplogy Lab-2](img/lankurs-lab2-dark.svg#only-dark)

/// caption
Lab Topology
///


In dieser Laborübung sollst du nach dem Starten des Containerlab Labors (gleiche Aufbau wie Lab-2) einen Wireshark Trace auf dem Interface e0/1 von SW1 starten und analysieren. Versuche, für so viele verschiedene Ethernet-Frametypen, die ihr im Kurs kennengelernt habt, Beispiele zu finden. Nutzte dazu die folgende Grafik und bei Bedarf die Details in den LAN-Kurs Folien (Seiten 140-157).

![Ethernet Frames](img/ethernet-frametypen.png)

!!! question "Aufgabe"
    Ergänze die Werte in der folgenden Tabelle für die gefundenen Frametypen (auch gerne mehr als ein Protokoll pro Frametyp, sofern möglich). Notiere dabei die Feldinhalte (Länge/Ethertype, DSAP/SSAP), ob ein SNAP Header vorhanden ist (ja/nein) und welches Protokoll diesen Frame produziert hat.

    Optionale Zusatzaufgabe: Notiere im Feld Bemerkungen, ob es sich um einen Unicast-, Multicast- oder Broadcast-Frame handelt.


    | Paket-Nr.     | Frame-Typ              | Länge bzw. Ethertype      | LLC Header (DSAP/SSAP)     | SNAP? j/n | Protokoll       | Bemerkung                                           |
    |---------------|------------------------|---------------------------|----------------------------|-----------|-----------------|-----------------------------------------------------|
    |               |                        |                           |                            |           |                 |                                                     |
    |               |                        |                           |                            |           |                 |                                                     |
    |               |                        |                           |                            |           |                 |                                                     |

!!! info
    Mögliche Frame-Typen sind:

    - Ethernet II
    - 802.3
    - 802.3 + LLC
    - 802.3 + LLC + SNAP

!!! question "Frage"
    Für einen Frametyp wirst du vermutlich kein Beispiel entdecken, welcher ist das?

!!! note
    Das Netzwerk sollte ohne weiteren Einfluss von dir (z.B. Ping-Befehl auf einen PC) ein oder mehrere Beispiele für die verschiedenen Frametypen liefern (mit Ausnahme eines Typs).
