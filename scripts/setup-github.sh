#!/usr/bin/env bash
# Applies the recommended GitHub repository settings to the current repo
# (or the one given as owner/repo). Idempotent: safe to run repeatedly.
#
#   ./scripts/setup-github.sh                 # current repo
#   ./scripts/setup-github.sh owner/repo
#   TEMPLATE=true ./scripts/setup-github.sh   # also mark as template repository
#   TOPICS="cli,python" ./scripts/setup-github.sh
#
# Requires: gh (authenticated, admin rights on the repo), jq.
set -euo pipefail

command -v gh >/dev/null || { echo "gh CLI is required: https://cli.github.com" >&2; exit 1; }
command -v jq >/dev/null || { echo "jq is required" >&2; exit 1; }

REPO="${1:-$(gh repo view --json nameWithOwner -q .nameWithOwner)}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE="${TEMPLATE:-false}"
TOPICS="${TOPICS:-}"

step() { printf '\n==> %s\n' "$*"; }
try()  { "$@" >/dev/null 2>&1 || echo "    (skipped: not available for this repo/plan)"; }

step "Repository settings for $REPO"
gh api -X PATCH "repos/$REPO" --silent \
  -F is_template="$TEMPLATE" \
  -F has_issues=true \
  -F has_wiki=false \
  -F has_projects=false \
  -F has_discussions=true \
  -F allow_squash_merge=true \
  -F allow_merge_commit=false \
  -F allow_rebase_merge=false \
  -F allow_auto_merge=true \
  -F allow_update_branch=true \
  -F delete_branch_on_merge=true \
  -f squash_merge_commit_title=PR_TITLE \
  -f squash_merge_commit_message=PR_BODY \
  -F web_commit_signoff_required=false

step "Security: secret scanning + push protection"
try gh api -X PATCH "repos/$REPO" --silent --input - <<'JSON'
{"security_and_analysis":{"secret_scanning":{"status":"enabled"},"secret_scanning_push_protection":{"status":"enabled"}}}
JSON

step "Security: Dependabot alerts, security updates, private vulnerability reporting"
try gh api -X PUT "repos/$REPO/vulnerability-alerts"
try gh api -X PUT "repos/$REPO/automated-security-fixes"
try gh api -X PUT "repos/$REPO/private-vulnerability-reporting"

step "Actions: read-only GITHUB_TOKEN by default, allow PR creation (release-please)"
gh api -X PUT "repos/$REPO/actions/permissions/workflow" --silent \
  -f default_workflow_permissions=read \
  -F can_approve_pull_request_reviews=true

if [ -n "$TOPICS" ]; then
  step "Topics: $TOPICS"
  jq -n --arg t "$TOPICS" '{names: ($t | split(",") | map(gsub("^\\s+|\\s+$"; "")))}' \
    | gh api -X PUT "repos/$REPO/topics" --silent --input -
fi

step "Rulesets from .github/rulesets/"
existing="$(gh api "repos/$REPO/rulesets" --paginate)"
for file in "$ROOT"/.github/rulesets/*.json; do
  name="$(jq -r .name "$file")"
  id="$(jq -r --arg n "$name" '.[] | select(.name == $n) | .id' <<<"$existing" | head -n1)"
  if [ -n "$id" ]; then
    gh api -X PUT "repos/$REPO/rulesets/$id" --silent --input "$file"
    echo "    updated: $name"
  else
    gh api -X POST "repos/$REPO/rulesets" --silent --input "$file"
    echo "    created: $name"
  fi
done

step "Labels from .github/labels.yml"
if command -v yq >/dev/null; then
  yq -o=json '.' "$ROOT/.github/labels.yml" | jq -c '.[]' | while read -r label; do
    gh label create "$(jq -r .name <<<"$label")" --repo "$REPO" --force \
      --color "$(jq -r .color <<<"$label")" \
      --description "$(jq -r '.description // ""' <<<"$label")" >/dev/null
  done
  echo "    synced"
else
  echo "    yq not found – labels will be synced by the 'Sync labels' workflow on the next push to main"
  echo "    (or run it manually: gh workflow run labels.yml --repo $REPO)"
fi

printf '\nDone. Review the result at https://github.com/%s/settings\n' "$REPO"
