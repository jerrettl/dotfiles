#!/bin/bash

. ~/dotfiles/aliases/aliases

selection=$(cat ~/dotfiles/scripts/layout-list | dmenu -nb "#303030" -nf "#ffffff" -sb "#ffffff" -sf "#303030" -fn "HelveticaNeue-11" -p "Select a layout:" -l 15 -i)
if [ "$?" == "1" ]; then exit; fi

workspace=$(echo | dmenu -nb "#303030" -nf "#ffffff" -sb "#ffffff" -sf "#303030" -fn "HelveticaNeue-11" -p "What workspace would you like to place it on?")
if [ "$?" == "1" ]; then exit; fi

if [ "$selection" == "Watch TV" ]; then
  i3-msg "workspace $workspace; layout tabbed"
  chromium --new-window http://trakt.tv/dashboard &
  urxvt -e ranger /mnt/shared/saved-tv &
fi
