#!/bin/bash

# Adapted from Luke Smith.

# Get user selection via dmenu from emoji file.
chosen=$(cut -d ';' -f1 $DOTFILES/notes/emoji.txt | dmenu -i -l 30 -nb "#303030" -nf "#ffffff" -sb "#ffffff" -sf "#303030" -fn "Symbola-16" | sed "s/ .*//")

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
