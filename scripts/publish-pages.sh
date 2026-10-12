#!/usr/bin/env bash
# Publishes a static website to GitHub Pages (branch gh-pages), one folder per stage:
#
#   production → https://<owner>.github.io/<repo>/
#   staging    → https://<owner>.github.io/<repo>/staging/
#   pr-<n>     → https://<owner>.github.io/<repo>/pr-<n>/   (preview of a pull request)
#
#   scripts/publish-pages.sh <production|staging|pr-N> <folder>   # publish
#   scripts/publish-pages.sh --remove pr-N                         # delete a preview
#
# Needs GH_TOKEN (contents: write) and GITHUB_REPOSITORY; used by the Deploy workflows.
set -euo pipefail

REMOVE=false
if [ "${1:-}" = "--remove" ]; then REMOVE=true; shift; fi
TARGET="${1:?usage: publish-pages.sh [--remove] <production|staging|pr-N> [folder]}"
SRC="${2:-site}"
REPO="${GITHUB_REPOSITORY:?GITHUB_REPOSITORY not set}"
: "${GH_TOKEN:?GH_TOKEN not set}"

case "$TARGET" in
  production|staging|pr-[0-9]*) ;;
  *) echo "invalid target: $TARGET" >&2; exit 1 ;;
esac

# Public URL of this stage (override with PAGES_URL for a custom domain)
owner="${REPO%%/*}"; name="${REPO#*/}"; owner="${owner,,}"
if [ -n "${PAGES_URL:-}" ]; then base="${PAGES_URL%/}/"
elif [ "${name,,}" = "$owner.github.io" ]; then base="https://$owner.github.io/"
else base="https://$owner.github.io/$name/"; fi
if [ "$TARGET" = production ]; then url="$base"; else url="$base$TARGET/"; fi

auth="AUTHORIZATION: basic $(printf 'x-access-token:%s' "$GH_TOKEN" | base64 | tr -d '\n')"
remote="https://github.com/$REPO.git"
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
g() { git -C "$work" -c "http.extraheader=$auth" "$@"; }

if git -c "http.extraheader=$auth" ls-remote --exit-code --heads "$remote" gh-pages >/dev/null 2>&1; then
  git -c "http.extraheader=$auth" clone -q --depth 1 --branch gh-pages "$remote" "$work"
else
  $REMOVE && { echo "No gh-pages branch – nothing to remove."; exit 0; }
  git init -q "$work"; g checkout -q --orphan gh-pages; g remote add origin "$remote"
fi

if $REMOVE; then
  rm -rf "${work:?}/$TARGET"
elif [ "$TARGET" = production ]; then
  [ -d "$SRC" ] || { echo "folder not found: $SRC" >&2; exit 1; }
  # Replace the site root but keep the staging and preview folders.
  find "$work" -mindepth 1 -maxdepth 1 ! -name .git ! -name staging ! -name 'pr-*' -exec rm -rf {} +
  cp -R "$SRC/." "$work/"
else
  [ -d "$SRC" ] || { echo "folder not found: $SRC" >&2; exit 1; }
  rm -rf "${work:?}/$TARGET"; mkdir -p "$work/$TARGET"
  cp -R "$SRC/." "$work/$TARGET/"
fi
touch "$work/.nojekyll"   # serve files as they are

g add -A
if g diff --cached --quiet; then
  echo "No changes for $TARGET."
else
  g -c user.name="github-actions[bot]" -c user.email="41898282+github-actions[bot]@users.noreply.github.com" \
    commit -q -m "deploy: $( $REMOVE && echo remove || echo publish ) $TARGET (${GITHUB_SHA:-local})"
  # Several stages may publish at once: rebase and retry.
  for attempt in 1 2 3 4 5; do
    g push -q origin gh-pages && break
    [ "$attempt" = 5 ] && { echo "push failed" >&2; exit 1; }
    sleep $((attempt * 3)); g pull -q --rebase origin gh-pages
  done
fi

if $REMOVE; then
  echo "Removed $TARGET"
else
  echo "Published $TARGET → $url"
  [ -n "${GITHUB_OUTPUT:-}" ] && echo "url=$url" >> "$GITHUB_OUTPUT"
fi
exit 0
