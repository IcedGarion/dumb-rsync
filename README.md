# RSYNC BACKUP

## Description
This repository contains a collection of tools and scripts for backup automation, running
on Windows and Linux clients.
Backup relies on [rsync](https://rsync.samba.org/), a fast and stable linux command performing incremental backups
on local or remote machines.
This solution is not suitable for enterprise systems and just wants to be a simple guideline for those linux users
who want to study / experiment how to create a simple backup system, exploiting existing system tools. If you have and
old unused pc and you want to make something useful out of it, then this is it!

This project is inspired by http://www.megalab.it/4485/realizzare-un-backup-da-remoto-con-rsync-windows-mac-e-linux

## How it works
- set up a linux server with ssh and rsync installed.
- edit the file_list.txt file by adding the directories' paths you want to back up (one per line).
- edit the backup_script.sh file by adding the IP address of a linux server hosting the files and where to put them.
- launch the script and wait for the files to be back'd up!
- ( you can also schedule automatic backups )

The script reads from file_list.txt and sends the listed directories to the backup server.

## Requirements
This system can only be set up by a relatively skilled user, and then deployed in a way that
lets unskilled users make use of it. Just follow the guide, but **beware**: you need some basic googling and linux skills,
as well as a lot of patience, because of some linux-windows incompatibilities.

### Server
You need a pc running any linux distro, and a large enough storage capability.
It will be your backup machine: you can keep it always on and waiting for connections,
or you can power it on when you need to send your files (e.g. for a local backup server).

The linux backup server needs a public static IP or a registered DNS name to be put as a parameter in the
backup script. Alternatively, if you are planning to build a LAN backup, you can easily set up a local static IP.

### Clients
PCs from where you send your precious files can be both linux or windows:
- linux must have ssh and rsync installed.
- windows is a bit more complicated: it needs [cygwin](https://cygwin.com/install.html) to emulate a linux bash shell in its enviroiment.
  You then have to install cygwin, along with ssh and rsync packages.


# Step-by-step guide
### Linux Server
Server must be a linux. Assuming that you have a working and net-connected linux system already installed, depending on your distribution:
- install openssh-server:
`
	apt-get install openssh-server   
	yum install openssh-server   
	pacman -S openssh-server   
	and so on...   
`
  Google "how to install ssh server" on your distro.

- install rsync in the same way:
`
	apt-get install rsync   
	...   
`
  (Same as ssh)

- set up a static IP or, if you already have one and / or just know what to do, **look at your linux server IP** (ip addr show)
  Alternatively, google "linux static IP configuration".
  Your server's IP must be later placed into your client's backup_script.sh as a parameter.


### Linux Client
- you just need to edit the backup_script.sh file:   
`
	#!/usr/bin/env bash   
	   
	# params   
	file="file_list.txt"    
	server="192.168.1.110"   
	port="2200"   
	dest="/home/backup/TEST"   
	   
	...   
`

  "file" will be a plain text file containing the directories paths to be back'd up.
  "server" will contain your backup server's IP: for a LAN server, it will look like "192.168.1.xxx".
  "port": the default port for ssh (rsync) would be 22 (unless you manually change it).
  The last parameter is the directory, in the backup server, in which your sent files will be saved.

- add the files / directories you want to back up to "file_list.txt":
`
	/home/user/test.txt   
	/home/user/Documents   
	/tmp/something   
`
- launch "backup_script.sh" (make it executable first with `chmod +x backup_script.sh`).
  You will see some printed information about what's happening: when rsync will try to connect from your client 
  to the backup server, you will be prompted to insert the chosen user's password.

- optionally, you can set up [ssh public key authentication](https://www.linode.com/docs/security/authentication/use-public-key-authentication-with-ssh/)
  to avoid entering the password every time, and to improve the system's security.
  You should change ssh default port, too (and update the parameter in backup_script.sh)

  For other security informations, see [improving ssh security](https://www.cyberciti.biz/tips/linux-unix-bsd-openssh-server-best-practices.html)


### Windows Client
We need a way to run rsync on native windows clients. This solution relies on cygwin, an external tool that lets you run bash on windows.

- install cygwin: https://cygwin.com/install.html

- during the install dialog, check to install the packages `rsync` and `openssh`

- you should now have a fully functional bash installation

- edit "backup_script.sh":

`
	# params   
	file="/cygdrive/c/Users/user/Desktop/backup/file_list.txt"   
	server="192.168.1.110"   
	port="2200"   
	dest="/home/backup/TEST"   
`

In a similar way as for we did on linux client, edit these parameters:

  "file" will be a plain text file containing the directories paths to be back'd up. You must rewrite the path like this:
    `C:\Users\user\something` becomes `/cygdrive/c/Users/user/something`
  **Prepend `/cygdrive/` to the path and change all backslashes into slashes.**
  "server" will contain your backup server's IP: for a LAN server, it will look like "192.168.1.xxx".
  "port": the default port for ssh (rsync) would be 22 (unless you manually change it).
  The last parameter is the directory, in the backup server, in which your sent files will be saved. (Linux style)


- add the files / directories you want to back up to "file_list.txt":
`
	C:\Users\user\Desktop\backup   
	C:\Users\user\Desktop\a_file.txt   
`
**You don't need to prepend /cygdrive/ and translate backslashes into slashes here**

You can try "ADD_TO_BACKUP": a graphical tool for just adding directories to file_list.txt.

- create your launcher: since windows cannot run .sh files (bash source), you need to create a simple executable
  that will launch bash and make it execute our backup_script.sh:
  
  edit EXECUTE_BACKUP.bat

`
  C:\cygwin\bin\bash.exe -li C:\Users\user\Desktop\backup\backup_script_win.sh   
`
  Replace "C:\Users\user\Desktop\backup\backup_script_win.sh" with the location of backup_script.sh on your system, and this .bat will
  call bash and make it run our backup by double-clicking on EXECUTE_BACKUP.bat.
  **You don't need to prepend /cygdrive/ and translate backslashes into slashes here**

  Once run, you will see some printed information about what's happening: when rsync will try to connect from your client 
  to the backup server, you will be prompted to insert the chosen user's password.


- optionally, you can set up [ssh public key authentication](https://www.linode.com/docs/security/authentication/use-public-key-authentication-with-ssh/)
  to avoid entering the password every time, and to improve the system's security.
  You should change ssh default port, too (and update the parameter in backup_script.sh)

  For other security informations, see [improving ssh security](https://www.cyberciti.biz/tips/linux-unix-bsd-openssh-server-best-practices.html)

 

# HOW TO RETRIEVE YOUR FILES
A basic way is just to log in the backup server with ssh / scp and withdraw the desired files. This is not fully automatic and requires
the "skilled user" to do it.

Another way is to use python SimpleHTTPServer:
- install python in linux server and run `python -m http.server 8080` (python3) or `python -c SimpleHTTPServer 8080` (python2):
  it will expose your directories to a simple http interface: type `server_ip:8080` on a browser to see your backed-up files.
  (See https://www.pythonforbeginners.com/modules-in-python/how-to-use-simplehttpserver/ for more)


# PRO / CONS
## Pro
rsync is an old and fast, secure method to back up your files. It sends incremental list so that only changes of your files
are sent; it uses compression and relies on ssh, also a old and secure program.

## Con
Windows is a pain. Directories backed up are shown with their full path and are not always nested in the original way; not to mention
the way to access files from bash, using some strange path mapping. Bugs are just behind the corner.
You also have to install external tools like cygwin and, last, the graphical tool for adding files is just a dumb and 2-minute work program.


# TODO / IMPROVEMENTS
- Graphical tool for managing all the files and for launch backup.
- Directories sent to server from windows are shown in an ugly way.
- rsync has multiple ways of use: delete from client old files not existing on server is just one of them. Let user decide.
- easy way to retrieve files
