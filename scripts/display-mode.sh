#!/bin/bash

options="primary
secondary
duplicate
mirror
extend top
extend left
extend right
extend bottom"

selection=$(echo "$options" | rofi -dmenu -theme dmenu -p "Display mode:" -i)
if [ "$?" == "1" ]; then exit; fi

if [ "$selection" == "primary" ]; then
  mons -p
elif [ "$selection" == "secondary" ]; then
  mons -s
elif [ "$selection" == "duplicate" ]; then
  mons -d
elif [ "$selection" == "mirror" ]; then
  mons -m
elif [ "$selection" == "extend top" ]; then
  mons -e top
elif [ "$selection" == "extend left" ]; then
  mons -e left
elif [ "$selection" == "extend right" ]; then
  mons -e right
elif [ "$selection" == "extend bottom" ]; then
  mons -e bottom
fi
