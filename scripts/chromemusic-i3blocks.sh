#!/bin/bash

song=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.streamkeys /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata 2>/dev/null | grep -A 1 "xesam:title" | grep variant | sed -E 's/^.*"(.*)".*$/\1/')

if [ -z "$song" ]; then
	exit
else
	echo "<span background='#005ab3' color='#ffffff'>  ♫  $song  </span>"
fi
