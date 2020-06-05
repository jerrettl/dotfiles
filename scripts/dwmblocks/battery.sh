#!/bin/bash

acpi -b | awk '{print "BAT " $3 $4" ("$5")"}' | sed 's/,//g' | sed 's/Charging/CHR\ /' | sed 's/Discharging/DIS\ /' | sed -E 's/\ \(discharging\)//' | sed -E 's/\ \(charging\)//' | sed -E 's/([0-9]{0,2}:[0-9]{0,2}):[0-9]{0,2}/\1/'
