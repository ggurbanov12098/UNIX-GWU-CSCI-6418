#!/bin/bash

path="${1:-.}"

if [ -f "$path" ]; then
  echo "It's a file: $path (nothing to list)"
  exit 0
fi
if [ ! -d "$path" ]; then
  echo "Not found or not a directory: $path" >&2
  exit 1
fi

if [ -z "$1" ]; then
  echo "Subdirectories of $(pwd):"
  ls -1 -d */ 2>/dev/null | sed 's:/$::' || echo "(none)"
else
  echo "Contents of $path:"
  ls -A1 "$path"
fi
