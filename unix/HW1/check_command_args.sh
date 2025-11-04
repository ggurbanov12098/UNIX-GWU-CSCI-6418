#!/bin/bash

for item in "$@"; do
	if [ -d "$item" ]; then
		printf "'$item' is a directory\n"
	elif [ -f "$item" ]; then
		printf "'$item' is a file\n"
	else 
		printf "'$item' is not found or it's NOT a valid file/directory\n"
	fi
done
