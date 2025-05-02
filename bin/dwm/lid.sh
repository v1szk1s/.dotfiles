#!/bin/bash

export DISPLAY=:1
export XAUTHORITY=/home/v1szk1s/.Xauthority

INTERNAL_DISPLAY="DP-2"  # Replace with your actual laptop screen name (use `xrandr` to find it)
# EXTERNAL_DISPLAY=HDMI-0" #$(xrandr | grep " connected" | grep -v "$INTERNAL_DISPLAY" | awk '{ print $1 }')
EXTERNAL_DISPLAY=$(xrandr | grep " connected" | grep -v "$INTERNAL_DISPLAY" | awk '{ print $1 }')

echo $(whoami)

if grep -q closed /proc/acpi/button/lid/LID0/state; then
    # Lid is closed
    if [ -n "$EXTERNAL_DISPLAY" ]; then
        # Disable the internal display and set external display as primary
        xrandr --output "$INTERNAL_DISPLAY" --off --output "$EXTERNAL_DISPLAY" --auto --primary
	else
		setxkbmap us
		slock -m "Locked"
    fi
else
#     # Lid is open, enable internal display
		# echo "open from script"
    xrandr --output "$INTERNAL_DISPLAY" --auto
    if [ -n "$EXTERNAL_DISPLAY" ]; then
        xrandr --output "$EXTERNAL_DISPLAY" --auto --primary --above "$INTERNAL_DISPLAY"
    fi
fi

