#!/usr/bin/env bash

if [ "$#" -eq 0 ]; then
	printf 'Usage: %s [DIRECTORY] [--color]\n' "$(basename "$0")" >&2
	exit 1
fi

set -euo pipefail
D="${1:-.}"; [ -d "$D" ] || { echo "Not a directory: $D" >&2; exit 1; }
COLOR="${2:-}"

# optional color (dirs blue, execs green, symlinks cyan)
B=""; G=""; C=""; R=""
[ "$COLOR" = "--color" ] && B=$'\e[1;34m' G=$'\e[1;32m' C=$'\e[1;36m' R=$'\e[0m'

ABS="$(cd "$D" && pwd)"
printf 'Directory : %s\n' "$ABS"
printf 'Total size: %s\n\n' "$(du -sh -- "$ABS" 2>/dev/null | cut -f1)"
printf 'Format    : ::: [<idx>] :::::::: <perms> <size> /// <path>\n\n'

i=0

while IFS= read -r name; do
  f="$ABS/$name"
  perms="$(stat -c '%A' -- "$f" 2>/dev/null || echo '?????????')"
  size="$(du -sh -- "$f" 2>/dev/null | cut -f1)"; : "${size:=?}"

  # path marker + color
  mark=""; col=""
  if [ -L "$f" ]; then mark="@"; col="$C"
  elif [ -d "$f" ]; then mark="/"; col="$B"
  elif [ -x "$f" ]; then mark="*"; col="$G"
  fi

  i=$((i+1))
  printf '::: [%3d] :::::::: %-10s %6s /// %s%s%s%s\n' \
    "$i" "$perms" "$size" "$col" "$f" "$mark" "$R"
done < <(find "$ABS" -mindepth 1 -maxdepth 1 -printf '%P\n' 2>/dev/null | LC_ALL=C sort)

printf '\nItems: %d\n' "$i"
