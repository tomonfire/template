# Quickstart: neues Projekt in 10 Minuten

Kurzanleitung zum Nachlesen. Alles läuft im Browser, du musst nichts installieren.

## 1. Repository anlegen (2 Minuten)

1. Öffne <https://github.com/tomonfire/template>.
2. Klicke auf den grünen Button **Use this template**, dann **Create a new repository**.
3. Gib einen **Namen** ein und wähle **Public**. Das ist wichtig, denn nur öffentliche Repos bekommen alles kostenlos.
4. Klicke **Create repository**.

## 2. Codespace öffnen (2 Minuten)

Ein Codespace ist ein Computer im Browser, bei dem schon alles installiert ist.

1. Im neuen Repo auf den grünen Button **Code** klicken, den Reiter **Codespaces** öffnen und
   **Create codespace on main** wählen.
2. Warten, bis sich der Editor öffnet. Unten erscheint das **Terminal**, in das du die Befehle tippst.

## 3. Projekt einrichten (5 Minuten)

Diese Befehle der Reihe nach ins Terminal eingeben und jeweils mit Enter bestätigen.

**a) Programmiersprache wählen.** Damit legst du den **Inhalt** fest: Startprogramm, Tests und Prüfungen.

```bash
./scripts/init-stack.sh list      # zeigt alle Möglichkeiten
./scripts/init-stack.sh web       # Beispiel: Webseite (im Zweifel sonst: python)
```

**b) Speichern.** Das muss vor Schritt d passieren, weil danach direkte Änderungen an `main` gesperrt sind.

```bash
git add -A && git commit -m "feat: set up project" && git push
```

**c) Bei GitHub anmelden.** Das Skript braucht dafür Admin-Rechte.

```bash
unset GITHUB_TOKEN
gh auth login
```

Bei den Fragen wählst du nacheinander **GitHub.com**, **HTTPS**, **Y** und **Login with a web browser**.
Kopiere den angezeigten Code, drücke Enter und bestätige im Browser.

**d) GitHub einrichten.** Damit überträgst du die **Einstellungen**: Schutzregeln, Webseiten-Hosting,
Vorschau/Staging/Produktion, Sicherheit und Labels. GitHub kopiert sie beim Template nicht mit.

```bash
./scripts/setup-github.sh
```

## 4. Aufräumen (1 Minute)

- `README.md` und `AGENTS.md` (Abschnitt **Projekt**) in 2–3 Sätzen ausfüllen: Worum geht es, für wen?
- Kurzbeschreibung bei GitHub: Repo-Seite → rechts bei **About** auf ⚙️ klicken.
- Den Codespace löschen: <https://github.com/codespaces>, dort **⋯** und dann **Delete**.

**Fertig.** Ab jetzt arbeitest du nur noch so wie unten beschrieben.

---

## Im Alltag: eine Idee umsetzen

```text
Idee ──► /team ──► Pull Request ──► Vorschau ansehen ──► Merge ──► Staging ──► Release ──► Live
```

1. In Claude Code schreiben: `/team Ich möchte …`
   - Der **Business Owner** stellt Rückfragen und schreibt die Anforderungen auf.
   - **Developer** und **UI/UX-Experte** setzen sie um, der **QA-Reviewer** prüft das Ergebnis.
2. Claude erstellt einen **Pull Request**. Darin erscheint automatisch ein Link zur **Vorschau**.
3. Gefällt dir die Vorschau, wird der Pull Request **gemergt**. Die Änderung landet dann in **Staging**.
4. GitHub sammelt die Änderungen in einem **Release-PR** („chore(main): release x.y.z“).
   Mergst du ihn, entsteht eine neue Version. Den Haken
   **„Merge without waiting for requirements to be met (bypass rules)“** setzen.
   Bei Release-PRs laufen keine Prüfungen, das ist normal.
5. **Live schalten:** *Actions → Deploy production → Review deployments → Approve*.

## Wo finde ich was?

| Was                     | Wo                                                                 |
| ----------------------- | ------------------------------------------------------------------ |
| Vorschau einer Änderung | Link im Kommentar des Pull Requests                                |
| Staging                 | `https://<dein-name>.github.io/<repo>/staging/`                    |
| Live-Version            | `https://<dein-name>.github.io/<repo>/`                            |
| Alle Versionen          | Repo-Seite → **Releases**                                          |
| Was gerade läuft        | Repo-Seite → **Actions**                                           |
| Aufgaben und Ideen      | Repo-Seite → **Issues**                                            |

## Wenn etwas hakt

| Problem                                         | Lösung                                                                                 |
| ----------------------------------------------- | -------------------------------------------------------------------------------------- |
| Skript meldet „is not public“                   | *Settings → General → Danger Zone → Change visibility → Public*, dann Skript erneut starten |
| `setup-github.sh` meldet fehlende Rechte        | Schritt 3c wiederholen (`unset GITHUB_TOKEN`, dann `gh auth login`)                     |
| „A stack is already set up“                     | Die Sprache ist schon gewählt; nichts zu tun                                            |
| `git push` wird abgelehnt („protected branch“)  | Schritt 3b kam zu spät. Claude bitten: „Bitte meine Änderungen als Pull Request einreichen.“ |
| Release-PR lässt sich nicht mergen              | Haken bei „bypass rules“ setzen (siehe Schritt 4 im Alltag)                             |
| Eine Prüfung im Pull Request ist rot            | Claude bitten: „Die Prüfung im PR ist rot, bitte beheben.“                              |
| Alte Version zurückholen                        | *Actions → Deploy production → Run workflow*, ältere Version eintragen (z. B. `v1.2.0`) |

## Begriffe kurz erklärt

| Begriff          | Bedeutung                                                                          |
| ---------------- | ---------------------------------------------------------------------------------- |
| **Repository**   | Projektordner auf GitHub mit kompletter Änderungshistorie                          |
| **Branch**       | Arbeitskopie für eine Änderung, ohne den Hauptstand zu stören                      |
| **Pull Request** | Vorschlag, eine Änderung zu übernehmen, inklusive Prüfung und Vorschau             |
| **Merge**        | Änderung in den Hauptstand (`main`) übernehmen                                     |
| **CI**           | automatische Prüfungen bei jeder Änderung                                          |
| **Release**      | neue, nummerierte Version (z. B. `v1.2.0`), die live geht                          |
| **Stack**        | gewählte Programmiersprache mit ihren Werkzeugen                                   |
| **Token**        | Abrechnungseinheit der KI; weniger Text bedeutet weniger Kosten                    |

Mehr Details: [README](README.md) · [Sprachen wählen](docs/stacks.md) · [Vorschau → Live](docs/environments.md) · [KI-Assistenten](docs/ai-tools.md)
