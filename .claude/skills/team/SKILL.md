---
name: team
description: Runs a feature through the virtual team – requirements (anforderungen) → implementation (senior-developer, ui-ux-experte) → review (qa-reviewer) – with tight token budgets. Use when the user asks to build a feature, change or fix end to end, or types /team.
---

# /team – Feature mit dem virtuellen Team umsetzen

Rollen (Subagents in `.claude/agents/`):

| Rolle                | Agent              | Modell | Aufgabe                                      |
| -------------------- | ------------------ | ------ | -------------------------------------------- |
| Business Owner       | `anforderungen`    | Opus   | Wunsch → prüfbare Spezifikation              |
| Senior Developer     | `senior-developer` | Sonnet | Logik, Backend, Tests umsetzen               |
| UI/UX-Experte        | `ui-ux-experte`    | Sonnet | Oberfläche, Texte, Barrierefreiheit          |
| QA / Code Review     | `qa-reviewer`      | Sonnet | Diff gegen Kriterien prüfen, Tests laufen    |

## Ablauf

1. **Anforderungen:** `anforderungen` mit dem Wunsch des Nutzers aufrufen. Rückfragen an den Nutzer weitergeben
   und die Antworten zurückspielen. Ergebnis: Pfad zu `docs/requirements/NNNN-*.md`.
2. **Kurz bestätigen lassen:** Dem Nutzer Ziel + Akzeptanzkriterien in max. 5 Zeilen zeigen. Erst nach OK weiter.
   (Bei kleinen, eindeutigen Aufgaben darf dieser Schritt entfallen.)
3. **Umsetzen** laut Abschnitt „Aufteilung“ der Spezifikation:
   - Logik/Backend → `senior-developer`, Oberfläche → `ui-ux-experte`.
   - Unabhängige Pakete parallel starten, abhängige nacheinander.
   - Jedem Agent nur übergeben: Spezifikationspfad + seine Paketnummern. Nie Dateiinhalte kopieren.
4. **Review:** `qa-reviewer` mit dem Spezifikationspfad aufrufen.
   - 🔴-Befunde → an den zuständigen Agent zurück (nur die Befunde übergeben). **Maximal 2 Runden**,
     danach dem Nutzer die offenen Punkte nennen statt weiter zu iterieren.
5. **Abschluss:** Dem Nutzer in max. 8 Zeilen berichten: was gebaut wurde, welche Kriterien erfüllt sind,
   was offen ist. Commit-Message nach Conventional Commits vorschlagen.

## Token-Regeln für alle Beteiligten

- Pfade übergeben statt Inhalte; jeder liest nur, was er braucht.
- Zuerst `graphify query`, dann gezielt einzelne Dateien – kein flächiges Lesen oder Greppen.
- Kurze Rückmeldungen (≤ 10 Zeilen); keine Wiederholung bereits bekannter Informationen.
- Nichts bauen, was nicht in den Akzeptanzkriterien steht.
- Einfache Aufgaben (Tippfehler, kleine Fixes) ohne Team direkt erledigen.
