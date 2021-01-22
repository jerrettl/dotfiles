#!/bin/bash

hostname=$(uname -n)


# Key press repeat timing
xset r rate 250 50

if [ "$hostname" == "lg-gram" ]; then
	# Display scaling
	export GDK_SCALE=2

	# Touchpad acceleration adjustment
	id=$(xinput list | grep -i "Touchpad" | grep -oP 'id=[0-9]*' | sed 's/id=//')
	property=$(xinput list-props "$id" | grep -i 'libinput Accel Speed (' | cut -d "(" -f2 | cut -d ")" -f1)
	accel="0.4"
	xinput set-prop "$id" "$property" "$accel"

	# Wireless mouse sensitivity
	id=$(xinput list | grep -i "MOSART Semi. 2.4G Wireless Mouse Mouse" | grep -oP 'id=[0-9]*' | sed 's/id=//')
	property=$(xinput list-props "$id" | grep -i 'libinput Accel Speed (' | cut -d "(" -f2 | cut -d ")" -f1)
	accel="0.2"
	xinput set-prop "$id" "$property" "$accel"

	# Wireless mouse #2 sensitivity
	id=$(xinput list | grep -i "Logitech MX Anywhere 3" | grep -oP 'id=[0-9]*' | sed 's/id=//')
	property=$(xinput list-props "$id" | grep -i 'libinput Accel Speed (' | cut -d "(" -f2 | cut -d ")" -f1)
	accel="0.35"
	xinput set-prop "$id" "$property" "$accel"

elif [ "$hostname" == "inspiron3537" ]; then
	# Display scaling
	export GDK_SCALE=1

	# Touchpad acceleration adjustment
	id=$(xinput list | grep -i "Touchpad" | grep -oP 'id=[0-9]*' | sed 's/id=//')
	property=$(xinput list-props "$id" | grep -i 'libinput Accel Speed (' | cut -d "(" -f2 | cut -d ")" -f1)
	accel="0.4"
	xinput set-prop "$id" "$property" "$accel"
fi
