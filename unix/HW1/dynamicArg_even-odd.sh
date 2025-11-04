#!/bin/bash

[ "$#" -eq 0 ] && { printf 'Usage: %s N1 [N2 ...]\n' "$0"; exit 1; }

for n in "$@"; do
  if printf '%d' "$n" >/dev/null 2>&1; then
    val=$(printf '%d' "$n")
    (( val % 2 == 0 )) && printf '%s: even\n' "$n" || printf '%s: odd\n' "$n"
  else
    printf '%s: not an integer\n' "$n"
  fi
done
