#!/bin/bash
if [ $# -ne 1 ]; then
  echo "usage: $0 <path>"
  exit 1
fi

p="$1"

if [ -d "$p" ]; then
  echo "directory"
elif [ -f "$p" ]; then
  echo "file"
elif [ -L "$p" ]; then
  echo "symlink"
elif [ -e "$p" ]; then
  echo "other (exists but not a regular file/dir)"
else
  echo "not found"
  exit 1
fi
