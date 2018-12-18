#!/bin/bash

# Defined in cron as:
# */30 * * * * ~/dotfiles/scripts/pacman-i3.sh

# Entry added to /etc/sudoers:
# username ALL=(ALL) NOPASSWD: /usr/bin/pacman -Sy >/dev/null 2>&1, /usr/bin/pacman -Sywu --noconfirm >/dev/null 2>&1

update="pkill -RTMIN+2 i3blocks"

case "$BLOCK_BUTTON" in
	1) urxvt -e sh -c "pacman -Qu --color=auto && echo && sudo pacman -Su --color=auto" ;;
esac

# This command does not need a password since an exception has been created for it in sudoers
sudo pacman -Sy >/dev/null 2>&1

# If there are no updates, stop
number=$(pacman -Qu | grep -vic ignore)
if [ "$number" == "0" ]; then echo ""; $update; exit; fi

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
