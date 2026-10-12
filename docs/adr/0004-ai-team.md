# 0004. Virtuelles KI-Team mit Anforderungen vor dem Code

- Status: Accepted
- Datum: 2026-10-12

## Kontext

KI-Assistenten erzeugen ohne klare Anforderungen schnell unnötigen Code („Blindleistung“). Das kostet Tokens und Zeit.

## Entscheidung

Claude Code arbeitet mit spezialisierten Subagents: `anforderungen` (Business Owner, stärkstes Modell),
`senior-developer`, `ui-ux-experte` und `qa-reviewer` (günstigeres Modell). Der Skill `/team` steuert den
Ablauf mit festen Token-Regeln; Reviews sind auf zwei Runden begrenzt.

## Konsequenzen

Etwas mehr Aufwand vor dem Programmieren, dafür weniger Nacharbeit und geringerer Tokenverbrauch.
Andere Assistenten (Codex, Cursor …) folgen denselben Regeln über `AGENTS.md`.
