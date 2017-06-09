#!/bin/bash


echo 'Viewing '$1' with format '$2
mpv $(youtube-dl -f $2 -g $1)
