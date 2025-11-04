#!/bin/bash

if [ $# -ne 2 ]; then
  echo "usage: $0 <int1> <int2>"
  exit 1
fi

a="$1"; b="$2"

int_re='^-?[0-9]+$'
if ! [[ $a =~ $int_re && $b =~ $int_re ]]; then
  echo "Please provide two integers (e.g., -3 10)."
  exit 1
fi

parity() {
  (( $1 % 2 == 0 )) && echo "even" || echo "odd"
}

echo "a=$a ($(parity "$a"))"
echo "b=$b ($(parity "$b"))"
echo

sum=$((a + b))
diff=$((a - b))
prod=$((a * b))

echo "a + b = $sum ($(parity "$sum"))"
echo "a - b = $diff ($(parity "$diff"))"
echo "a * b = $prod ($(parity "$prod"))"

if (( b == 0 )); then
  echo "a / b = undefined (division by zero)"
  echo "a % b = undefined (division by zero)"
else
  quot=$((a / b))
  rem=$((a % b))
  echo "a / b = $quot ($(parity "$quot"))   # integer division"
  echo "a % b = $rem  ($(parity "$rem"))    # remainder"
fi
