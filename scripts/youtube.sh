#!/bin/bash


if [ ! -f "$2" ]; then
	format="22"
else
	format="$2"
fi

echo 'Viewing '$1' with format '$format
mpv $(youtube-dl -f $format -g $1)

