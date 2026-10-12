#!/usr/bin/env bash
# Bundles the project knowledge (graphify report + wiki, README, AGENTS.md, ADRs)
# into ai-context/ for upload to chat apps without repo access:
#   - ChatGPT Projects  (Project → Add files)
#   - Claude Projects   (Project knowledge → Add content)
#   - Perplexity Spaces (Space → Files)
#
#   ./scripts/export-ai-context.sh          # writes ai-context/ (gitignored)
#   ./scripts/export-ai-context.sh --zip    # additionally ai-context.zip
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

OUT=ai-context
rm -rf "$OUT" && mkdir -p "$OUT"

if command -v graphify >/dev/null 2>&1 && [ -f graphify-out/graph.json ]; then
  graphify update . >/dev/null 2>&1 || true         # refresh code graph (AST only, no LLM)
  graphify export wiki >/dev/null 2>&1 || true      # one article per community
else
  echo "Note: no graphify graph found – exporting docs only. Run '/graphify .' first for the full context." >&2
fi

copy() { [ -e "$1" ] && mkdir -p "$OUT/$(dirname "$2")" && cp -R "$1" "$OUT/$2"; return 0; }
copy README.md                    README.md
copy AGENTS.md                    AGENTS.md
copy docs/adr                     adr
copy graphify-out/GRAPH_REPORT.md GRAPH_REPORT.md
copy graphify-out/wiki            wiki

# File tree for orientation (tracked files only)
git ls-files | grep -v -E '^(graphify-out|\.claude/skills|\.agents)/' > "$OUT/FILES.txt" || true

cat > "$OUT/00-START-HERE.md" <<MD
# Projektkontext: $(basename "$PWD")

Exportiert am $(date +%Y-%m-%d) aus Commit $(git rev-parse --short HEAD 2>/dev/null || echo "n/a").

Lies zuerst \`GRAPH_REPORT.md\` (Architektur, zentrale Knoten, Communities), dann \`wiki/index.md\`
für Details je Bereich. \`AGENTS.md\` enthält Konventionen und Befehle, \`adr/\` die
Architekturentscheidungen, \`FILES.txt\` die Dateiliste. Beantworte Fragen auf Basis dieser
Dateien und nenne die Quelle (Datei/Abschnitt).
MD

if [ "${1:-}" = "--zip" ]; then
  rm -f ai-context.zip && (cd "$OUT" && zip -qr ../ai-context.zip .)
  echo "Wrote ai-context/ and ai-context.zip"
else
  echo "Wrote ai-context/ ($(find "$OUT" -type f | wc -l | tr -d ' ') files)"
fi
