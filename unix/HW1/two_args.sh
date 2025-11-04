#!/bin/bash

if [ $# -ne 2 ]; then
  echo "usage: $0 <num1> <num2>"
  exit 1
fi

a="$1"; b="$2"

num_re='^-?[0-9]+([.][0-9]+)?$'
if ! [[ $a =~ $num_re && $b =~ $num_re ]]; then
  echo "Please provide numbers (integers or decimals)."
  exit 1
fi

sum=$(echo "$a + $b" | bc -l)
diff=$(echo "$a - $b" | bc -l)
prod=$(echo "$a * $b" | bc -l)

if echo "$b == 0" | bc -l | grep -q 1; then
  quot="undefined (division by zero)"
else
  quot=$(echo "$a / $b" | bc -l)
fi

printf "a=%s, b=%s\n" "$a" "$b"
printf "sum:         %s\n" "$sum"
printf "difference:  %s\n" "$diff"
printf "product:     %s\n" "$prod"
printf "quotient:    %s\n" "$quot"
