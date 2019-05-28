# RSYNC BACKUP

## Description
This repository contains a collection of tools and scripts for backup automation, running
on Windows and Linux clients.
Backup relies on [rsync](https://rsync.samba.org/), a fast and stable linux command performing incremental backups
on local or remote machines.
This solution is not suitable for enterprise systems and just wants to be a simple guideline for those linux users
who want to study / experiment how to create a simple backup system, exploiting existing system tools. If you have and
old unused pc and you want to make something useful out of it, then this is it!


## How it works
- set up a linux server with ssh and rsync installed
- edit the file_list.txt file by adding the directories' paths you want to back up
- edit the backup_script.sh file by adding the IP address of a linux server hosting the files and where to put them.
- launch the script and wait for the files to be back'd up!
- ( you can also schedule automatic backups )


## Requirements
This system can only be set up by a relatively skilled user, and then deployed in a way that
lets unskilled users make use of it. Just follow the guide, but **beware**: you need some basic googling and linux skills,
as well as a lot of patience, because of some linux-windows incompatibilities.

# Server
You need a pc running any linux distro, and a large enough storage capability.
It will be your backup machine: you can keep it always on and waiting for connections,
or you can power it on when you need to send your files (e.g. for a local backup server).

The linux backup server needs a public static IP or a registered DNS name to be put as a parameter in the
backup script. Alternatively, if you are planning to build a LAN backup, you can easily set up a local static IP.

# Clients
PCs from where you send your precious files can be both linux or windows:
- linux must have ssh and rsync installed.
- windows is a pain: it needs [cygwin](https://cygwin.com/install.html) to emulate a linux bash shell in its enviroiment.
  You then have to install cygwin, along with ssh and rsync packages.


## Step-by-step guide
# Linux
Assuming that you have a working and net-connected linux system already installed, depending on your distribution:
- install openssh-server:
	apt-get install openssh-server
	yum install openssh-server
	pacman -S openssh-server
	and so on...

  Google "how to install ssh server" on your distro.

- install rsync in the same way:
	apt-get install rsync
	...

- set up a static IP or, if you already have one and / or just know what to do, **copy your linux server IP into backup_script.sh**
  Alternatively, google "linux static IP configuration".

- You just need to edit the backup_script.sh file now:

	#!/usr/bin/env bash
	
	# params
	file="file_list.txt"
	server="192.168.1.110"
	port="2200"
	dest="/home/backup/TEST"

  "file" will be a plain text file containing the directories paths to be back'd up.
  For a LAN server, your IP will look like "192.168.1.xxx": put it on "server" line.
  The default port for ssh / rsync would be 22 (unless you manually change it).
  The last parameter is the directory, in the backup server, in which your sent files will be saved.

# Windows
  
