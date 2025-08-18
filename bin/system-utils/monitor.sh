#!/bin/bash

# Define the menu options
OPTIONS="Extend\nMirror\nPrimary Only\nSecondary Only"

# Get the connected monitors
# PRIMARY=$(xrandr | grep " connected" | awk 'NR==1{print $1}')
# SECONDARY=$(xrandr | grep " connected" | awk 'NR==2{print $1}')

# If there are no two connected monitors, exit
# if [ -z "$SECONDARY" ]; then
#     echo "Only one monitor detected."
#     notify-send "Only one monitor detected."
#     exit 1
# fi

# Show the menu
CHOICE=$(echo -e "$OPTIONS" | bemenu -l 4 -i -p "Select Display Confdiguration:")

# Apply the chosen configuration
case $CHOICE in
    "Extend")
        hyprctl keyword monitor "eDP-1,preferred,0x0,1"
        hyprctl keyword monitor "HDMI-A-1,preferred,1920x0,1"
        # xrandr --output "$PRIMARY" --auto --primary --output "$SECONDARY" --auto --right-of "$PRIMARY"
        ;;
    "Mirror")
        hyprctl keyword monitor "eDP-1,preferred,0x0,1"
        hyprctl keyword monitor "HDMI-A-1,preferred,0x0,1,mirror,eDP-1"
        # xrandr --output "$PRIMARY" --auto --primary --output "$SECONDARY" --auto --same-as "$PRIMARY"
        ;;
    "Primary Only")
        hyprctl keyword monitor "eDP-1,preferred,0x0,1"
        hyprctl keyword monitor "HDMI-A-1,disable"
        # xrandr --output "$PRIMARY" --auto --primary --output "$SECONDARY" --off
        ;;
    "Secondary Only")
        hyprctl keyword monitor "eDP-1,disable"
        hyprctl keyword monitor "HDMI-A-1,preferred,0x0,1"
        # xrandr --output "$SECONDARY" --auto --primary --output "$PRIMARY" --off
        ;;
    *)
        echo "No valid option selected."
        notify-send "No valid option selected."
        exit 1
        ;;
esac

