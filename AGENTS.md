# AGENTS.md

Gemeinsame Anweisungen für **alle** KI-Coding-Agenten: Claude Code, OpenAI Codex (ChatGPT),
Cursor, Copilot, Gemini u. a. `CLAUDE.md` bindet diese Datei ein. Hier pflegen, nicht doppelt.

## Projekt

<!-- TODO (in abgeleiteten Projekten): In 2–3 Sätzen: Was macht das Projekt, für wen, welcher Stack? -->

Dies ist das **persönliche Projekt-Template von tomonfire**, die Vorlage für alle seine
Entwicklungsprojekte. Änderungen hier wirken auf alle künftigen Projekte: Sie sollen allgemein
gültig, stack-neutral und gut begründet sein (größere Entscheidungen als ADR in `docs/adr/`).

## Befehle

Stack: _noch nicht gewählt_ (`./scripts/init-stack.sh list`)

Jeder Stack hat dieselben Befehle, egal welche Programmiersprache:

| Zweck                          | Befehl                       |
| ------------------------------ | ---------------------------- |
| Alle Befehle anzeigen          | `make help`                  |
| Abhängigkeiten installieren    | `make setup`                 |
| Lokal starten (Port 8080)      | `make dev`                   |
| Prüfen (Lint, Format, Typen)   | `make lint`                  |
| Tests                          | `make test`                  |
| Bauen                          | `make build`                 |
| Alles wie in der CI            | `make ci`                    |
| Container bauen / starten      | `make docker-build` / `make docker-run` |
| Repo-weite Checks              | `pre-commit run --all-files` |

## Konventionen

- Commits nach [Conventional Commits](https://www.conventionalcommits.org/) (`feat:`, `fix:`, `docs:`, `chore:` …).
- Kleine, fokussierte Änderungen; jede PR soll einen klaren Zweck haben.
- Vor jedem Commit: `pre-commit run --all-files` muss grün sein.
- Keine Secrets ins Repo. Konfiguration über `.env` (Vorlage: `.env.example`).
- `CHANGELOG.md`, Versionen und Tags (`vX.Y.Z`) erzeugt release-please aus den Commits – nicht von Hand ändern.
- Nie direkt auf `main` committen: Branch + PR (Squash-Merge, PR-Titel = Commit-Message).
- Code, Bezeichner und Commit-Messages auf Englisch; Doku darf Deutsch sein.

## Arbeitsweise & Token-Sparen

- **Erst klären, dann bauen:** Neue Features beginnen mit einer Spezifikation in `docs/requirements/`
  (Claude Code: Agent `anforderungen` bzw. `/team`). Gebaut wird nur, was in den Akzeptanzkriterien steht.
- **Gezielt lesen:** zuerst `graphify query`, dann einzelne Dateien – kein flächiges Lesen/Greppen.
- **Knapp antworten:** Ergebnisse in wenigen Zeilen; Pfade nennen statt Inhalte wiederholen.
- **Einfach halten:** keine spekulativen Erweiterungen, keine neuen Abhängigkeiten ohne Grund.

## Stufen

Pull Request → **Vorschau**, `main` → **Staging**, Release → **Produktion** (mit Freigabe).
Hosting kostenlos auf GitHub (Pages + Container Registry), Details: `docs/environments.md`.
Repos aus diesem Template sind **öffentlich** (Voraussetzung für die kostenlosen GitHub-Funktionen).

## Struktur

```text
.claude/          Claude-Code-Konfiguration (Settings, Hooks, Skills inkl. /graphify)
.agents/skills/   Skills für Codex & andere Agenten (Symlink auf .claude/skills/graphify)
.codex/           Codex-Projektkonfiguration (graphify-MCP-Server)
.github/          CI-Workflows, Issue-/PR-Templates, Dependabot, CODEOWNERS
docs/             Doku: ADRs, Anforderungen, Stacks, Stufen, KI-Tools
stacks/           Sprach-Vorlagen (nur im Template; init-stack.sh übernimmt eine davon)
scripts/          Hilfsskripte (z. B. bootstrap.sh)
graphify-out/     Knowledge Graph des Codes (wird von graphify erzeugt)
```

## graphify (Knowledge Graph)

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

When the user types `/graphify`, use the graphify skill (`.claude/skills/graphify/`, also linked as `.agents/skills/graphify/`) before doing anything else.

Rules:

- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- Dirty graphify-out/ files are expected after hooks or incremental updates; they are not a reason to skip graphify.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).
- A committed graphify-out/graph.json is rewritten whole on every build, so a large diff to it in a pull request is expected. Do not flag it as churn or suggest skipping the graph rebuild or its hooks.
- If graphify-out/graph.json does not exist yet, build it with `/graphify .` once there is code to index.
