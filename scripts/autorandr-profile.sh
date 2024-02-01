#!/bin/bash

options=$(autorandr --list)
current=$(autorandr --current)

selection=$(echo "$options" | rofi -dmenu -theme dmenu -p "Select a profile (current: $current):" -i)
if [ "$?" == "1" ]; then exit; fi

autorandr --load "$selection"
