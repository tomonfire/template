<p align="center">
  <img src="docs/assets/banner.svg" alt="Project Template: My starting point for every project" width="100%">
</p>

<h1 align="center">Project Template</h1>

<p align="center">
  <strong>Mein persönliches Template, von mir für mich: der Startpunkt für alle meine Entwicklungsprojekte.</strong><br>
  Jedes neue Projekt startet damit fertig eingerichtet: Qualitätsprüfungen, Vorschau vor der Veröffentlichung,
  automatische Versionen und ein KI-Team aus Claude, ChatGPT/Codex und Perplexity. Alles kostenlos auf GitHub.
</p>

<p align="center">
  <a href="https://github.com/tomonfire/template/actions/workflows/ci.yml"><img src="https://github.com/tomonfire/template/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
  <a href="https://github.com/tomonfire/template/releases"><img src="https://img.shields.io/github/v/release/tomonfire/template?sort=semver" alt="Release"></a>
  <a href="https://www.conventionalcommits.org"><img src="https://img.shields.io/badge/Conventional%20Commits-1.0.0-fe5196" alt="Conventional Commits"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="License: MIT"></a>
</p>

---

> 🚀 **Neues Projekt starten? → [QUICKSTART.md](QUICKSTART.md)** (Schritt für Schritt, ca. 10 Minuten)

## Worum es geht

Dieses Repository ist **meine eigene Vorlage**. Jedes Projekt, das ich starte (Webseite, App, Tool oder Experiment),
entsteht daraus und beginnt mit denselben bewährten Standards und Abläufen.

- **Einheitlich:** gleiche Struktur, gleiche Befehle, gleiche Regeln in allen Projekten
- **Sicher veröffentlichen:** jede Änderung erst als Vorschau, dann Staging, dann live
- **KI-gestützt, aber sparsam:** ein KI-Team klärt zuerst die Anforderungen und baut dann nur das Nötige
- **Kostenlos:** nur GitHub und Open-Source-Werkzeuge; einzig die KI-Abos kosten

> Bewährt sich in einem Projekt etwas Neues, wandert es zurück in dieses Template.

## Was steckt drin

| Bereich                     | Was es für dich tut                                                                   |
| --------------------------- | ------------------------------------------------------------------------------------- |
| 🧩 **Programmiersprachen**  | 6 Vorlagen (Web, TypeScript, Python, Go, Rust, Java) mit denselben Befehlen · [Wahlhilfe](docs/stacks.md) |
| 🔍 **Vorschau → Live**      | Jede Änderung erst als Vorschau, dann Staging, dann Produktion mit Freigabe · [Ablauf](docs/environments.md) |
| 👥 **KI-Team**              | Business Owner, Senior Developer, UI/UX-Experte, QA-Reviewer als Claude-Agents (`/team`) |
| 🤖 **KI-Assistenten**       | Claude, ChatGPT/Codex und Perplexity mit denselben Regeln (`AGENTS.md`) · [Anleitung](docs/ai-tools.md) |
| 🧠 **Projekt-Landkarte**    | [graphify](https://github.com/Graphify-Labs/graphify): Die KI findet sich schneller zurecht und verbraucht weniger Tokens |
| ✅ **Qualität & Sicherheit** | Automatische Prüfungen, Passwort-Scanner, Schutzregeln, Sicherheitsupdates           |
| 🏷️ **Versionen**            | Versionsnummern, Release-Notizen und Changelog entstehen automatisch                  |

## Wie eine Änderung live geht

```text
Pull Request ──► VORSCHAU  …github.io/<repo>/pr-12/     Link kommt automatisch in den PR
     │ Merge
main ─────────► STAGING   …github.io/<repo>/staging/
     │ Release-PR mergen + Freigabe
Version ──────► LIVE      …github.io/<repo>/
```

## Das KI-Team

`/team <Wunsch>` in Claude Code: Der **Business Owner** (Claude Opus) schreibt zuerst klare Anforderungen.
Dann setzen **Senior Developer** und **UI/UX-Experte** um, und der **QA-Reviewer** prüft (alle Claude Sonnet).
Das teure Modell denkt nur dort mit, wo es am meisten bringt. So bleiben die Token-Kosten niedrig.

## Weiterlesen

| Dokument | Inhalt |
| --- | --- |
| [QUICKSTART.md](QUICKSTART.md) | Neues Projekt anlegen, Alltag, Hilfe bei Problemen, Begriffe |
| [AGENTS.md](AGENTS.md) | Regeln für KI-Assistenten und Befehle |
| [docs/](docs/) | Sprachen, Stufen, KI-Tools, Entscheidungen (ADRs) |
| [.github/CONTRIBUTING.md](.github/CONTRIBUTING.md) | Wie Änderungen ins Projekt kommen |

[MIT](LICENSE) © tomonfire · Sicherheitslücken bitte vertraulich melden: [SECURITY.md](.github/SECURITY.md)
