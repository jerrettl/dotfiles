#!/bin/bash

hostname=$(uname -n)

if [ "$hostname" == "lg-gram" ]; then
	export GDK_SCALE=2
fi
