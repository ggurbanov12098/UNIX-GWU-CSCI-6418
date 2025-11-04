sum=0

for num in "$@"; do
	printf "The $# variable is: ${num}\n"
	sum=$((sum+num))
done

printf "The sum is: $(sum)\n"

