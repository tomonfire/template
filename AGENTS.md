# AGENTS.md

Gemeinsame Anweisungen für **alle** KI-Coding-Agenten: Claude Code, OpenAI Codex (ChatGPT),
Cursor, Copilot, Gemini u. a. `CLAUDE.md` bindet diese Datei ein. Hier pflegen, nicht doppelt.

## Projekt

<!-- TODO (in abgeleiteten Projekten): In 2–3 Sätzen: Was macht das Projekt, für wen, welcher Stack? -->

Dies ist das **persönliche Projekt-Template von tomonfire**, die Vorlage für alle seine
Entwicklungsprojekte. Änderungen hier wirken auf alle künftigen Projekte: Sie sollen allgemein
gültig, stack-neutral und gut begründet sein (größere Entscheidungen als ADR in `docs/adr/`).

## Befehle

<!-- TODO: an den Stack anpassen -->

| Zweck           | Befehl                          |
| --------------- | ------------------------------- |
| Setup           | `./scripts/bootstrap.sh`        |
| Lint / Format   | `pre-commit run --all-files`    |
| Tests           | _tbd_                           |
| Build           | _tbd_                           |

## Konventionen

- Commits nach [Conventional Commits](https://www.conventionalcommits.org/) (`feat:`, `fix:`, `docs:`, `chore:` …).
- Kleine, fokussierte Änderungen; jede PR soll einen klaren Zweck haben.
- Vor jedem Commit: `pre-commit run --all-files` muss grün sein.
- Keine Secrets ins Repo. Konfiguration über `.env` (Vorlage: `.env.example`).
- `CHANGELOG.md`, Versionen und Tags (`vX.Y.Z`) erzeugt release-please aus den Commits – nicht von Hand ändern.
- Nie direkt auf `main` committen: Branch + PR (Squash-Merge, PR-Titel = Commit-Message).
- Code, Bezeichner und Commit-Messages auf Englisch; Doku darf Deutsch sein.

## Struktur

```text
.claude/          Claude-Code-Konfiguration (Settings, Hooks, Skills inkl. /graphify)
.agents/skills/   Skills für Codex & andere Agenten (Symlink auf .claude/skills/graphify)
.codex/           Codex-Projektkonfiguration (graphify-MCP-Server)
.github/          CI-Workflows, Issue-/PR-Templates, Dependabot, CODEOWNERS
docs/             Projektdokumentation, ADRs, docs/ai-tools.md (Claude, ChatGPT, Perplexity)
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
