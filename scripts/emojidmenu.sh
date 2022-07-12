#!/bin/bash

# Adapted from Luke Smith.

# Get user selection via dmenu from emoji file.
chosen=$(cat $DOTFILES/notes/emoji.txt | rofi -dmenu -theme large-font -p "" | cut -d ' ' -f1 | sed 's/ .*//')

# Exit if none chosen.
[ -z "$chosen" ] && exit

# If you run this command with an argument, it will automatically insert the
# character. Otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
	xdotool type "$chosen"
else
	echo "$chosen" | tr -d '\n' | xclip -selection clipboard
	notify-send "'$chosen' copied to clipboard." &
fi
