#!/usr/bin/env bash
# lines_range_file.sh — print a line or a range from a text file
# Usage:
#   ./lines_range_file.sh FILE N
#   ./lines_range_file.sh FILE START END

set -u

usage(){ echo "Usage: ${0##*/} FILE N  |  ${0##*/} FILE START END" >&2; exit 1; }
(( $#==2 || $#==3 )) || usage

file="$1"
[ -r "$file" ] || { echo "Not readable: $file" >&2; exit 0; }

isint(){ [[ "$1" =~ ^[0-9]+$ ]]; }

lines=$(wc -l < "$file"); lines=${lines:-0}

if (( $#==2 )); then
  n="$2"; isint "$n" || usage
  if (( n<1 || n>lines )); then
    echo "Line $n out of range (1..$lines)"; exit 0
  fi
  sed -n "${n}p" -- "$file"
else
  a="$2"; b="$3"; isint "$a" && isint "$b" || usage
  # normalize range
  if (( a>b )); then t="$a"; a="$b"; b="$t"; fi
  (( a<1 )) && a=1
  (( b>lines )) && b="$lines"
  if (( lines==0 || a>b )); then
    echo "No lines in range (file has $lines lines)"; exit 0
  fi
  sed -n "${a},${b}p" -- "$file"
fi
