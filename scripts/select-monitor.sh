#!/bin/bash

action="$1"
hostname="$(hostname)"

if [ "$hostname" == "arch-aspire-d255" ]; then
	if [ "$action" == "primary" ]; then
		xrandr --output LVDS1 --auto --output VGA1 --off
	elif [ "$action" == "secondary" ]; then
		xrandr --output LVDS1 --off --output VGA1 --auto
	elif [ "$action" == "mirror" ]; then
		xrandr --output LVDS1 --rate 60 --mode 800x600 --fb 800x600 --panning 800x600 --output VGA1 --mode 800x600 --same-as LVDS1
	fi
fi

feh --bg-fill ~/dotfiles/wallpaper.png
