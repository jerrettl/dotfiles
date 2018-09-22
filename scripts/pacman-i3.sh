#!/bin/bash

# Defined in cron as:
# */30 * * * * ~/dotfiles/scripts/pacman-i3.sh

update="pkill -RTMIN+2 i3blocks"

case "$BLOCK_BUTTON" in
	1) urxvt -e sudo pacman -Su ;;
esac

# This command does not need a password since an exception has been created for it in sudoers
sudo pacman -Sy >/dev/null 2>&1

# If there are no updates, stop
number=$(pacman -Qu | wc -l)
if [ "$number" == "0" ]; then exit; fi

# If there are updates, download them to local storage
sudo pacman -Sywu --noconfirm >/dev/null 2>&1

if [ "$number" == "1" ]; then
	indicator="$number Update"
else
	indicator="$number Updates"
fi

# ad3a00 - orange
# 007018 - green
echo "<span color='#ffffff' background='#007018'>  $indicator  </span>"
$update
