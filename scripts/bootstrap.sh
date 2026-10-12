#!/usr/bin/env bash
# One-time local setup after cloning (safe to re-run).
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

have() { command -v "$1" >/dev/null 2>&1; }
install_tool() {
  # install_tool <command> <package>
  if have "$1"; then return 0; fi
  if have uv; then uv tool install "$2"
  elif have pipx; then pipx install "$2"
  else echo "  -> please install $2 (uv tool install $2 / pipx install $2)"; return 1
  fi
}

echo "==> pre-commit"
if install_tool pre-commit pre-commit; then
  pre-commit install --install-hooks
fi

echo "==> graphify"
if install_tool graphify "graphifyy[mcp]"; then
  # Rebuild graph after commits/checkouts and register the graph.json merge driver.
  graphify hook install || true
fi

if [ ! -f .env ] && [ -f .env.example ]; then
  echo "==> creating .env from .env.example"
  cp .env.example .env
fi

echo
echo "Done. Next steps:"
echo "  - choose a language: ./scripts/init-stack.sh list"
echo "  - fill in AGENTS.md (section Projekt)"
echo "  - apply GitHub settings: ./scripts/setup-github.sh   (needs gh)"
echo "  - once code exists: run '/graphify .' in Claude Code and commit graphify-out/"
