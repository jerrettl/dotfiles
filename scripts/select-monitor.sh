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

elif [ "$hostname" == "dell-xps400" ]; then
	if [ "$action" == "primary" ]; then
		xrandr --output "VGA-0" --auto --output "DVI-0" --off
	elif [ "$action" == "secondary" ]; then
		xrandr --output "VGA-0" --off --output "DVI-0" --auto
	elif [ "$action" == "mirror" ]; then
		xrandr --output "VGA-0" --rate 60 --mode 1280x1024 --fb 1280x1024 --panning 1280x1024 --output "DVI-0" --mode 1280x1024 --same-as "VGA-0"
	elif [ "$action" == "extend" ]; then
		xrandr --output "VGA-0" --auto --output "DVI-0" --off
		xrandr --output "VGA-0" --primary --mode 1280x1024 --pos 0x0 --rotate normal --output "DVI-0" --mode 1280x1024 --pos 1280x0 --rotate normal
	fi

elif [ "$hostname" == "lg-gram" ]; then
	if [ "$action" == "primary" ]; then
		xrandr --output "eDP-1" --auto --output "HDMI-1" --off
	elif [ "$action" == "secondary" ]; then
		xrandr --output "eDP-1" --off --output "HDMI-1" --auto
	elif [ "$action" == "mirror" ]; then
		xrandr --output "eDP-1" --primary --mode 1920x1080 --output "HDMI-1" --mode 1920x1080 --same-as "eDP-1"
	elif [ "$action" == "extend" ]; then
		xrandr --output "eDP-1" --primary --mode 1920x1080 --pos 0x0 --rotate normal --output "HDMI-1" --mode 1920x1080 --pos 1920x0 --rotate normal
	fi
fi

feh --bg-fill ~/dotfiles/wallpaper.png
