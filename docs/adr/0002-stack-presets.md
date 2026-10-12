# 0002. Sprach-Vorlagen mit einheitlichen Befehlen

- Status: Accepted
- Datum: 2026-10-12

## Kontext

Beim Start eines Projekts ist oft unklar, welche Programmiersprache am besten passt. Jede Sprache bringt
eigene Werkzeuge und Befehle mit; das kostet Einarbeitung und erschwert den Wechsel.

## Entscheidung

Das Template enthält Vorlagen (`stacks/`) für Web, TypeScript, Python, Go, Rust und Java. Jede Vorlage bietet
dieselben `make`-Befehle (`setup`, `dev`, `lint`, `test`, `build`, `ci`). `scripts/init-stack.sh`
übernimmt eine Vorlage ins Projekt.

## Konsequenzen

Gleiche Abläufe in allen Projekten, unabhängig von der Sprache. Die Vorlagen müssen gelegentlich
aktualisiert werden; Dependabot übernimmt das in den abgeleiteten Projekten.
