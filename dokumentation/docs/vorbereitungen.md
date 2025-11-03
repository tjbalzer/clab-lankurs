# Vorbereitungen für die Netzerksimulationen und Übungen

Die Übungen für den Netzwerk-Kurs werden über ein GitHub-Repository zur Verfügung gestellt. Mit Hilfe von virtualisierten _Cisco IOS Images_, welche in _Docker Containern_ ausgeführt werden, erfolgt die Simulation von Netzwerkgeräten (Router und Switches). Als Simulationsumgebung dient die Open Source Software [_Containerlab_](https://Github.com/hellt/containerlab) von Nokia, welche die Container orchestriert. Der Aufbau eines simulierten Netzwerkes wird in einer sogenannten Topology-Datei in YAML-Syntax beschrieben, welche _Containerlab_ beim Start eines Labs einliest und das Labor entsprechend einrichtet und konfiguriert.

Die Laborübungen ie Netzwerk-Simulationen laufen in sog. [Dev Containern](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/introduction-to-dev-containers) auf [GitHub Codespaces](https://docs.github.com/en/codespaces). _GitHub Codespaces_ sind virtuelle Maschinen, die auf GitHub gehostet werden und angepasst an die benötigte Systemumgebung in einem _GitHub Repository_ angelegt werden können. Ein kostenloser GitHub Account enthält derzeit (Juni 2025) monatlich 60 CPU-Stunden für die Nutzung von Codespace.

Um dies zu ermöglichen, benötigt jeder Kursteilnehmer einen eigenen GitHub-Account und eine Kopie (Fork) des entsprechenden GitHub-Repositories mit den [Netzwerkübungen](https://github.com/tjbalzer/clab-lankurs).

### GitHub Sign-up

!!! info
    Bereits bestehende GitHub-Accounts der Teilnehmer können ebenfalls genutzt werden. In diesem Fall weiter im Abschnitt [GitHub Sign-in](vorbereitungen.md#github-sign-in).

Ein GitHub Account wird wie folgt angelegt:

#### GitHub-Startseite in Webbrowser öffnen

[GitHub-Startseite](https://github.com) in Webbrowser öffnen und Sign-up Button auswählen:

??? info "Screenshots: _GitHub Sign-up_"
    ![GitHub aufrufen](img/github-profil-anlegen-1.png)
    ![GitHub Sign-up #1](img/github-profil-anlegen-2a.png)

#### Benutzername und Passwort anlegen

- E-Mail Adresse eintragen
- Passwort eintragen und merken 🙂
- Gewünschten Usernamen eingeben (GitHub prüft Verfügbarkeit, Usernamen ggf. anpassen)
- Country/Region _Germany_ auswählen
- Button _Continue_ auswählen

??? info "Screenshot: _Beispiel Sign-up Dialog mit ausgefüllten Feldern_"
    ![GitHub Sign-up #2](img/github-profil-anlegen-2b.png)

#### GitHub Account verifizieren

Der neue GitHub Account wird nun verifziert (hier am Beispiel _Bilderrätsel_ dargestellt):

- Button _Bilderrätsel_ auswählen
- Im rechten Bild angezeigte Grafik über rechts/links-Pfeile solange ändern, bis sie den im Text dargestellten Vorgaben entspricht
- Auswahl über den Button _Absenden_ bestätigen
- Bestätigungsnachricht wird angezeigt, wenn die Auswahl korrekt war, ansonsten wird ein neues Bilderrätsel angezeigt

??? info "Screenshots: _Account Verification_"
    ![GitHub Verification #1](img/github-profil-anlegen-3a.png)
    ![GitHub Verification #2](img/github-profil-anlegen-3c.png)
    ![GitHub Verification #3](img/github-profil-anlegen-3d.png)

#### E-Mail Adresse bestätigen

Nach den Account Verifikation wird die E-Mail Adresse überprüft:

- Posteingang auf Nachricht von GitHub mit Bestätigungscode prüfen
- Bestätigungscode in den Feldern unter _Enter Code_ eintragen
- Eingabe über den Button _Continue_ abschließen (dadurch werden auch die GitHub _Terms of Service_ angenommen)
- Es folgt die Anzeige der GitHub Sign-in Seite

??? info "Screenshot: _E-Mail Adresse bestätigen_"
    ![GitHub Verification #4](img/github-profil-anlegen-4.png)
    ![GitHub Verification #5](img/github-profil-anlegen-5.png)

### GitHub Sign-in

Anmelden mit den Benutzerdaten des neu angelegten oder eines bereits bestehenden GitHub-Profils:

??? info "Screenshot: _Beispiel GitHub Sign-in_"
    ![GitHub Sign-in](img/github-anmeldung-1.png)
    ![GitHub Sign-in](img/github-anmeldung-2.png)

## _Forken_ des GitHub-Repositories für die Netzwerkübungen

Die Übungen werden über das GitHub Repository [clab-lankurs](https://github.com/tjbalzer/clab-lankurs) des GitHub Users _tjbalzer_ zur Verfügung gestellt. GitHub Codespaces werden einem GitHub-Repository zugeordnet und können nur vom Eigentümer des Repositories ausgeführt werden, wenn dieser mit seiner GitHub-Userid angemeldet ist. Deshalb muss das _clab-lankurs_ GitHub-Repository von der GitHub-Seite des GitHub-Nutzers _tjbalzer_ in das jeweilige GitHub-Konto jedes Kursteilnehmers kopiert (_geforkt_) werden.

Dieser _Fork_ des Original GitHub-Repositories wird wie folgt erstellt:

- Öffnen der GitHub-Webseite des _clab-lankurs_ Repositories: [https://github.com/tjbalzer/clab-lankurs](https://github.com/tjbalzer/clab-lankurs)
- Button _Fork_ auswählen, um das _clab-lankurs_ Repository als eigenes Repository in die GitHub-Umgebung des Nutzers zu kopieren
- Fork durch Bestätigung der Eingabemaske _Create a new fork_ über den Button _Create fork_ erstellen

??? info "Screenshot: _LAN-Kurs Repository forken_"
    ![Fork erstellen #1](img/create-lankurs-fork-1.png)
    ![Fork erstellen #2](img/create-lankurs-fork-2.png)
    ![Fork erstellen #3](img/create-lankurs-fork-3.png)
    ![Fork erstellen #4](img/create-lankurs-fork-4.png)


## Dev Container in GitHub Codespaces erstellen und starten

Die Netzwerk Labs sollen in einer virtuellen Maschine (VM) auf GitHub laufen. Die VM wird als [_Dev Container_](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/introduction-to-dev-containers) (auf GitHub auch [_Codespace_](https://docs.github.com/en/codespaces) genannt) definiert und erstellt. Das vereinfacht die zentrale Verwaltung, Aktualisierung und Verteilung der Simulationsumgebung und auf dem lokalen Rechner müssen - mit Ausnahme von Wireshark - keine Installationen vorgenommen werden. Der Dev Container ist im geforkten Repository in der Datei `.devcontainer/devocontainer.json` definiert und basiert auf einem [Containerlab Docker Container](https://containerlab.dev/manual/codespaces/) der SRL Labs:

``` JSON title="devcontainer.json"
{
    "image": "ghcr.io/srl-labs/containerlab/devcontainer-dind-slim:0.68.0", // (1)
    "hostRequirements": {
        "cpus": 2, // (2)
        "memory": "8gb", // (3)
        "storage": "32gb" // (4)
    }
}
```

1.  Definiert, welche Version des Containerlab Docker Containers verwendet werden soll
2.  Definiert die Anzahl der gewünschetn CPU Cores für die VM
3.  Definiert die Größe des RAM Speichers für die VM
4.  Definiert die Größe des Dateispeichers für die VM

Die Existenz der Datei `.devcontainer/devcontainer.json` im _clab-lankurs_ Repository wird von GitHub automatisch erkannt und wir können den Dev Container (Codespace) wie folgt erstellen:

- Auf der Hauptseite des geklonten Repositories _clab-lankurs_ den Button _<> Code_ auswählen
- Daraufin wird ein Dialog mit den Reitern _Local_ und _Codespaces_ angezeigt
- Auswahl des Reiters _Codespaces_ und Erstellung des Dev Containers über den Button _Create codespace on main_
- Die Erstellung des Codespaces dauert in der Regel 5-10 Minuten
- Über den Informationsdialog `Setting up remote connection` unten rechts kann durch klicken auf `Building codespace...` bei Bedarf das Log für den Aufbau im Bereich `TERMINAL` angezeigt und verfolgt werden
- Die Erstellung und der Start des Codepaces ist abgeschlossen, wenn unten links der Verbindungsstatus `>< Codespaces: <zufälliger Name des Codespaces>` angezeigt, im Hauptfenster die _Containerlab Willkommensnachricht_ erscheint und das Containerlab Symbol am linken Rand in der vertikalen Bedienleiste eingeblendet wird
- Codespace läuft und die Laborumgebung kann genutzt werden

!!! info
    Als _Default Idle Timeout_ für GitHub Codespaces sind 30 Minuten vorkonfiguriert. Nutzt man einen gestarteten Codespace für 30 Minuten nicht, wird der Codespace automatisch gestoppt.

!!! info
    Als _Default Retention Time_ für GitHub Codespaces sind 30 Tage vorkonfiguriert. Codespaces werden maximal 30 Tage nach der letzten Nutzung gelöscht.

!!! info
    Die Codepace-Einstellungen für seinen GitHub-Account erreicht man unter dem folgenden Link, wenn man bereits mit seinem Nutzernamen auf GitHub angemeldet ist: [https://github.com/settings/codespaces](https://github.com/settings/codespaces)

??? info "Screenshots: _Codespace erstellen_"
    ![Codespace erstellen #1](img/create-codespace-1.png)
    ![Codespace erstellen #2](img/create-codespace-2.png)
    ![Codespace erstellen #3](img/create-codespace-3.png)
    ![Codespace erstellen #4](img/create-codespace-4.png)
    ![Codespace erstellen #5](img/create-codespace-5.png)
    ![Codespace erstellen #6](img/create-codespace-6.png)

### Codespace Stoppen

- Ansicht __clab-lankurs__ GitHub Repository öffnen
- Über grünen Button `<> Code` + Reiter `Codespaces` (Codespace wird als `Active` angezeigt) + `...`-Menü im Bereich `On current branch`den Eintrag `Stop codespace` auswählen
- Codespace mit Simulationsumgebung wird gestoppt

??? info "Screenshots: _Stopp Codespace (GitHub)_"
    ![start-codespace-1](img/stop-codespace-var2-1.png)
    ![start-codespace-2](img/stop-codespace-var2-2.png)
    ![start-codespace-3](img/stop-codespace-var2-3.png)
