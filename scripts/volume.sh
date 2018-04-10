#!/bin/bash

xdotool key ctrl+shift+space

if [ "$1" = "up" ]; then
	amixer set Master 5%+
elif [ "$1" = "down" ]; then
	amixer set Master 5%-
fi

level=$(awk '/%/ {gsub(/[\[\]]/,""); print $5}' <(amixer sget Master))
notify-send -c volume 'Volume' "$level"

