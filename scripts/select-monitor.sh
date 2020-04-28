#!/bin/bash

action="$1"
hostname="$(hostname)"

if [ "$hostname" == "lg-gram" ]; then
	if [ "$action" == "primary" ]; then
		xrandr --output "eDP1" --auto --output "HDMI1" --off
	elif [ "$action" == "secondary" ]; then
		xrandr --output "eDP1" --off --output "HDMI1" --auto
	elif [ "$action" == "mirror" ]; then
		xrandr --output "eDP1" --primary --mode 1920x1080 --output "HDMI1" --mode 1920x1080 --same-as "eDP1"
	elif [ "$action" == "extend" ]; then
		xrandr --output "eDP1" --primary --mode 1920x1080 --pos 0x0 --rotate normal --output "HDMI1" --mode 1920x1080 --pos 1920x0 --rotate normal
	fi
fi


pkill -RTMIN+1 i3blocks # Volume
feh --bg-fill ~/dotfiles/wallpaper.png
