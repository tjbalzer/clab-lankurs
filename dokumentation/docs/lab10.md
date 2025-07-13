# Lab 10: Network Time Protokoll (NTP)

Quelle: Erstellt mit Hilfe von ChatGPT.

In dieser Übung wirst du **NTP-Pakete mit Wireshark aufzeichnen und analysieren**.

Das Ziel ist es, ein Gefühl dafür zu bekommen, **wie NTP-Clients und -Server miteinander kommunizieren** und welche Informationen in den Paketen enthalten sind.

## Ziel der Übung

- Verstehen, wie ein NTP-Client mit einem Server kommuniziert
- NTP-Pakete identifizieren und analysieren können
- Die Bedeutung der wichtigsten Felder (Stratum, Mode, Timestamps) nachvollziehen
- Weitere Sicherheit im Umgang mit Wireshark gewinnen

## Aufgabenbeschreibung

- Starte Wireshark auf deinem Rechner
- Verwende einen NTP-Client oder einfach den Systembefehl, um deinen Rechner mit einem öffentlichen NTP-Server zu synchronisieren. Zum Beispiel: `ntpdate -q pool.ntp.org` oder `sudo ntpdate pool.ntp.org`
- Zeichnet währenddessen den Netzwerkverkehr mit Wireshark auf.  
- Nutzt den Filter, um nur NTP-Pakete zu sehen: `udp.port == 123`
- Stoppt die Aufzeichnung, sobald der Austausch abgeschlossen ist.

## Analysefragen

Beantwortet die folgenden Fragen anhand eurer Aufzeichnung. Diskutiert die Antworten gerne im Team:

1. Wie viele NTP-Anfragen und -Antworten wurden insgesamt aufgezeichnet?  
2. Welche IP-Adresse hatte der angefragte NTP-Server?  
3. Über welches Transportprotokoll (UDP/TCP) wurde NTP übertragen?  
4. Welcher Port wird für NTP verwendet?  
5. Welche „Mode“-Werte (im NTP-Paket) siehst du? Was bedeuten diese?  
6. Wie sieht das Stratum-Feld in der Antwort aus? Was bedeutet der angezeigte Wert?  
7. Welche Zeitinformationen (z. B. Transmit Timestamp) liefert dir das NTP-Paket?  
8. Wie kannst du erkennen, welche der Pakete Anfragen und welche Antworten sind?  
9. Gibt es Hinweise auf Verzögerung (Delay) oder Abweichung (Offset), die Wireshark berechnet?  
10. Inwiefern hilft dir diese Analyse, die NTP-Grundlagen besser zu verstehen?


## Bonus-Aufgabe

Finde in der Wireshark-Analyse heraus, ob dein Rechner mehrere Server kontaktiert hat (z. B. weil ein Pool verwendet wurde). Welche Unterschiede erkennst du zwischen den Antworten?
