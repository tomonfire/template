<!-- Neues Projekt? Titel, Beschreibung, Banner und Badges anpassen (tomonfire/template ersetzen). -->
<p align="center">
  <img src="docs/assets/banner.svg" alt="Project Template: My starting point for every project" width="100%">
</p>

<h1 align="center">Project Template</h1>

<p align="center">
  <strong>Mein persönliches Template, von mir für mich: der Startpunkt für alle meine Entwicklungsprojekte.</strong><br>
  Jedes neue Repository ist damit vom ersten Commit an produktionsreif:
  CI, automatische SemVer-Releases, Rulesets, Security-Defaults und eine fertige Einrichtung
  für KI-Assistenten (Claude, ChatGPT/Codex, Perplexity) samt Knowledge Graph über <code>/graphify</code>.
</p>

<p align="center">
  <a href="https://github.com/tomonfire/template/actions/workflows/ci.yml"><img src="https://github.com/tomonfire/template/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
  <a href="https://github.com/tomonfire/template/releases"><img src="https://img.shields.io/github/v/release/tomonfire/template?sort=semver" alt="Release"></a>
  <a href="https://www.conventionalcommits.org"><img src="https://img.shields.io/badge/Conventional%20Commits-1.0.0-fe5196" alt="Conventional Commits"></a>
  <a href="https://pre-commit.com"><img src="https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit" alt="pre-commit"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License: MIT"></a>
</p>

<p align="center">
  <a href="#schnellstart">Schnellstart</a> ·
  <a href="#was-steckt-drin">Was steckt drin</a> ·
  <a href="#ki-assistenten">KI-Assistenten</a> ·
  <a href="#github-standards">GitHub-Standards</a> ·
  <a href="CONTRIBUTING.md">Mitwirken</a>
</p>

---

## Worum es geht

Dieses Repository ist **meine eigene Vorlage**. Jedes Entwicklungsprojekt, das ich starte, egal ob
App, Library, Tool oder Experiment, entsteht daraus. So beginnt jedes Projekt mit denselben bewährten
Standards, denselben Abläufen und derselben KI-Einrichtung, und ich muss nichts davon jedes Mal neu
zusammensuchen.

- **Einheitlich:** gleiche Struktur, gleiche Befehle und gleiche Regeln in allen meinen Repos
- **Sofort startklar:** CI, Releases, Sicherheit und KI-Assistenten laufen ab dem ersten Commit
- **Mitwachsend:** Verbesserungen fließen zuerst hierher und kommen so allen künftigen Projekten zugute

> Bewährt sich in einem Projekt etwas Neues, wandert es zurück in dieses Template.

## Schnellstart

1. **Repository anlegen:** oben auf **Use this template → Create a new repository** klicken.
2. **Lokal einrichten:**

   ```bash
   git clone git@github.com:<owner>/<repo>.git && cd <repo>
   ./scripts/bootstrap.sh       # pre-commit, graphify, Git-Hooks, .env
   ./scripts/setup-github.sh    # GitHub-Einstellungen, Rulesets, Labels, Topics (gh + Admin-Rechte)
   ```

3. **Anpassen:** die [Checkliste](#checkliste-für-neue-projekte) abarbeiten.
4. **Knowledge Graph bauen**, sobald Code existiert: `/graphify .` in Claude Code oder Codex ausführen
   und `graphify-out/` committen.

## Was steckt drin

| Bereich                  | Inhalt                                                                                                      |
| ------------------------ | ----------------------------------------------------------------------------------------------------------- |
| 🤖 **KI-Assistenten**     | `AGENTS.md` (gemeinsame Regeln), `CLAUDE.md`, Skill `/graphify`, Hooks, MCP für Claude, Codex & Perplexity  |
| 🧠 **Knowledge Graph**    | [graphify](https://github.com/Graphify-Labs/graphify): Architektur, Abhängigkeiten, Abfragen statt grep     |
| ✅ **Code-Qualität**      | pre-commit: gitleaks, actionlint, shellcheck, markdownlint, EditorConfig, Schemas, Conventional Commits     |
| ⚙️ **CI/CD**              | Lint-CI, PR-Titel-Check, Auto-Labeler, Label-Sync, Dependabot; Actions SHA-gepinnt, minimale Rechte         |
| 🏷️ **Releases**           | release-please: SemVer-Tags `vX.Y.Z`, GitHub Releases, `CHANGELOG.md` automatisch                           |
| 🛡️ **Sicherheit**         | Rulesets für `main` & Tags, Secret Scanning + Push Protection, `SECURITY.md`, private Meldungen             |
| 🤝 **Zusammenarbeit**     | Issue-Forms, PR-Template, `CODEOWNERS`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SUPPORT.md`               |
| 📚 **Doku**               | Architecture Decision Records in `docs/adr/`, Anleitung für KI-Tools in `docs/ai-tools.md`                  |

<details>
<summary><strong>Verzeichnisstruktur</strong></summary>

```text
.
├── .agents/skills/        Skills für Codex & andere Agenten (→ .claude/skills)
├── .claude/               Claude Code: settings.json, hooks/, skills/graphify/
├── .codex/config.toml     Codex: graphify-MCP-Server
├── .github/
│   ├── ISSUE_TEMPLATE/    Bug, Feature, Aufgabe (Issue-Forms)
│   ├── rulesets/          Branch- & Tag-Schutz als Code
│   ├── workflows/         CI, PR-Titel, Labeler, Labels, Release
│   ├── about.json         Beschreibung, Website, Topics als Code
│   └── labels.yml         Label-Schema als Code
├── docs/                  ADRs, KI-Tools-Anleitung, Banner/Social Preview
├── scripts/               bootstrap, setup-github, mcp-config, export-ai-context
├── .mcp.json              MCP-Server für Claude Code
├── AGENTS.md              Regeln für alle KI-Agenten (Quelle der Wahrheit)
└── CLAUDE.md              bindet AGENTS.md ein + Claude-spezifisches
```

</details>

## KI-Assistenten

Alle Assistenten teilen sich **eine** Wissensbasis: `AGENTS.md` für Regeln und den graphify-Graphen
für die Code-Struktur. Details und Sicherheitshinweise stehen in [docs/ai-tools.md](docs/ai-tools.md).

| Assistent                        | Anbindung                                  | Einrichtung                                  |
| -------------------------------- | ------------------------------------------ | -------------------------------------------- |
| **Claude Code**                  | Skill `/graphify`, Hooks, MCP, `CLAUDE.md` | automatisch                                  |
| **Claude Desktop**               | lokaler MCP-Server                         | `./scripts/mcp-config.sh claude-desktop`     |
| **OpenAI Codex** (ChatGPT)       | `AGENTS.md`, Skill, MCP                    | automatisch (Projekt als *trusted* markieren) |
| **Perplexity für Mac**           | lokaler MCP-Server                         | `./scripts/mcp-config.sh perplexity`         |
| **ChatGPT / Claude Projects, Perplexity Spaces** | Datei-Upload              | `./scripts/export-ai-context.sh`             |

```bash
uv tool install "graphifyy[mcp]"           # CLI + MCP-Server (einmalig)
/graphify .                                 # Graph bauen (in Claude Code / Codex)
graphify query "Wie läuft der Login ab?"    # Fragen an den Graphen
graphify update .                           # nach Codeänderungen, ohne LLM-Kosten
```

> Den graphify-Skill aktualisieren: `graphify install --platform claude` ausführen und
> `~/.claude/skills/graphify/` nach `.claude/skills/graphify/` kopieren (Codex nutzt ihn per Symlink mit).

## GitHub-Standards

`./scripts/setup-github.sh` wendet alles idempotent per `gh api` an
(für dieses Template-Repo selbst: `TEMPLATE=true ./scripts/setup-github.sh`).

| Bereich          | Einstellung                                                                                          |
| ---------------- | ---------------------------------------------------------------------------------------------------- |
| **About**        | Beschreibung, Website und Topics aus `.github/about.json`                                            |
| **Merge**        | nur Squash-Merge, PR-Titel = Commit-Titel, Auto-Merge, Branch nach Merge löschen                     |
| **`main`**       | nur per PR, lineare Historie, kein Force-Push/Löschen, Pflicht-Checks `Lint` + `Conventional PR title`, offene Threads blockieren |
| **Tags `v*`**    | Release-Tags können weder verschoben noch gelöscht werden                                            |
| **Sicherheit**   | Secret Scanning + Push Protection, Dependabot Alerts & Security Updates, Private Vulnerability Reporting |
| **Actions**      | `GITHUB_TOKEN` standardmäßig read-only; Workflows mit minimalen `permissions`                        |
| **Features**     | Issues + Discussions an, Wiki + Projects aus                                                         |
| **Labels**       | `type:` · `priority:` · `status:` · `area:` aus `.github/labels.yml`                                 |

**Versionierung:** [Conventional Commits](https://www.conventionalcommits.org/) im PR-Titel →
release-please pflegt einen Release-PR → beim Merge entstehen Tag `vX.Y.Z`, GitHub Release und
Changelog. Details stehen in [CONTRIBUTING.md](CONTRIBUTING.md#releases--changelog).

## Checkliste für neue Projekte

- [ ] **README:** Titel, Beschreibung, Badges; Banner (`docs/assets/banner.svg`) anpassen oder entfernen
- [ ] **`.github/about.json`:** Beschreibung (≤ 350 Zeichen), Website, passende Topics
- [ ] **`AGENTS.md`:** Abschnitte *Projekt* und *Befehle* ausfüllen
- [ ] **`LICENSE`** und **`.github/CODEOWNERS`** prüfen
- [ ] **Stack ergänzen:** `.gitignore`, `.pre-commit-config.yaml`, Jobs in `ci.yml`, Ökosystem in `dependabot.yml`
- [ ] **`CHANGELOG.md`** und **`.release-please-manifest.json`** (`0.0.0`) zurücksetzen
- [ ] **`./scripts/setup-github.sh`** ausführen; Social Preview hochladen (*Settings → General*)
- [ ] **Team?** In `.github/rulesets/main.json` mindestens 1 Approval und Code-Owner-Review aktivieren
- [ ] **Graph:** `/graphify .` ausführen und `graphify-out/` committen

## Voraussetzungen

[Git](https://git-scm.com/) ·
[uv](https://docs.astral.sh/uv/) oder [pipx](https://pipx.pypa.io/) ·
[pre-commit](https://pre-commit.com/) ·
[graphify](https://github.com/Graphify-Labs/graphify) (`graphifyy[mcp]`) ·
für `setup-github.sh`: [gh](https://cli.github.com/) + [jq](https://jqlang.github.io/jq/)

## Mitwirken & Support

Beiträge sind willkommen. Siehe [CONTRIBUTING.md](CONTRIBUTING.md) und [SUPPORT.md](SUPPORT.md).
Sicherheitslücken bitte vertraulich gemäß [SECURITY.md](SECURITY.md) melden.

## Lizenz

[MIT](LICENSE) © tomonfire
