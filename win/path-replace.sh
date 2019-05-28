#!/bin/bash

file="./file_list.txt"
paths=""

# in win pero' scrivi il file con \n\r quindi foreach qua non so se va
# non e' detto che non prenda anche il \r accorpato con path
for path in $(tr '\\' '/' < $file)
do
	drive=${path:0:1}
	cygpath="/cygdrive/"${drive,,}"/"${path:3:200}
	paths=$paths" "$cygpath
done

echo $paths

