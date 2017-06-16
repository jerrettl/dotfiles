#!/bin/bash


if [ -n $2 ]
then
	echo 'Viewing '$1' with format '$2
	mpv $(youtube-dl -f $2 -g $1)
fi

if [ -z $2 ]
then
	echo 'Viewing '$1' with format 22'
	mpv $(youtube-dl -f 22 -g $1)
fi
