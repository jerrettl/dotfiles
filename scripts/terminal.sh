#!/bin/bash

hostname=$(uname -n)

if [ "$hostname" == "arch-aspire-d255" ]; then
	urxvt --meta8
else
	kitty
fi
