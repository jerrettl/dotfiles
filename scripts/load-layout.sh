#!/bin/bash

. ~/dotfiles/aliases/aliases

selection=$(cat ~/dotfiles/scripts/layout-list | dmenu -nb "#303030" -nf "#ffffff" -sb "#ffffff" -sf "#303030" -fn "HelveticaNeue-11" -p "Select a layout:" -l 15 -i)
if [ "$?" == "1" ]; then exit; fi

workspace=$(echo "this" | dmenu -nb "#303030" -nf "#ffffff" -sb "#ffffff" -sf "#303030" -fn "HelveticaNeue-11" -p "What workspace would you like to place it on?")
if [ "$?" == "1" ]; then exit; fi


if [ "$workspace" != "this" ]; then
  i3-msg "workspace $workspace"
fi

if [ "$selection" == "School" ]; then
  # i3-msg "layout default"
  firefox https://keep.google.com/u/0 https://gmail.com https://outlook.office.com/mail/inbox https://webcourses.ucf.edu &
elif [ "$selection" == "Watch TV" ]; then
  i3-msg "layout tabbed"
  firefox http://trakt.tv/dashboard &
  $TERMINAL -e ranger /mnt/shared/saved-tv &
fi
