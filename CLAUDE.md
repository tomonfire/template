# CLAUDE.md

Leitfaden für Claude Code (und andere KI-Agenten) in diesem Repository.
Halte diese Datei kurz und aktuell: Sie wird in jede Session geladen.

## Projekt

<!-- TODO: In 2–3 Sätzen: Was macht das Projekt, für wen, welcher Stack? -->

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
.github/          CI-Workflows, Issue-/PR-Templates, Dependabot, CODEOWNERS
docs/             Projektdokumentation und Architekturentscheidungen (ADRs)
scripts/          Hilfsskripte (z. B. bootstrap.sh)
graphify-out/     Knowledge Graph des Codes (wird von graphify erzeugt)
```

## graphify

This project has a knowledge graph at graphify-out/ with god nodes, community structure, and cross-file relationships.

Rules:

- For codebase questions, first run `graphify query "<question>"` when graphify-out/graph.json exists. Use `graphify path "<A>" "<B>"` for relationships and `graphify explain "<concept>"` for focused concepts. These return a scoped subgraph, usually much smaller than GRAPH_REPORT.md or raw grep output.
- If graphify-out/wiki/index.md exists, use it for broad navigation instead of raw source browsing.
- Read graphify-out/GRAPH_REPORT.md only for broad architecture review or when query/path/explain do not surface enough context.
- After modifying code, run `graphify update .` to keep the graph current (AST-only, no API cost).
- A committed graphify-out/graph.json is rewritten whole on every build, so a large diff to it in a pull request is expected. Do not flag it as churn or suggest skipping the graph rebuild or its hooks.
- If graphify-out/graph.json does not exist yet, build it with `/graphify .` once there is code to index.
