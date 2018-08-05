#!/bin/bash

getlevel() { amixer sget Master | grep -m1 "%" | cut -d '[' -f '2' | cut -d ']' -f 1 ;}

if [ "$1" = "level" ]; then
	if [ -n "$(amixer sget Master | grep "off")" ]; then
		echo "Muted"
		exit
	else
		getlevel
		exit
	fi
fi

#xdotool key ctrl+space
#xdotool key ctrl+space

if [ "$1" = "up" ]; then
	pactl -- set-sink-volume 0 +5%
elif [ "$1" = "down" ]; then
	pactl -- set-sink-volume 0 -5%
fi

pkill -RTMIN+1 i3blocks
#notify-send -c volume 'Volume' "$(getlevel)"
