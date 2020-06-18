#!/usr/bin/env bash

# params
file="file_list.txt"
server="192.168.1.110"
port="2200"
dest="/home/backup/TEST"
user="backup"

echo "Files to back up:"
cat $file


# backup cmd
rsync --recursive --compress -zz --info=progress2 --no-inc-recursive -vv -e "ssh -p 2200" $(cat $file) $user@$server:$dest
