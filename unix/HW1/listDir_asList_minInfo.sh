#!/bin/bash

if [ "$#" -gt 1 ]; then
  echo "usage: $0 [directory]"
  exit 1
fi
dir="${1:-.}"
for d in "$dir"/*/; do
  [ -d "$d" ] || continue       # skip if doesn't  match
  name="${d%/}"                 # dropping slash
  name="${name##*/}"            # keep last part
  printf '%s\n' "$name"
done

