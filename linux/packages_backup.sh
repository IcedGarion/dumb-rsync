#!/bin/bash

# Generates a file containing all installed packages.
# (already included in backup_scipt.sh)

# packages backup
dpkg --get-selections > installed_packages.txt


# to restore installed packages in new systems:
# (apt install dselect)
# dpkg --set-selections < installed_packages.txt
# dselect install

# or
# dpkg --merge-avail <(apt-cache dumpavail)
# dpkg --clear-selections
# dpkg --set-selections < installed_packages.txt
# apt-get dselect-upgrade
