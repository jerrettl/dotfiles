#!/bin/bash

hostname=$(uname -n)

if [ "$1" == "start" ]; then
	notify-send "Starting picom."
elif [ "$1" == "kill" ]; then
	notify-send "Killing picom."
	pkill picom
	exit
fi

picom -b --xrender-sync-fence --sw-opti &

