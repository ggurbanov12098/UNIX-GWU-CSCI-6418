#!/usr/bin/env bash
# usage: ./list_pretty.sh [path1 [path2 ...]]

paths=("$@")
[ ${#paths[@]} -eq 0 ] && paths=(.)

# temp file to collect rows: "size kind path"
tmp=$(mktemp)
cleanup() { rm -f "$tmp"; }
trap cleanup EXIT

for p in "${paths[@]}"; do
  # resolve to absolute path and ensure it's a directory
  if [ -d "$p" ]; then
    base=$(cd "$p" 2>/dev/null && pwd)
  else
    echo "Not a directory: $p" >&2
    continue
  fi

  # list children
  while IFS= read -r -d '' name; do
    full="$base/$name"

    size=$(du -sh -- "$full" 2>/dev/null | cut -f1)
    [ -z "${size:-}" ] && size="?"
    # kind column
    if [ -d "$full" ]; then
      kind="—dir—"
    else
      kind="——"
    fi
    printf "%s\t%s\t%s\n" "$size" "$kind" "$full" >>"$tmp"
  done < <(find "$base" -mindepth 1 -maxdepth 1 -printf '%P\0' 2>/dev/null)
done

# nothing found
if ! [ -s "$tmp" ]; then
  exit 0
fi

# Sort alphabetically by path
sort -t $'\t' -k3,3 "$tmp" | expand -t 1

# divider
echo "::::::::::::"

#1st column
sort -t $'\t' -h -k1,1 "$tmp" | expand -t 1
