#!/usr/bin/env bash
# Starts the graphify MCP server for AI assistants (Claude Code, Codex, ...).
# Uses the installed `graphify-mcp`; falls back to `uvx` so it also works
# before graphify is installed (e.g. right at the start of a cloud session).
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
graph="graphify-out/graph.json"

if command -v graphify-mcp >/dev/null 2>&1; then
  exec graphify-mcp "$graph"
elif command -v uvx >/dev/null 2>&1; then
  exec uvx --quiet --from "graphifyy[mcp]" graphify-mcp "$graph"
else
  echo 'graphify-mcp not found. Install it with: uv tool install "graphifyy[mcp]"' >&2
  exit 1
fi
