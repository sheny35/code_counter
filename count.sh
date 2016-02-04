#!/bin/bash

args=( "$@" )
rootFolder=${args[0]}
exts=( "${args[@]:1}" )

folders=( $(find $rootFolder -name "*" -maxdepth 1 -mindepth 1) )
lines=0
for folder in ${folders[@]}; do 
	echo $folder
	tmplines=0
	for ext in ${exts[@]}; do
		line=$(find $folder -name "*.$ext" | xargs cat | wc -l)
		[[ -z "$line" ]] && line=0
		tmplines=$((tmplines + line))
		echo "$ext: $line"
	done
	echo "Sum: $tmplines"
	lines=$((tmplines+lines))
done

echo "Total: $lines"
