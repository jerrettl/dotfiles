#!/bin/bash

# Utilizes processor support for HWP (Hardware P-state).
# https://wiki.archlinux.org/index.php/Power_management#Processors_with_HWP_(Hardware_P-state)_support

# Enables fan silent mode if "power" mode is selected. Disables fan silent mode if any other mode is selected.

arg="$1"
update="pkill -RTMIN+3 i3blocks"

apply_to_conf () {
  if [ "$1" == "power" ] && [ -f /sys/devices/platform/lg-laptop/fan_mode ]; then
    echo 0 | \sudo tee /sys/devices/platform/lg-laptop/fan_mode
  else
    echo 1 | \sudo tee /sys/devices/platform/lg-laptop/fan_mode
  fi

  echo "$1" | awk '{print "w /sys/devices/system/cpu/cpufreq/policy?/energy_performance_preference - - - - " $1}' | \sudo tee /etc/tmpfiles.d/energy_performance_preference.conf
}

if [ "$arg" == "list" ]; then
  cat /sys/devices/system/cpu/cpufreq/policy?/energy_performance_preference
  exit
elif [ "$arg" == "" ]; then
  id=$(i3-msg -t get_tree | jq '.. | .id?, .focused?' | grep -B1 true | head -1)
  selection=$(cat /sys/devices/system/cpu/cpufreq/policy?/energy_performance_available_preferences | tail -n 1 | sed "s/\ /\\n/g" | sed "/^$/d" | rofi -dmenu -theme dmenu -p "")
  if [ "$?" == "0" ]; then
    apply_to_conf $selection
  else
    exit
  fi
else
  apply_to_conf $arg
fi


[ -z "$id" ] || i3-msg focus "[id=$id]"
sudo systemd-tmpfiles --create
cat /sys/devices/system/cpu/cpufreq/policy?/energy_performance_preference
$update
