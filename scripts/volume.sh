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


if [ "$1" = "up" ]; then
	amixer -q sset Master 5%+
elif [ "$1" = "down" ]; then
	amixer -q sset Master 5%-
elif [ "$1" = "toggle" ]; then
	amixer -q sset Master toggle
fi

pkill -RTMIN+1 i3blocks
