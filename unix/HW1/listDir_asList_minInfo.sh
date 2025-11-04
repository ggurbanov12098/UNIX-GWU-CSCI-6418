#!/bin/bash
dir="${1:-.}"

for d in "$dir"/*/; do
  [ -d "$d" ] || continue       # skip if doesn't  match
  name="${d%/}"                 # dropping slash
  name="${name##*/}"            # keep last part
  printf '%s\n' "$name"
done

