# 0001. Entscheidungen als ADR führen

- Status: Accepted
- Datum: 2026-10-12

## Kontext

Architekturentscheidungen gehen ohne Dokumentation verloren; neue Beteiligte (Menschen wie KI-Agenten)
können später nicht nachvollziehen, warum etwas so gebaut wurde.

## Entscheidung

Wir halten wesentliche Entscheidungen als Architecture Decision Records in `docs/adr/` fest.

## Konsequenzen

Geringer Mehraufwand pro Entscheidung; dafür nachvollziehbare Historie, die auch in den
graphify-Knowledge-Graph einfließt.
