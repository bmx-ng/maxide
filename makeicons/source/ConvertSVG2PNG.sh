#!/bin/bash
for size in 24 48 64
	do
		mkdir -p "$PWD/../$size"
		for file in $PWD/*.svg
			do
				filename=$(basename "$file")
				rsvg-convert --width=$size --height=$size "$file" -o "../$size/${filename%_16x*}.png"
			done
	done