#!/bin/bash
TAX_RATE=0.06

if [ $# -ne 1 ]; then
  echo "usage: $0 <amount>"
  exit 1
fi

amt="$1"

num_re='^[0-9]+([.][0-9]+)?$'
if ! [[ $amt =~ $num_re ]]; then
  echo "Please provide a non-negative number like 20, 12.50, 7.99"
  exit 1
fi

tax=$(echo "$amt * $TAX_RATE" | bc -l)
total=$(echo "$amt + $tax" | bc -l)
rate_pct=$(echo "$TAX_RATE * 100" | bc -l)

printf "Amount:   \$%.2f\n" "$amt"
printf "Tax (%.0f%%): \$%.2f\n" "$rate_pct" "$tax"
printf "Total:    \$%.2f\n" "$total"
