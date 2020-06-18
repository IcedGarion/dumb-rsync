#!/usr/bin/env bash

# params
file="file_list.txt"
packages="installed_packages.txt"
server="192.168.1.110"
port="2200"
dest="/home/backup/TEST"
user="backup"

# adds packages file to file_list (files to back up)
dpkg --get-selections >> $packages
echo $packages >> $file

echo "Files to back up:"
cat $file


# backup cmd
rsync --recursive --compress -zz --info=progress2 --no-inc-recursive -vv -e "ssh -p 2200" $(cat $file) $user@$server:$dest
