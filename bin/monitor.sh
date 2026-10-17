#!/usr/bin/env bash

set -euo pipefail

INTERNAL_MONITOR=$(hyprctl monitors all -j | jq -r '.[] | select(.id == 0) | .name')
EXTERNAL_MONITOR=$(hyprctl monitors all -j | jq -r '.[] | select(.id == 1) | .name')
# EXTERNAL_MONITOR="DP-1"

printf 'INTERNAL_MONITOR=%q\n' "$INTERNAL_MONITOR"
printf 'EXTERNAL_MONITOR=%q\n' "$EXTERNAL_MONITOR"

MENU=$'Internal only\nExternal only\nExtend up\nExtend left\nExtend right'

choice="$(printf '%s\n' "$MENU" | walker --dmenu -p 'Displays:' )"

case "$choice" in
  "Internal only")
    echo "Internal only"
    hyprctl eval "hl.monitor({
      output = \"$INTERNAL_MONITOR\",
      disabled = false,
    })" && \
    hyprctl eval "hl.monitor({
      output = \"$EXTERNAL_MONITOR\",
      disabled = true,
    })"

    # sleep 2
    # hyprctl dispatch 'require("plugins.split-monitor-workspaces").grab_rogue_windows()'
    ;;
  "External only")
    echo "External only"
    killall qs

    hyprctl eval "hl.monitor({
      output = \"$EXTERNAL_MONITOR\",
      disabled = false,
    })" && \
    hyprctl eval "hl.monitor({
      output = \"$INTERNAL_MONITOR\",
      disabled = true,
    })"

    ;;
  "Extend up")
    hyprctl eval "hl.monitor({
      output = \"$INTERNAL_MONITOR\",
      disabled = false,
    })"

    hyprctl eval "hl.monitor({
      output = \"$EXTERNAL_MONITOR\",
      mode = \"preferred\",
      position = \"auto-up\",
      disabled = false,
    })"
    ;;
  "Extend left")
    hyprctl eval "hl.monitor({
      output = \"$INTERNAL_MONITOR\",
      disabled = false,
    })"
    hyprctl eval "hl.monitor({
      output = \"$EXTERNAL_MONITOR\",
      position = \"auto-left\",
      disabled = false,
    })"
    ;;
  "Extend right")
    hyprctl eval "hl.monitor({
      output = \"$INTERNAL_MONITOR\",
      disabled = false,
    })"
    hyprctl eval "hl.monitor({
      output = \"$EXTERNAL_MONITOR\",
      position = \"auto-right\",
      disabled = false,
    })"
    ;;
  "" )
    exit 0
    ;;
  * )
    echo "Unknown selection: $choice" >&2
    exit 1
    ;;
esac

sleep 1
hyprctl dispatch 'require("plugins.split-monitor-workspaces").grab_rogue_windows()'
