#!/bin/bash

# Define the menu options
OPTIONS="Extend\nMirror\nPrimary Only\nSecondary Only"

# Get the connected monitors
PRIMARY=$(xrandr | grep " connected" | awk 'NR==1{print $1}')
SECONDARY=$(xrandr | grep " connected" | awk 'NR==2{print $1}')

# If there are no two connected monitors, exit
if [ -z "$SECONDARY" ]; then
    echo "Only one monitor detected."
    exit 1
fi

# Show the menu
CHOICE=$(echo -e "$OPTIONS" | dmenu -l 4 -i -p "Select Display Configuration:")

# Apply the chosen configuration
case $CHOICE in
    Extend)
        xrandr --output "$PRIMARY" --auto --primary --output "$SECONDARY" --auto --right-of "$PRIMARY"
        ;;
    Mirror)
        xrandr --output "$PRIMARY" --auto --primary --output "$SECONDARY" --auto --same-as "$PRIMARY"
        ;;
    "Primary Only")
        xrandr --output "$PRIMARY" --auto --primary --output "$SECONDARY" --off
        ;;
    "Secondary Only")
        xrandr --output "$SECONDARY" --auto --primary --output "$PRIMARY" --off
        ;;
    *)
        echo "No valid option selected."
        exit 1
        ;;
esac

