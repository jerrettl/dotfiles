#!/bin/bash

arg=$1

if [ "$arg" != "run" ]; then
  sudo modprobe v4l2loopback exclusive_caps=1
fi

ffmpeg -f x11grab -r 30 -s 1920x1080 -i :0.0+0,0 -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video2
