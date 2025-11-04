#!/bin/bash

if [ $# -gt 1 ]; then
  echo "usage: $0 [file]" >&2; exit 1
fi

if [ $# -eq 1 ]; then
  mapfile -t lines < "$1"
else
  mapfile -t lines < /dev/stdin
fi

# maximum line length
max=0
for s in "${lines[@]}"; do
  (( ${#s} > max )) && max=${#s}
done

# right-aligned
for s in "${lines[@]}"; do
  printf "%*s\n" "$max" "$s"
done
