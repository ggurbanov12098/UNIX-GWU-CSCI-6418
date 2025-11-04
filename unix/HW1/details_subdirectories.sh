#!/bin/bash

path="${1:-.}"

if [ -f "$path" ]; then
  echo "It's a file: $path"
  ls -l -- "$path"
  exit 0
fi
if [ ! -d "$path" ]; then
  echo "Not found or not a directory: $path" >&2
  exit 1
fi

if [ -z "$1" ]; then
  echo "Subdirectories of $(pwd) (detailed):"
  ls -ld -- */ 2>/dev/null || echo "(none)"
else
  echo "Contents of $path (detailed):"
  ls -lA -- "$path"
fi
