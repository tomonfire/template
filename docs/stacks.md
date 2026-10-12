# Welche Programmiersprache passt zu meinem Projekt?

Du musst das nicht vorher wissen. Das Template bringt fünf bewährte Ausgangspunkte („Stacks“) mit.
Jeder enthält ein kleines, lauffähiges Beispielprogramm (einen Mini-Webserver), Tests, ein Docker-Image
für die Veröffentlichung und eine fertige automatische Prüfung (CI).

**Wichtig:** Alle Stacks bedienst du mit denselben Befehlen (`make dev`, `make test`, `make ci` …).
Ein Wechsel der Sprache ändert also nichts an deinen Abläufen.

## Die Kurzentscheidung

| Wenn du … | dann nimm | Warum |
| --- | --- | --- |
| **unsicher bist** oder schnell etwas ausprobieren willst | **Python** | am leichtesten zu lesen, riesige Auswahl an fertigen Bausteinen, ideal mit KI-Assistenten |
| etwas mit **KI, Daten, Automatisierung oder Skripten** baust | **Python** | Standard in diesen Bereichen |
| eine **Web-App oder API** baust und später auch eine Oberfläche im Browser willst | **TypeScript** | eine Sprache für Server *und* Browser |
| einen **schnellen, schlanken Dienst** oder ein Kommandozeilen-Tool willst | **Go** | einfach, sehr schnell, kleines Ergebnis |
| **höchste Performance oder Sicherheit** brauchst (z. B. Systemsoftware) | **Rust** | sehr schnell und sicher, aber anspruchsvoller |
| in einem **Unternehmensumfeld mit Java** arbeitest | **Java** | Standard in vielen Firmen, enorm verbreitet |

> **Faustregel:** Im Zweifel **Python**. Für Web mit eigener Oberfläche nimm **TypeScript**.

## So wählst du einen Stack

```bash
./scripts/init-stack.sh list       # zeigt alle Stacks
./scripts/init-stack.sh python     # richtet das Projekt mit Python ein
make setup && make dev             # installieren und starten → http://localhost:8080
```

Das Skript erledigt Folgendes:

1. Es kopiert das Beispielprogramm mit Tests und Dockerfile ins Projekt.
2. Es aktiviert die automatische Prüfung „Test“ auf GitHub.
3. Es ergänzt `.gitignore` und Dependabot (hält die Bausteine automatisch aktuell).
4. Es trägt die Wahl in `AGENTS.md` ein, damit KI-Assistenten Bescheid wissen.
5. Es ersetzt die Template-Texte (README, Projektbeschreibung, Versionshistorie) durch leere Vorlagen für dein Projekt.
6. Es entfernt die anderen Stacks aus dem Projekt. In diesem Template bleiben sie erhalten.

## Was jeder Stack enthält

| Stack      | Werkzeuge (alle kostenlos, Open Source)                         |
| ---------- | ---------------------------------------------------------------- |
| TypeScript | Node.js 22, TypeScript, ESLint, Prettier, Vitest                 |
| Python     | uv, FastAPI, Ruff, mypy, pytest                                  |
| Go         | Go-Standardbibliothek, gofmt, go vet                             |
| Rust       | axum, tokio, rustfmt, clippy                                     |
| Java       | Java 21, Maven, JUnit 5                                          |

## Und wenn es keine Server-Anwendung wird?

- **Reine Webseite / Frontend** (z. B. React, Vue, Astro): TypeScript-Stack wählen, Beispielserver
  ersetzen und für die Veröffentlichung [Cloudflare Pages](https://pages.cloudflare.com/) nutzen
  (kostenlos, mit eigener Vorschau pro Pull Request). Details stehen in [environments.md](environments.md).
- **Kommandozeilen-Tool oder Bibliothek**: Go, Rust oder Python wählen; `Dockerfile` und das
  Deployment kannst du löschen.
- **Andere Sprache** (C#, Kotlin, PHP …): einen neuen Ordner unter `stacks/` nach demselben Muster
  anlegen (`files/`, `test.yml`, `stack.env`) mit denselben `make`-Befehlen.
