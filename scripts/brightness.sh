#!/bin/bash

MODE_XBACKLIGHT=0
MODE_MANUAL=0

brightness_up() {
	if [[ "$1" == "more" ]]; then
		step_size=10
	else
		step_size=2
	fi

	if [[ "$MODE_XBACKLIGHT" -eq 1 ]]; then
		xbacklight -inc "$step_size"
	elif [[ "$MODE_MANUAL" -eq 1 ]]; then
		current_brightness=$(cat "$BACKLIGHT_PATH/brightness")
		max_brightness=$(cat "$BACKLIGHT_PATH/max_brightness")
		echo "[INFO] Current brightness: $current_brightness/$max_brightness"
		step=$(( $step_size * $max_brightness / 100 ))
		echo "[INFO] Using step size of $step."
		new_brightness=$(( $current_brightness + $step ))
		if [[ $new_brightness -gt $max_brightness ]]; then
			new_brightness=$max_brightness
		fi
		echo "[INFO] New brightness: $new_brightness"

		echo "$new_brightness" | \sudo tee "$BACKLIGHT_PATH/brightness"
	fi
}


brightness_down() {
	if [[ "$1" == "more" ]]; then
		step_size=10
	else
		step_size=2
	fi

	if [[ "$MODE_XBACKLIGHT" -eq 1 ]]; then
		xbacklight -dec "$step_size"
	elif [[ "$MODE_MANUAL" -eq 1 ]]; then
		current_brightness=$(cat "$BACKLIGHT_PATH/brightness")
		max_brightness=$(cat "$BACKLIGHT_PATH/max_brightness")
		echo "[INFO] Current brightness: $current_brightness/$max_brightness"
		step=$(( $step_size * $max_brightness / 100 ))
		echo "[INFO] Using step size of $step."
		new_brightness=$(( $current_brightness - $step ))
		if [[ $new_brightness -lt 0 ]]; then
			new_brightness=0
		fi
		echo "[INFO] New brightness: $new_brightness"

		echo "$new_brightness" | \sudo tee "$BACKLIGHT_PATH/brightness"
	fi
}

if command xbacklight &> /dev/null; then
	echo "[INFO] xbacklight detected."
	MODE_XBACKLIGHT=1
else
	echo "[INFO] xbacklight not detected. Using manual approach."
	MODE_MANUAL=1

	# Find the backlight device.
	BACKLIGHT_PATH=$(find /sys/class/backlight/* | head -n 1)
	echo "[INFO] Using the backlight path: $BACKLIGHT_PATH"
fi

case "$1" in
	up) brightness_up ;;
	upmore) brightness_up more ;;
	down) brightness_down ;;
	downmore) brightness_down more ;;
esac

