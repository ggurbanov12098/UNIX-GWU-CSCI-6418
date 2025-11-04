#!/bin/bash
set -euo pipefail

if [ $# -ne 2 ]; then
  echo "usage: $0 \"<sentence>\" \"<needle>\"" >&2
  exit 1
fi

s=$1
pat=$2

# If the needle doesn't occur, say so and exit.
if [[ $s != *"$pat"* ]]; then
  echo "No match."
  exit 0
fi

#
before_first=${s%%"$pat"*}
after_first=${s#*"$pat"}
match_first=$pat

#
before_last=${s%"$pat"*}
after_last=${s##*"$pat"}

echo "INPUT:      [$s]"
echo "NEEDLE:     [$pat]"
echo
echo "— First occurrence —"
echo "before:     [$before_first]"
echo "match:      [$match_first]"
echo "after:      [$after_first]"
echo
echo "— Last occurrence —"
echo "before:     [$before_last]"
echo "after:      [$after_last]"
echo
echo "— Quick summary of practice —"
echo '${var#*pat}   -> after FIRST match'
echo '${var##*pat}  -> after LAST match'
echo '${var%pat*}   -> before LAST match'
echo '${var%%pat*}  -> before FIRST match'
