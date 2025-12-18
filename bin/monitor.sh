#!/usr/bin/env bash
set -euo pipefail

# Change these to match `hyprctl monitors`
INTERNAL="eDP-1"
EXTERNAL="HDMI-A-1"

# Optionally set your preferred modes
INTERNAL_MODE="preferred"
EXTERNAL_MODE="preferred"

# Walker dmenu: read newline-separated items from stdin, output selection. [web:60]
MENU=$'Primary only\nSecondary only\nExtend right\nExtend left'

choice="$(printf '%s\n' "$MENU" | walker --dmenu -p 'Displays:' )"  # -p sets placeholder text. [web:60]
# If you run walker as a service, consider adding: --exit (only when using service). [web:60]

case "$choice" in
  "Primary only")
    hyprctl keyword monitor "$INTERNAL,$INTERNAL_MODE,0x0,2"
    hyprctl keyword monitor "$EXTERNAL,disable"
    ;;
  "Secondary only")
    hyprctl keyword monitor "$INTERNAL,disable"
    hyprctl keyword monitor "$EXTERNAL,$EXTERNAL_MODE,0x0,1"
    ;;
  "Extend right")
    hyprctl keyword monitor "$INTERNAL,$INTERNAL_MODE,0x0,2"
    hyprctl keyword monitor "$EXTERNAL,$EXTERNAL_MODE,auto-right,1"
    ;;
  "Extend left")
    hyprctl keyword monitor "$INTERNAL,$INTERNAL_MODE,0x0,2"
    hyprctl keyword monitor "$EXTERNAL,$EXTERNAL_MODE,auto-left,1"
    ;;
  "" )
    # cancelled / ESC
    exit 0
    ;;
  * )
    echo "Unknown selection: $choice" >&2
    exit 1
    ;;
esac
