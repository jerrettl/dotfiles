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

elif [ "$hostname" == "inspiron-15-3537" ]; then
	if [ "$action" == "primary" ]; then
		xrandr --output eDP1 --auto --output HDMI1 --off
	elif [ "$action" == "secondary" ]; then
		xrandr --output eDP1 --off --output HDMI1 --auto
	elif [ "$action" == "mirror" ]; then
		xrandr --output eDP1 --rate 60 --mode 1280x720 --fb 1280x720 --panning 1280x720 --output HDMI1 --mode 1280x720 --same-as eDP1
	fi
fi

feh --bg-fill ~/dotfiles/wallpaper.png
