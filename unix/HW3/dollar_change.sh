#!/usr/bin/env bash

# Turn a money string into integer cents (rounds to 2dp).
to_cents() {
  local s="${1//[$, ]/}"                 # drop $, commas, spaces
  [[ $s =~ ^[0-9]*([.][0-9]*)?$ ]] || return 1
  printf -v n '%.2f' "$s"                # round to 2 decimals
  echo $((10#${n/./}))                   # remove dot, make integer (avoid octal)
}

# Args
(( $# == 2 )) || { echo "Usage: ${0##*/} TOTAL PAID" >&2; exit 1; }
total=$(to_cents "$1") || { echo "Invalid TOTAL: $1" >&2; exit 1; }
paid=$(to_cents "$2")  || { echo "Invalid PAID: $2"  >&2; exit 1; }

# Compute change / owed
if (( paid < total )); then
  owe=$((total - paid))
  printf "Paid less than total. Still owed: $%d.%02d\n" $((owe/100)) $((owe%100))
  exit 0
fi

change=$((paid - total))
(( change == 0 )) && { echo "Exact payment. No change."; exit 0; }

# Greedy optimal breakdown for US coins
q=$(( change / 25 )); r=$(( change % 25 ))
d=$(( r / 10 ));      r=$(( r % 10 ))
n=$(( r / 5 ))
p=$(( r % 5 ))
coins=$(( q + d + n + p ))

# Output
printf "Change due: $%d.%02d (%d cents)\n" $((change/100)) $((change%100)) "$change"
printf "Minimum coins: %d\n" "$coins"
printf "  quarters: %d\n  dimes:    %d\n  nickels:  %d\n  pennies:  %d\n" "$q" "$d" "$n" "$p"
if [ $q -eq 0 ]; then
