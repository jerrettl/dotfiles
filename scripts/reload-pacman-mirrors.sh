#!/bin/bash

# Run as root
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
wget "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4" -O /etc/pacman.d/mirrorlist.new
sed --in-place -E 's/^#(.*)$/\1/' /etc/pacman.d/mirrorlist.new
rankmirrors -n 10 /etc/pacman.d/mirrorlist.new > /etc/pacman.d/mirrorlist
rm /etc/pacman.d/mirrorlist.new
