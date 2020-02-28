#!/bin/bash

. ~/dotfiles/aliases/aliases

selection=$(cat ~/dotfiles/scripts/layout-list | dmenu -nb "#303030" -nf "#ffffff" -sb "#ffffff" -sf "#303030" -fn "HelveticaNeue-11" -p "Select a layout:" -l 15 -i)
if [ "$?" == "1" ]; then exit; fi

workspace=$(echo | dmenu -nb "#303030" -nf "#ffffff" -sb "#ffffff" -sf "#303030" -fn "HelveticaNeue-11" -p "What workspace would you like to place it on?")
if [ "$?" == "1" ]; then exit; fi

if [ "$selection" == "World History Outlining" ]; then
  i3-msg "workspace $workspace; append_layout ~/dotfiles/scripts/layouts/woh_layout.json"
  zathura -c ~/dotfiles/.config/zathura/nogui /mnt/shared/School/Textbooks/Robert\ W.\ Strayer\,\ Eric\ W.\ Nelson\ -\ Ways\ of\ the\ World_\ A\ Brief\ Global\ History\ with\ Sources\,\ Combined\ Volume-Bedford_St.\ Martin’s\ \(2015\).pdf &
  #urxvt -e ranger /mnt/shared/School/woh-2012/Notes/ &
  emacs /mnt/shared/School/woh-2012/Notes/ &
elif [ "$selection" == "Watch TV" ]; then
  i3-msg "workspace $workspace; layout tabbed"
  chromium --new-window http://trakt.tv/dashboard &
  urxvt -e ranger /mnt/shared/saved-tv &
fi
