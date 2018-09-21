#!/bin/bash

# Defined in cron as:
# */30 * * * * ~/dotfiles/scripts/pacman-i3.sh

update="pkill -RTMIN+2 i3blocks"

case "$BLOCK_BUTTON" in
	1) urxvt -e sudo pacman -Su ;;
esac

# This command does not need a password since an exception has been created for it in sudoers
sudo pacman -Sy 2>&1 >/dev/null

# If there are no updates, stop
number=$(pacman -Qu | wc -l)
if [ "$number" == "0" ]; then exit; fi

# If there are updates, download them to local storage
sudo pacman -Sywu --noconfirm 2>&1 >/dev/null

# ad3a00 - orange
# 007018 - green
if [ "$number" == "1" ]; then
	indicator=$(echo "$number Update")
else
	indicator=$(echo "$number Updates")
fi

echo "<span color='#ffffff' background='#007018'>  $indicator  </span>"
$update
