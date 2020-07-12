#!/bin/bash
# Grabbed from https://github.com/lahwaacz/Scripts/blob/master/toggle-touchpad.sh

device="04CA00A0:00 04CA:00A0 Touchpad"
enabled=$(xinput --list-props "$device" | grep "Device Enabled" | awk '{print $NF}')

if [[ "$enabled" == "1" ]]; then
    xinput --disable "$device"
    echo 0 | sudo tee /sys/devices/platform/lg-laptop/leds/tpad_led/brightness
else
    xinput --enable "$device"
    echo 1 | sudo tee /sys/devices/platform/lg-laptop/leds/tpad_led/brightness
fi
