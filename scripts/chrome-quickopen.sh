#!/bin/bash

site=$(cat ~/dotfiles/websites.txt | dmenu -p 'Enter a URL:' -i -l 10)
if [ "$?" == "0" ]; then chromium $site; fi
