#!/usr/local/bin/bash

root=$1
first=true
out=""
dir=$pwd
for file in `bash -c "cd $root && find *"` ; do 
	if $first; then
		first=false
	else
		out=$out,
	fi
	out=$out\"$file\":\"`sha256 -q $root/$file`\"; 
done

echo $out

