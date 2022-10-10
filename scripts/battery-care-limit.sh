#!/bin/bash

BATTERY_CARE_FILE="/sys/devices/platform/lg-laptop/battery_care_limit"

if [ "$(id -u)" -ne 0 ]; then
	echo "Please run this script as root."
	exit
fi

if [ ! -f "$BATTERY_CARE_FILE" ]; then
	echo "This device is not compatible with this script."
	exit
fi

if [[ "$1" == "off" || "$1" == "100" ]]; then
	echo 100 > "$BATTERY_CARE_FILE"
else
	echo 80 > "$BATTERY_CARE_FILE"
fi

new_value=$(cat "$BATTERY_CARE_FILE")

echo "New value of battery_care_limit: $new_value"
