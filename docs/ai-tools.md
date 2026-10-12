# KI-Assistenten: Claude, ChatGPT & Perplexity

Das Projektwissen steckt an drei Stellen. Jeder Assistent nutzt davon, was er technisch kann:

1. **`AGENTS.md`**: Regeln, Befehle und Konventionen (Claude Code liest sie über `CLAUDE.md`).
2. **graphify-Knowledge-Graph** in `graphify-out/`: Architektur, Abhängigkeiten, Communities.
3. **MCP-Server `graphify-mcp`**: stellt den Graphen als Tools bereit (`query_graph`, `get_node`,
   `get_neighbors`, `shortest_path`, `god_nodes`, `graph_stats` …).

## Übersicht

| Assistent                       | Wie verbunden                                    | Einrichtung                                                       |
| ------------------------------- | ------------------------------------------------ | ----------------------------------------------------------------- |
| **Claude Code** (CLI/IDE/Web)   | `CLAUDE.md` + Skill `/graphify` + Hooks + MCP    | automatisch (`.claude/`, `.mcp.json`)                             |
| **Claude Desktop**              | MCP (lokal, stdio)                               | `./scripts/mcp-config.sh claude-desktop`                          |
| **Claude.ai Projects**          | Dateien hochladen                                | `./scripts/export-ai-context.sh`                                  |
| **OpenAI Codex** (CLI/IDE/App)  | `AGENTS.md` + Skill `.agents/skills/graphify` + MCP | automatisch (`.codex/config.toml`, Projekt als *trusted* markieren) |
| **ChatGPT Projects**            | Dateien hochladen                                | `./scripts/export-ai-context.sh`                                  |
| **Perplexity für Mac**          | MCP (lokal, stdio)                               | `./scripts/mcp-config.sh perplexity`                              |
| **Perplexity Spaces**           | Dateien hochladen                                | `./scripts/export-ai-context.sh`                                  |

Voraussetzung für alle MCP-Varianten:

```bash
uv tool install "graphifyy[mcp]"   # liefert die Befehle graphify und graphify-mcp
```

Ein Graph muss existieren: einmal `/graphify .` in Claude Code oder Codex ausführen
(ohne LLM, nur Code: `graphify update .`).

## Claude

- **Claude Code:** sofort einsatzbereit. `/graphify .` baut den Graphen. Danach fragt Claude zuerst
  den Graphen ab (`graphify query …`) und kann die MCP-Tools aus `.mcp.json` nutzen
  (beim ersten Start einmal bestätigen).
- **Claude Desktop:** `./scripts/mcp-config.sh claude-desktop` ausgeben lassen, den Block in
  *Settings → Developer → Edit Config* einfügen und die App neu starten. Der Server heißt
  `graphify-<repo>`, damit mehrere Projekte nebeneinander funktionieren.
- **Claude.ai Projects:** `./scripts/export-ai-context.sh` ausführen und den Inhalt von
  `ai-context/` unter *Project knowledge* hochladen.

## ChatGPT / OpenAI

- **Codex (CLI, IDE-Erweiterung, Codex-App):** liest `AGENTS.md` sowie den Skill unter
  `.agents/skills/graphify` (ein Symlink auf den Claude-Skill, also nur eine Quelle), und lädt
  den MCP-Server aus `.codex/config.toml`, sobald das Projekt als vertrauenswürdig markiert ist.
  `/graphify .` bzw. `$graphify` funktioniert wie in Claude Code.
- **ChatGPT Projects (Web/Desktop):** `./scripts/export-ai-context.sh --zip` ausführen und die
  Dateien aus `ai-context/` dem Projekt hinzufügen. `00-START-HERE.md` erklärt dem Modell die Struktur.
- **ChatGPT Connector:** ChatGPT kann nur Online-Server anbinden, nicht lokale. Für dieses Template ist das
  bewusst nicht vorgesehen (Aufwand, Sicherheit). Nutze stattdessen Projects oder Codex.

## Perplexity

- **Perplexity für Mac:** unterstützt lokale MCP-Server über den Helper *PerplexityXPC*.
  Wähle *Settings → Connectors → Add Connector → Advanced* und füge den JSON-Block aus
  `./scripts/mcp-config.sh perplexity` ein. Danach den Connector in der Suche aktivieren.
- **Perplexity im KI-Team (optional, kostenpflichtige API):** Der Agent `anforderungen` nutzt Perplexity
  für Recherchen mit Quellen, sobald es in Claude Code verbunden ist:
  `claude mcp add perplexity --env PERPLEXITY_API_KEY=<key> -- npx -y @perplexity-ai/mcp-server`
  Ohne diese Verbindung nutzt er die eingebaute Websuche von Claude, die kostenlos im Abo enthalten ist.
- **Perplexity Spaces:** `./scripts/export-ai-context.sh` ausführen und die Dateien als
  Space-Dateien hochladen. Perplexity kombiniert sie dann mit der Websuche, z. B. für
  „Welche Bibliothek passt zu unserer Architektur?“.

## Sicherheit

- Die MCP-Server laufen lokal und nur lesend auf `graph.json`. graphify sendet keine Telemetrie.
- Exportierte Dateien (`ai-context/`) enthalten Struktur und Doku deines Codes. Lade sie nur dort hoch,
  wo das für das Projekt erlaubt ist. `ai-context/` ist gitignored.
- graphify protokolliert Abfragen lokal in `~/.cache/graphify-queries.log`
  (abschaltbar mit `GRAPHIFY_QUERY_LOG_DISABLE=1`).
