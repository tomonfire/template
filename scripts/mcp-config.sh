#!/usr/bin/env bash
# Prints ready-to-paste MCP configs for the graphify knowledge graph of THIS
# project, with absolute paths (desktop apps don't run in the project folder).
#
#   ./scripts/mcp-config.sh                 # all snippets
#   ./scripts/mcp-config.sh claude-desktop  # only one: claude-desktop | perplexity | codex
#
# Requires: uv tool install "graphifyy[mcp]"
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GRAPH="$ROOT/graphify-out/graph.json"
NAME="graphify-$(basename "$ROOT")"
BIN="$(command -v graphify-mcp || true)"
TARGET="${1:-all}"

if [ -z "$BIN" ]; then
  echo "graphify-mcp not found. Install it with: uv tool install \"graphifyy[mcp]\"" >&2
  BIN="graphify-mcp"
fi
[ -f "$GRAPH" ] || echo "Note: $GRAPH does not exist yet – build it first with '/graphify .' (Claude Code/Codex) or 'graphify update .'." >&2

show() { [ "$TARGET" = all ] || [ "$TARGET" = "$1" ]; }

if show claude-desktop; then
  case "$(uname -s)" in
    Darwin)              cfg="$HOME/Library/Application Support/Claude/claude_desktop_config.json" ;;
    MINGW*|MSYS*|CYGWIN*) cfg="%APPDATA%\\Claude\\claude_desktop_config.json" ;;
    *)                   cfg="claude_desktop_config.json (macOS: ~/Library/Application Support/Claude/, Windows: %APPDATA%\\Claude\\)" ;;
  esac
  cat <<JSON

### Claude Desktop – merge into $cfg (Settings → Developer → Edit Config), then restart
{
  "mcpServers": {
    "$NAME": {
      "command": "$BIN",
      "args": ["$GRAPH"]
    }
  }
}
JSON
fi

if show perplexity; then
  cat <<JSON

### Perplexity for Mac – Settings → Connectors → Add Connector → Advanced (needs the PerplexityXPC helper)
{
  "mcpServers": {
    "$NAME": {
      "command": "$BIN",
      "args": ["$GRAPH"]
    }
  }
}
JSON
fi

if show codex; then
  cat <<TOML

### OpenAI Codex (CLI/IDE) – already configured per project in .codex/config.toml.
### For a global setup add to ~/.codex/config.toml:
[mcp_servers.$NAME]
command = "$BIN"
args = ["$GRAPH"]
TOML
fi
