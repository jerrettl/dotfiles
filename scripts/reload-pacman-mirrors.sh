#!/bin/bash

# Run as root
if [ "$(id -u)" -ne 0 ]; then
	echo "Please run this script as root."
	exit
else
	mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
	wget "https://archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on" -O /etc/pacman.d/mirrorlist.new
	sed --in-place -E 's/^#(.*)$/\1/' /etc/pacman.d/mirrorlist.new
	echo "Ranking mirrors..."
	rankmirrors -n 10 /etc/pacman.d/mirrorlist.new > /etc/pacman.d/mirrorlist
	rm /etc/pacman.d/mirrorlist.new
fi
