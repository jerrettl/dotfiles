#!/bin/bash

hostname=$(uname -n)

if [ "$hostname" == "arch-aspire-d255" ]; then
	numlockx off
else
	numlockx on
fi
