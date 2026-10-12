#!/usr/bin/env bash
# Picks the programming language ("stack") for a new project and sets up
# everything for it: starter code, tests, Dockerfile, CI workflow, .gitignore,
# Dependabot and the required "Test" check.
#
#   ./scripts/init-stack.sh list            # show available stacks
#   ./scripts/init-stack.sh python          # set up the project with Python
#   ./scripts/init-stack.sh go --keep       # keep the stacks/ folder afterwards
#
# Every stack offers the same commands: make setup | dev | lint | test | build | run | ci
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

STACKS_DIR=stacks
list() {
  echo "Available stacks (details: docs/stacks.md):"
  for d in "$STACKS_DIR"/*/; do
    name="$(basename "$d")"
    # shellcheck disable=SC1091
    ( . "$d/stack.env"; printf '  %-11s %-24s %s\n' "$name" "$TITLE" "$SUMMARY" )
  done
}

STACK="${1:-}"
KEEP=false
[ "${2:-}" = "--keep" ] && KEEP=true

if [ -z "$STACK" ] || [ "$STACK" = "list" ] || [ "$STACK" = "-h" ] || [ "$STACK" = "--help" ]; then
  list; exit 0
fi
[ -d "$STACKS_DIR/$STACK" ] || { echo "Unknown stack: $STACK" >&2; list >&2; exit 1; }
if [ -f Makefile ]; then
  echo "A stack is already set up (Makefile exists). Nothing changed." >&2
  exit 1
fi

# shellcheck disable=SC1090
. "$STACKS_DIR/$STACK/stack.env"
echo "==> Setting up: $TITLE"

# 1. Starter code, Makefile, Dockerfile (including dotfiles)
cp -R "$STACKS_DIR/$STACK/files/." .

# 2. CI workflow "Test"
cp "$STACKS_DIR/$STACK/test.yml" .github/workflows/test.yml

# 3. .gitignore additions
printf '\n# --- Stack: %s ---\n%s\n' "$TITLE" "$GITIGNORE" >> .gitignore

# 4. Dependabot keeps the libraries of this stack up to date
cat >> .github/dependabot.yml <<YAML

  - package-ecosystem: $DEPENDABOT
    directory: /
    schedule:
      interval: weekly
    labels: ["type: dependencies"]
    commit-message:
      prefix: "chore(deps)"
    groups:
      dependencies:
        patterns: ["*"]
YAML

# 5. Make the "Test" check required before merging into main
python3 - <<'PY'
import json, pathlib
p = pathlib.Path(".github/rulesets/main.json")
data = json.loads(p.read_text())
for rule in data["rules"]:
    if rule["type"] == "required_status_checks":
        checks = rule["parameters"]["required_status_checks"]
        if not any(c["context"] == "Test" for c in checks):
            checks.append({"context": "Test"})
p.write_text(json.dumps(data, indent=2) + "\n")
PY

# 6. Record the choice for humans and AI agents
sed -i.bak "s|^Stack: .*|Stack: **$TITLE** (gewählt mit \`./scripts/init-stack.sh $STACK\`)|" AGENTS.md && rm -f AGENTS.md.bak

# 7. Remove the other presets (they are still in the template repo)
if [ "$KEEP" = false ]; then
  rm -rf "$STACKS_DIR"
fi

cat <<MSG

Done. Next steps:
  make help      # all commands
  make setup     # install dependencies
  make dev       # start locally → http://localhost:8080
  make ci        # what CI checks before a merge

Commit the result:  git add -A && git commit -m "feat: set up $STACK stack"
Afterwards run ./scripts/setup-github.sh again so the "Test" check becomes required on GitHub.
MSG
