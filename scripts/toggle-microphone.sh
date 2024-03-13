#!/bin/bash

# Basic script that toggles the mute status of a hard-coded microphone name.

mic_name="HiFi__Mic1__source"
pactl set-source-mute "$(pactl list short sources | grep "$mic_name" | cut -f1)" toggle
