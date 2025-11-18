date1 :=$(shell date)

ru:
	@ printf ">> make r0\n"
	@ printf ">> make r1\n"
	@ printf ">> make r2\n"
	@ printf ">> make r3\n"
	@ printf ">> make r4\n"
	@ printf "\n"

r0:
	@ printf "\n"
	@ printf "This is rule 1\n"
	@ printf "Date: [$(shell date)]\n"
	@ printf "\n"

r1:
	@ printf "\n"
	@ printf " ................x=without quotes.....................\n"
	- x=$(date1);y=5
	- printf "Date: [$${x}]	and	y=$${y}\n"
	@ printf "\n"

r2:
	@ printf "\n"
	@ printf " ................x=without quotes.....................\n"
	- x=$(date1);y=5; printf "Date: [$${x}]	and y=$${y}\n"
	@ printf "\n"

r3:
	@ printf "\n"
	@ printf " ...............x=with	quotes.................\n"
	- x="$(date1)";y=5
	- printf "Date: [$${x}] 	and	y=$${y}\n"
	@ printf "\n"

r4:
	@ printf "\n"
	@ printf " ......................................................\n"
	@ printf " .............x=with	quotes..(all in 1 sub-shell).....\n"
	@ printf " ......................................................\n"
	- x="$(date1)";y=5; printf "Date: [$${x}]	and 	y=$${y}\n"
	@ printf "\n"
