#!/bin/bash
[ $# -eq 1 ] || { echo "Usage: ${0##*/} <fahrenheit>"; exit 1; }
c=$(bc -l <<< "($1-32)*5/9")
printf "%.2f\n" "$c"

