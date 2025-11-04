#!/bin/bash

#!/usr/bin/env bash
# Usage: details.sh [PATH]
p="${1:-.}"

if [ -f "$p" ]; then
  printf 'Nothing to list: "%s" is a file.\n' "$p"
elif [ -d "$p" ]; then
  ls -l -- "$p"
else
  printf 'No such file or directory: "%s"\n' "$p"
  exit 1
fi

