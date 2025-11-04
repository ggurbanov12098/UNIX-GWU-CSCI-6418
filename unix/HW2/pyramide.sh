#!/bin/bash
N=$1
for i in $(seq 1 $N)
do
  s=$(seq -s '' 1 $i)
  printf "%$((N-i))s%s%s\n" "" "$s" "$(rev <<< "$s")"
done


