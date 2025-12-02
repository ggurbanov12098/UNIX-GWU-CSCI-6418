#!/bin/bash
# random card draws and count how many times each card appears.

# Deck of cards
cards=(2 3 4 5 6 7 8 9 J Q K A)
draws=$1
counts=(0 0 0 0 0 0 0 0 0 0 0 0)

# Loop for each draw
for ((i=0; i<draws; i++)); do
    idx=$((RANDOM % 12))
    counts[$idx]=$((counts[$idx] + 1))
done
echo "Results after $draws draws:"
echo
for i in "${!cards[@]}"; do
    printf "%-2s was drawn %d times\n" "${cards[$i]}" "${counts[$i]}"
done
