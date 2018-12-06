#!/bin/bash

currently=$(nmcli networking)

if [ "$currently" == "disabled" ]; then
	nmcli networking on
elif [ "$currently" == "enabled" ]; then
	nmcli networking off
fi

notify-send "Networking has been $(nmcli networking)."
