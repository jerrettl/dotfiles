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

sink_number=$(pactl list sinks | awk 'NR==1 {print $2}' | cut -c 2-)

if [ "$1" = "up" ]; then
	pactl -- set-sink-volume "$sink_number" +5%
elif [ "$1" = "down" ]; then
	pactl -- set-sink-volume "$sink_number" -5%
elif [ "$1" = "toggle" ]; then
	pactl set-sink-mute "$sink_number" toggle
fi

pkill -RTMIN+1 i3blocks
#notify-send -c volume 'Volume' "$(getlevel)"
