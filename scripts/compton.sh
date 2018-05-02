#!/bin/bash

hostname=$(uname -n)

if [ "$hostname" == "arch-aspire-d255" ]; then
	exit
else
	compton &
fi
