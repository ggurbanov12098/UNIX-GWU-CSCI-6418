#!/usr/bin/env bash
# change_coins.sh — minimum coin change (US 25/10/5/1)
# Usage: ./change_coins.sh TOTAL PAID
# Examples:
#   ./change_coins.sh 2.35 5
#   ./change_coins.sh $1.99 $2.50
#   ./change_coins.sh .07 .25

set -e
set -o pipefail
  
# --- Parse & normalize a money amount into integer cents (no awk, bc) ---
to_cents() {
  local raw="$1"
  local s dollars cents base third

  # Remove $, commas, and spaces
  s="${raw//[$, ]/}"

  # Validate: digits with optional decimal
  [[ "$s" =~ ^[0-9]*([.][0-9]+)?$ ]] || {
    echo "ERR" ; return 1;
  }

  dollars="0"; cents="00"
  if [[ "$s" == *.* ]]; then
    IFS='.' read -r dollars cents <<<"$s"
    dollars="${dollars:-0}"
    cents="${cents:-0}"
    # Round to 2 decimals manually
    if   (( ${#cents} == 0 )); then cents="00"
    elif (( ${#cents} == 1 )); then cents="${cents}0"
    elif (( ${#cents} >= 3 )); then
      base="${cents:0:2}"
      third="${cents:2:1}"; [[ -z "$third" ]] && third="0"
      if (( 10#$third >= 5 )); then
        base=$((10#$base + 1))
      fi
      if (( base >= 100 )); then
        dollars=$((10#${dollars:-0} + 1))
        base=0
      fi
      printf -v cents "%02d" "$base"
    else
      cents="${cents:0:2}"
    fi
  else
    dollars="${s:-0}"
    cents="00"
  fi

  dollars=$((10#${dollars:-0}))
  cents=$((10#${cents:-0}))
  echo $(( dollars * 100 + cents ))
}

# --- Args ---
if (( $# < 2 )); then
  echo "Usage: $0 TOTAL PAID" >&2
  exit 1
fi

total_cents="$(to_cents "$1")" || { echo "Invalid TOTAL: $1" >&2; exit 1; }
paid_cents="$(to_cents "$2")"  || { echo "Invalid PAID: $2"  >&2; exit 1; }

# --- Compute change ---
if (( paid_cents < total_cents )); then
  owe=$(( total_cents - paid_cents ))
  printf "Paid less than total. Still owed: $%d.%02d\n" $((owe/100)) $((owe%100))
  exit 0
fi

change=$(( paid_cents - total_cents ))
if (( change == 0 )); then
  echo "Exact payment. No change."
  exit 0
fi

# --- Greedy breakdown (optimal for US coins) ---
quarters=$(( change / 25 )); rem=$(( change % 25 ))
dimes=$(( rem / 10 ));        rem=$(( rem % 10 ))
nickels=$(( rem / 5 ))
pennies=$(( rem % 5 ))

total_coins=$(( quarters + dimes + nickels + pennies ))

# --- Output ---
printf "Change due: $%d.%02d (%d cents)\n" $((change/100)) $((change%100)) "$change"
printf "Minimum coins: %d\n" "$total_coins"
printf "  quarters: %d\n" "$quarters"
printf "  dimes:    %d\n" "$dimes"
printf "  nickels:  %d\n" "$nickels"
printf "  pennies:  %d\n" "$pennies"
