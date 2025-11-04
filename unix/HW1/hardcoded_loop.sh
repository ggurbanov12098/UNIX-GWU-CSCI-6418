#!/bin/bash
if [ $# -ne 1 ]; then
  echo "usage: $0 <N>"
  exit 1
fi

N="$1"

int_re='^[0-9]+$'
if ! [[ $N =~ $int_re ]]; then
  echo "Provide a non-negative integer"
  exit 1
fi

i=1
while [ "$i" -le "$N" ]; do
  echo "Line $i printed with hardcoded 'while' loop"
  i=$(( i + 1 ))
done
