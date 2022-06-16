#!/bin/bash

site=$(cat $DOTFILES/notes/websites.txt | rofi -dmenu -p 'Enter a URL' -i -l 10)
if [ "$?" == "0" ]; then MOZ_USE_XINPUT2=1 MOZ_WEBRENDER=1 firefox --new-window $(echo $site | sed "s/\[.*\] //"); fi
