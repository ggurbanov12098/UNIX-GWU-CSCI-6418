if [ "$#" -ne 4 ]; then
	printf "input 4 numbers\n"
	exit 1
fi

num1=$1
num2=$2
num3=$3
num4=$4

sum=$((num1+num2+num3+num4))
printf "the sum is $sum\n"
exit 0
