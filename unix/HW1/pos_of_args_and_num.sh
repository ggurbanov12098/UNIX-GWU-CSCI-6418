#!/bin/bash

echo "Script name: $0"
echo "Number of args: $#"
echo "1st arg (\$1): ${1-<none>}"
echo "2nd arg (\$2): ${2-<none>}"
echo "10th arg (\${10}): ${10-<none>}"

if [ $# -gt 0 ]; then
  echo "Last arg (\${!#}): ${!#}"
else
  echo "Last arg: <none>"
fi

echo
echo "All args with index:"
i=1
for a in "$@"; do
  printf "  %2d: %s\n" "$i" "$a"
  i=$((i+1))
done

echo
echo 'All args as one string ("$*"):'
echo "  $*"