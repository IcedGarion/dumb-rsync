#!/bin/bash

# parametri
file="file_list.txt"
packages="installed_packages.txt"
server="192.168.1.110"
port="2200"
dest="/home/backup/TEST"

# aggiunge il file dei packages nella lista di file da copiare
dpkg --get-selections >> $packages
echo $packages >> $file

echo "Files to back up:"
cat $file


# backup cmd
rsync --recursive --compress --progress -vv -e "ssh -p 2200" $(cat $file) backup@$server:$dest
