# Mitwirken

Kurzregeln für alle, die an diesem Projekt arbeiten, egal ob Mensch oder KI-Agent.
Einstieg: [QUICKSTART](../QUICKSTART.md) · Regeln für KI-Agenten: [AGENTS.md](../AGENTS.md)

## Ablauf

1. Größere Änderungen zuerst als Issue beschreiben (oder mit `/team` eine Anforderung erstellen lassen).
2. Branch von `main` anlegen, z. B. `feat/login`, `fix/leere-eingabe`, `docs/anleitung`.
3. Commits und PR-Titel nach [Conventional Commits](https://www.conventionalcommits.org/):
   `feat: …` (neue Funktion), `fix: …` (Fehler), `docs: …`, `chore: …`.
4. Vor dem Push `make ci` (falls ein Stack gewählt ist) und `pre-commit run --all-files` ausführen.
5. Pull Request öffnen, die Vorschau ansehen und nach grünen Prüfungen per **Squash & Merge** übernehmen.

## Versionen

Versionen, Tags (`vX.Y.Z`) und `CHANGELOG.md` entstehen automatisch aus den Commit-Titeln:
`fix` → 0.0.**1**, `feat` → 0.**1**.0, `feat!` (Breaking Change) → **1**.0.0.
Der Ablauf bis zur Produktion steht in [docs/environments.md](../docs/environments.md).

## Grundsätze

- Formatierung erzwingen die Werkzeuge (`.editorconfig`, pre-commit), darüber wird nicht diskutiert.
- Neue Funktionen bringen Tests mit.
- Wichtige Entscheidungen kurz als ADR in [docs/adr/](../docs/adr/) festhalten.
- Es gilt der [Verhaltenskodex](CODE_OF_CONDUCT.md).
