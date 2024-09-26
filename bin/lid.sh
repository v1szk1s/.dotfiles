#!/bin/bash

INTERNAL_DISPLAY="DP-2"  # Replace with your actual laptop screen name (use `xrandr` to find it)
EXTERNAL_DISPLAY=$(xrandr | grep " connected" | grep -v "$INTERNAL_DISPLAY" | awk '{ print $1 }')

if grep -q closed /proc/acpi/button/lid/LID/state; then
    if [ -n "$EXTERNAL_DISPLAY" ]; then
        # Disable the internal display and set external display as primary
        xrandr --output "$INTERNAL_DISPLAY" --off --output "$EXTERNAL_DISPLAY" --auto
    fi
else
    # Lid is open, enable internal display
    xrandr --output "$INTERNAL_DISPLAY" --auto --primary
    if [ -n "$EXTERNAL_DISPLAY" ]; then
        xrandr --output "$EXTERNAL_DISPLAY" --auto --right-of "$INTERNAL_DISPLAY"
    fi
fi

