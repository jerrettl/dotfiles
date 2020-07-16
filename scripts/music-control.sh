#!/bin/sh

MODE=$(cat ~/.musicmode)
COMMAND="$1"

if [ "$MODE" = "pianobar" ]; then
	if [ "$COMMAND" = "playpause" ]; then
		echo -n 'p' > ~/.config/pianobar/ctl

	elif [ "$COMMAND" = "next" ]; then
		echo -n 'n' > ~/.config/pianobar/ctl
	fi


elif [ "$MODE" = "spotify" ]; then
	if [ "$COMMAND" = "playpause" ]; then
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause

	elif [ "$COMMAND" = "next" ]; then
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next

	elif [ "$COMMAND" = "back" ]; then
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
	fi

#bindsym XF86AudioStop exec "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop"

elif [ "$MODE" = "chrome" ]; then
	# We can use the Chrome extension StreamKeys to communicate to a currently
	# playing song using dbus
	if [ "$COMMAND" = "playpause" ]; then
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.streamkeys /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause

	elif [ "$COMMAND" = "next" ]; then
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.streamkeys /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next

	elif [ "$COMMAND" = "back" ]; then
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2.streamkeys /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
	fi

elif [ "$MODE" = "firefox" ]; then
	player=$(playerctl -l | grep -i firefox)
	if [ "$COMMAND" = "playpause" ]; then
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2."$player" /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause

	elif [ "$COMMAND" = "next" ]; then
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2."$player" /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next

	elif [ "$COMMAND" = "back" ]; then
		dbus-send --print-reply --dest=org.mpris.MediaPlayer2."$player" /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
	fi
fi
