#!/usr/bin/env bash
# PreToolUse hook: nudges Claude to query the graphify knowledge graph before
# grepping/reading raw files. Portable wrapper around `graphify hook-guard`:
# a no-op when graphify is not installed or no graph has been built yet.
set -u
mode="${1:-search}"

if ! command -v graphify >/dev/null 2>&1; then
  cat >/dev/null
  exit 0
fi

graphify hook-guard "$mode" || exit 0
