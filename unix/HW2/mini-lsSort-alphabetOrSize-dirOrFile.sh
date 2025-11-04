#!/usr/bin/env bash
set -euo pipefail

# Use given paths or default to current dir
paths=("$@"); [ ${#paths[@]} -gt 0 ] || paths=(.)

tmp="$(mktemp)"; trap 'rm -f "$tmp"' EXIT

for p in "${paths[@]}"; do
  [ -d "$p" ] || { echo "Not a directory: $p" >&2; continue; }
  base="$(cd "$p" && pwd)"

  # List direct children, null-separated to be safe with spaces
  while IFS= read -r -d '' name; do
    full="$base/$name"

    # human size, permissions with fallbacks
    size="$(du -sh -- "$full" 2>/dev/null | cut -f1)"; : "${size:=?}"
    perms="$(stat -c %A -- "$full" 2>/dev/null || printf '?????????')"

    # type marker
    if   [ -L "$full" ]; then mark="@"
    elif [ -d "$full" ]; then mark="-dir-"
    elif [ -x "$full" ]; then mark="-exec-"
    else mark="-file-"
    fi

    printf "%s\t%s\t%s\t%s\n" "$size" "$perms" "$mark" "$full" >> "$tmp"
  done < <(find "$base" -mindepth 1 -maxdepth 1 -printf '%P\0')
done

# Nothing collected? exit quietly
[ -s "$tmp" ] || exit 0

# Alphabetical-sorted view (path = column 4)
sort -t $'\t' -k4,4 "$tmp" \
| column -s $'\t' -t

echo "::::::::::::::::::LineBreaker:::::::::::::::::::"

# Size-sorted view (human sizes = column 1)
sort -t $'\t' -h -k1,1 "$tmp" \
| column -s $'\t' -t
