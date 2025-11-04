#!/usr/bin/env bash
# Usage: ./count_tree.sh [PATH]
set -euo pipefail

DIR="${1:-.}"
[ -d "$DIR" ] || { echo "Not a directory: $DIR" >&2; exit 1; }

# Helper: robust count using find -printf '.' | wc -c (safe for weird names)
count() { find "$DIR" -mindepth 1 "$@" -printf '.' 2>/dev/null | wc -c; }

dirs=$(   count -type d)
files=$(  count -type f)
links=$(  count -type l)
dots=$(   count -type f -name '.*')
total=$(  count )                       # all entries of any type
others=$(( total - dirs - files - links ))

printf "Path          : %s\n" "$(cd "$DIR" && pwd)"
printf "Total entries : %d\n" "$total"
printf "  directories : %d\n" "$dirs"
printf "  files       : %d\n" "$files"
printf "  dotfiles    : %d\n" "$dots"
printf "  symlinks    : %d\n" "$links"
printf "  other types : %d\n" "$others"
