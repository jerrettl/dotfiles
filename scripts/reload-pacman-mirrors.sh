#!/bin/bash

# Run as root
if [ "$(id -u)" -ne 0 ]; then
	echo "Please run this script as root."
	exit
else
	mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
	wget "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4" -O /etc/pacman.d/mirrorlist.new
	sed --in-place -E 's/^#(.*)$/\1/' /etc/pacman.d/mirrorlist.new
	rankmirrors -n 10 /etc/pacman.d/mirrorlist.new > /etc/pacman.d/mirrorlist
	rm /etc/pacman.d/mirrorlist.new
fi
