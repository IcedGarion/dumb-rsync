# parametri
file="/cygdrive/c/Users/debian/Desktop/backup/file_list.txt"
server="192.168.1.110"
port="2200"
dest="/home/backup/TEST"


# backup
rsync --recursive --compress --progress -vv -e "ssh -p $port" --files-from=$file "" backup@$server:$dest
