#!/bin/sh

if [ "$(pidof pianobar)" ]
then
	cat ~/.config/pianobar/nowplaying
else
	echo ""
fi

