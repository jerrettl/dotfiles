#!/bin/bash

volume_script="$HOME/dotfiles/scripts/volume.sh"
update="pkill -RTMIN+1 i3blocks"

case "$BLOCK_BUTTON" in
	1) $volume_script toggle ;;
	3) pavucontrol ;;
	4) $volume_script up ;;
	5) $volume_script down ;;
esac

$volume_script level
$update
