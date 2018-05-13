#!/bin/bash

hostname=$(uname -n)

if [ "$hostname" == "arch-aspire-d255" ]; then
	exit
elif [ "$hostname" == "dell-xps400" ]; then
	exit
else
	compton &
fi
