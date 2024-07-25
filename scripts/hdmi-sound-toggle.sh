#!/bin/bash

export PATH=/usr/bin

USER_NAME=$(who | awk '{print $1}')
USER_ID=$(id -u "$USER_NAME")
CARD_PATH="/sys/class/drm/card0/"
AUDIO_OUTPUT="analog-surround-40"
PULSE_SERVER="unix:/run/user/"$USER_ID"/pulse/native"

for OUTPUT in $(cd "$CARD_PATH" && echo card*); do
  OUT_STATUS=$(<"$CARD_PATH"/"$OUTPUT"/status)
  if [[ $OUT_STATUS == connected ]]
  then
    echo $OUTPUT connected
    case "$OUTPUT" in
      "card0-eDP-1")
        AUDIO_OUTPUT="analog-stereo"
     ;;
      "card0-HDMI-A-1")
        AUDIO_OUTPUT="hdmi-stereo" # Digital Stereo (HDMI 1)
        break
     ;;
      "card0-HDMI-A-2")
        AUDIO_OUTPUT="hdmi-stereo-extra1" # Digital Stereo (HDMI 2)
        break
     ;;
    esac
  fi
done
echo selecting output $AUDIO_OUTPUT
sudo -u "$USER_NAME" pactl --server "$PULSE_SERVER" set-card-profile 47 output:$AUDIO_OUTPUT+input:analog-stereo

