#!/bin/bash

# Utilizes processor support for HWP (Hardware P-state).
# https://wiki.archlinux.org/index.php/Power_management#Processors_with_HWP_(Hardware_P-state)_support

arg="$1"

apply_to_conf () {
    echo "$1" | awk '{print "w /sys/devices/system/cpu/cpufreq/policy?/energy_performance_preference - - - - " $1}' | sudo tee /etc/tmpfiles.d/energy_performance_preference.conf
}

if [ "$arg" == "list" ]; then
  cat /sys/devices/system/cpu/cpufreq/policy?/energy_performance_preference
  exit
elif [ "$arg" == "" ]; then
  selection=$(cat /sys/devices/system/cpu/cpufreq/policy?/energy_performance_available_preferences | tail -n 1 | sed "s/\ /\\n/g" | sed "/^$/d" | dmenu)
  if [ "$?" == "0" ]; then
    apply_to_conf $selection
  else
    exit
  fi
else
  apply_to_conf $arg
fi

sudo systemd-tmpfiles --create
cat /sys/devices/system/cpu/cpufreq/policy?/energy_performance_preference
