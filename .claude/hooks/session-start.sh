#!/usr/bin/env bash
# SessionStart hook: makes sure the graphify CLI is available so /graphify,
# `graphify query` and the PreToolUse guard work out of the box.
# Never fails the session; prints a hint instead.
set -u

if command -v graphify >/dev/null 2>&1; then
  exit 0
fi

# Only auto-install in Claude Code cloud sessions. Locally, ask the developer
# to install it once (see README) instead of touching their environment.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  echo "graphify CLI not found. Install once with: uv tool install graphifyy  (or: pipx install graphifyy)"
  exit 0
fi

if command -v uv >/dev/null 2>&1; then
  uv tool install --quiet graphifyy >/dev/null 2>&1 || true
elif command -v pipx >/dev/null 2>&1; then
  pipx install graphifyy >/dev/null 2>&1 || true
else
  python3 -m pip install --quiet --user graphifyy >/dev/null 2>&1 \
    || python3 -m pip install --quiet --user --break-system-packages graphifyy >/dev/null 2>&1 \
    || true
fi

if command -v graphify >/dev/null 2>&1; then
  echo "graphify installed: $(graphify --version 2>/dev/null)"
else
  echo "graphify could not be installed automatically; run: pip install graphifyy"
fi
exit 0
