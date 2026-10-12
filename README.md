# template

> Vorlage für neue Repositories und Projekte – mit CI, Code-Qualität, Community-Dateien und
> einer fertigen [Claude Code](https://claude.com/claude-code)-Konfiguration inklusive
> [`/graphify`](https://github.com/Graphify-Labs/graphify).

<!-- Nach dem Erstellen eines neuen Projekts: Titel, Beschreibung und Badges anpassen. -->
[![CI](https://github.com/tomonfire/template/actions/workflows/ci.yml/badge.svg)](https://github.com/tomonfire/template/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Inhalt

| Bereich              | Dateien                                                                    |
| -------------------- | -------------------------------------------------------------------------- |
| KI-Agenten           | `CLAUDE.md`, `AGENTS.md`, `.claude/` (Settings, Hooks, Skill `/graphify`)  |
| Code-Qualität        | `.pre-commit-config.yaml`, `.editorconfig`, `.markdownlint.yaml`           |
| CI / Automatisierung | `.github/workflows/` (CI, PR-Titel, Labeler, Label-Sync, Releases), Dependabot |
| Releases & Tags      | release-please → SemVer-Tags `vX.Y.Z`, GitHub Releases, `CHANGELOG.md`     |
| GitHub-Einstellungen | `.github/rulesets/`, `.github/labels.yml`, `scripts/setup-github.sh`       |
| Zusammenarbeit       | Issue-Forms, PR-Template, `CODEOWNERS`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SUPPORT.md` |
| Sicherheit           | `SECURITY.md`, gitleaks, SHA-gepinnte Actions, Secret Scanning, `.env.example` |
| Doku                 | `docs/adr/` (Architecture Decision Records)                                |
| Git                  | `.gitignore`, `.gitattributes`                                             |

## Neues Projekt aus dieser Vorlage

1. Auf GitHub **Use this template → Create a new repository** wählen
   (einmalig: *Settings → General → Template repository* in diesem Repo aktivieren).
2. Klonen und einrichten:

   ```bash
   git clone git@github.com:<owner>/<neues-repo>.git
   cd <neues-repo>
   ./scripts/bootstrap.sh
   ./scripts/setup-github.sh          # GitHub-Einstellungen, Rulesets, Labels (benötigt gh + Admin-Rechte)
   ```

3. Die Checkliste abarbeiten:
   - [ ] `README.md`: Titel, Beschreibung, Badges (`tomonfire/template` ersetzen)
   - [ ] `CLAUDE.md`: Abschnitte *Projekt* und *Befehle* ausfüllen
   - [ ] `LICENSE`: Lizenz und Rechteinhaber prüfen
   - [ ] `.github/CODEOWNERS`: Verantwortliche eintragen
   - [ ] `SECURITY.md`: Kontaktweg prüfen
   - [ ] `.gitignore`, `.pre-commit-config.yaml`, `ci.yml`: um sprachspezifische Regeln/Jobs ergänzen
   - [ ] `CHANGELOG.md`: zurücksetzen
   - [ ] `TOPICS="…" ./scripts/setup-github.sh` ausgeführt; Beschreibung und Website im Repo-„About“ gesetzt
   - [ ] Bei mehreren Maintainern: in `.github/rulesets/main.json` `required_approving_review_count` ≥ 1 und `require_code_owner_review` aktivieren
   - [ ] Sobald Code existiert: in Claude Code `/graphify .` ausführen und `graphify-out/` committen

## Voraussetzungen

- [Git](https://git-scm.com/)
- [pre-commit](https://pre-commit.com/) – `pipx install pre-commit` oder `uv tool install pre-commit`
- [graphify](https://github.com/Graphify-Labs/graphify) – `uv tool install graphifyy` oder `pipx install graphifyy`
  (in Claude-Code-Cloud-Sessions wird es automatisch per SessionStart-Hook installiert)

## GitHub-Standards

`./scripts/setup-github.sh` wendet die Einstellungen idempotent per `gh api` an
(für dieses Template-Repo: `TEMPLATE=true ./scripts/setup-github.sh`):

| Bereich        | Einstellung                                                                                     |
| -------------- | ----------------------------------------------------------------------------------------------- |
| Merge          | nur Squash-Merge, PR-Titel als Commit-Titel, Auto-Merge, Branch nach Merge löschen              |
| `main`         | Ruleset: nur per PR, lineare Historie, kein Force-Push/Löschen, Checks `Lint` + `Conventional PR title`, offene Review-Threads blockieren |
| Tags `v*`      | Ruleset: Release-Tags dürfen nicht verschoben oder gelöscht werden                              |
| Sicherheit     | Secret Scanning + Push Protection, Dependabot Alerts & Security Updates, Private Vulnerability Reporting |
| Actions        | `GITHUB_TOKEN` standardmäßig read-only; Workflows mit minimalen `permissions`; Actions auf SHAs gepinnt |
| Features       | Issues + Discussions an, Wiki + Projects aus                                                    |
| Labels         | `type:` / `priority:` / `status:` / `area:` aus `.github/labels.yml`                            |

**Versionierung:** [Conventional Commits](https://www.conventionalcommits.org/) → release-please erstellt
Release-PRs; beim Merge entstehen Tag `vX.Y.Z`, GitHub Release und Changelog
(Details in [CONTRIBUTING.md](CONTRIBUTING.md#releases--changelog)).

## Claude Code & graphify

Die Claude-Code-Konfiguration liegt projektlokal in `.claude/` und funktioniert daher in jedem Klon,
ohne dass auf dem Rechner etwas global installiert sein muss (außer der graphify-CLI):

- **`/graphify`** – Skill in `.claude/skills/graphify/`. Baut aus Code, Doku, PDFs und Bildern einen
  Knowledge Graph in `graphify-out/` (`graph.json`, `GRAPH_REPORT.md`, `graph.html`).
- **PreToolUse-Hooks** – erinnern Claude daran, zuerst `graphify query` zu nutzen statt Dateien zu
  greppen. Sie tun nichts, solange graphify fehlt oder noch kein Graph existiert.
- **SessionStart-Hook** – installiert die graphify-CLI in Cloud-Sessions automatisch.
- **Permissions** – häufige, harmlose Befehle sind freigegeben; `.env`-Dateien und Schlüssel sind für
  Claude gesperrt.

Typischer Ablauf:

```bash
/graphify .                       # einmalig: Graph bauen (in Claude Code)
graphify query "Wie läuft der Login ab?"
graphify update .                 # nach Codeänderungen (nur AST, ohne LLM-Kosten)
graphify hook install             # optional: Graph nach jedem Commit automatisch aktualisieren
```

Den Skill aktualisieren: `graphify install --platform claude` ausführen und den Inhalt von
`~/.claude/skills/graphify/` nach `.claude/skills/graphify/` kopieren.

## Mitwirken

Siehe [CONTRIBUTING.md](CONTRIBUTING.md). Sicherheitslücken bitte gemäß [SECURITY.md](SECURITY.md) melden.

## Lizenz

[MIT](LICENSE)
