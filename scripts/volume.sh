#!/bin/bash

pkill dunst
dunst -history_length 1 -hide_duplicates_count true &

if [ "$1" = "up" ]; then
	amixer set Master 5%+
elif [ "$1" = "down" ]; then
	amixer set Master 5%-
fi

level=$(awk '/%/ {gsub(/[\[\]]/,""); print $5}' <(amixer sget Master))
notify-send -c volume 'Volume' "$level"

