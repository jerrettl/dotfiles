#!/bin/bash

song=$(playerctl -p firefox metadata title | sed -E 's/&/&amp;/g')

if [ -z "$song" ]; then
	exit
else
	echo "<span background='#005ab3' color='#ffffff'>  ♫  $song  </span>"
fi
