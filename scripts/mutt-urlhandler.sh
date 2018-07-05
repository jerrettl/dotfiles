#!/bin/bash

mpv --fs --ytdl-format "bestvideo[height<=?1440][vcodec!=vp9]+bestaudio/best" "$1"
