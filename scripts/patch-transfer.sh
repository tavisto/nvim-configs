#!/usr/bin/env bash
# Send commits between machines as plain-text patches, the original git way.
#
# The work laptop can't use your personal keys, so there's no remote to push
# to. This is just a thin wrapper around git's emailed-patch workflow:
#
#   export -> git format-patch  (a readable RFC-2822 mbox on stdout)
#   import -> git am            (replays those commits, author/date/msg intact)
#
# The export is a normal patch file. You can paste it to yourself, or save it
# and run `git am < file` by hand; the script just adds base detection, a
# clipboard copy, and a matching import verb.
#
# format-patch ships COMMITS, not your working tree, so commit your work first
# (amend/rebase at home if you want to tidy history later). Untracked files
# only travel once they're committed.
#
# Usage:
#   scripts/patch-transfer.sh export [--base REF] [-o FILE]
#   scripts/patch-transfer.sh import [FILE]
#
# export
#   Writes the mbox for REF..HEAD to stdout (and the clipboard on macOS).
#   --base REF   Commits to ship are REF..HEAD. Default: origin/main.
#   -o FILE      Also write the patch to FILE.
#
# import
#   Applies the patch from FILE, or from stdin if no file is given
#   (paste, then press Ctrl-D). Uses `git am --3way` so it can still apply
#   when nearby context has drifted.
#
# Typical round trip:
#   work$   git commit -am 'wip'
#   work$   scripts/patch-transfer.sh export     # copy the patch, paste it to yourself
#   home$   scripts/patch-transfer.sh import      # paste the patch, Ctrl-D
set -euo pipefail

die() { echo "error: $*" >&2; exit 1; }

cd "$(git rev-parse --show-toplevel)" || die "not inside a git repository"

# Commits are shipped relative to a base both clones share (so the patch is
# just your new work, not all of history). origin/main is the usual anchor.
default_base() {
  if git rev-parse --verify --quiet origin/main >/dev/null; then
    echo origin/main
  elif git rev-parse --verify --quiet origin/HEAD >/dev/null; then
    git rev-parse --abbrev-ref origin/HEAD
  else
    git rev-list --max-parents=0 HEAD | tail -1   # root commit: ship everything
  fi
}

cmd_export() {
  local base="" out_file=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --base) base="${2:?--base needs a ref}"; shift 2 ;;
      -o) out_file="${2:?-o needs a path}"; shift 2 ;;
      -h|--help) sed -n '2,40p' "$0"; exit 0 ;;
      *) die "unknown export option: $1" ;;
    esac
  done

  [[ -z "$base" ]] && base="$(default_base)"
  git rev-parse --verify --quiet "$base^{commit}" >/dev/null \
    || die "base ref '$base' does not resolve to a commit"

  if [[ -z "$(git rev-list "$base..HEAD")" ]]; then
    die "no commits ahead of $base to send. Commit your work first (format-patch ships commits, not the working tree)."
  fi

  if [[ -n "$(git status --porcelain)" ]]; then
    echo "note: working tree has uncommitted changes; they will NOT be sent (patches carry commits only)." >&2
  fi

  local patch
  patch="$(git format-patch --stdout "$base..HEAD")"

  printf '%s\n' "$patch"
  if [[ -n "$out_file" ]]; then
    printf '%s\n' "$patch" > "$out_file"
    echo "written to $out_file" >&2
  fi
  if command -v pbcopy >/dev/null 2>&1; then
    printf '%s\n' "$patch" | pbcopy && echo "copied to clipboard" >&2
  fi
  echo "$(git rev-list --count "$base..HEAD") commit(s) from $base..HEAD" >&2
}

cmd_import() {
  local in_file=""
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help) sed -n '2,40p' "$0"; exit 0 ;;
      -*) die "unknown import option: $1" ;;
      *) in_file="$1"; shift ;;
    esac
  done

  if [[ -z "$in_file" ]]; then
    echo "Paste the patch, then press Ctrl-D:" >&2
    in_file="$(mktemp "${TMPDIR:-/tmp}/patch-transfer.XXXXXX.patch")"
    # shellcheck disable=SC2064
    trap "rm -f '$in_file'" EXIT
    cat > "$in_file"
  fi
  [[ -s "$in_file" ]] || die "empty patch"

  # --3way lets git fall back to a merge when context has drifted.
  if git am --3way "$in_file"; then
    echo >&2
    echo "Applied. New commits are on your current branch (git log)." >&2
  else
    echo >&2
    echo "git am stopped (conflict or malformed patch)." >&2
    echo "  fix conflicts then: git am --continue" >&2
    echo "  or bail out with:   git am --abort" >&2
    exit 1
  fi
}

case "${1:-}" in
  export) shift; cmd_export "$@" ;;
  import) shift; cmd_import "$@" ;;
  -h|--help|"") sed -n '2,40p' "$0" ;;
  *) die "unknown command: $1 (expected 'export' or 'import')" ;;
esac
