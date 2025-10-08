#!/bin/sh

case "$1" in
    *.png|*.jpg|*.jpeg|*.gif|*.bmp|*.webp)
        # Kill old imv if running
        pkill -9 imv 2>/dev/null
        # Open the image in a new imv window
        imv "$1" &
        ;;
esac
