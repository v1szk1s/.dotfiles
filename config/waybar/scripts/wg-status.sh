#!/usr/bin/env bash
set -euo pipefail

# 1. Check for any active WireGuard interfaces
#    'ip -o' prints on one line.
#    'awk' grabs the second column (interface name, e.g., "wg0:").
#    'tr -d :' removes the trailing colon.
ACTIVE_INTERFACES=$(ip -o link show type wireguard | awk '{print $2}' | tr -d ':')

if [[ -n "$ACTIVE_INTERFACES" ]]; then
    # --- CONNECTED CASE ---
    
    # Get the first interface name for the bar label (e.g., "wg0")
    FIRST_IFACE=$(echo "$ACTIVE_INTERFACES" | head -n1)
    
    # Format the list of all interfaces for the tooltip (comma separated)
    TOOLTIP_LIST=$(echo "$ACTIVE_INTERFACES" | tr '\n' ',' | sed 's/,$//' | sed 's/,/, /g')

    # Output JSON for Waybar
    jq -cn \
      --arg text "󰖂 $FIRST_IFACE" \
      --arg tooltip "Connected: $TOOLTIP_LIST" \
      --arg class "connected" \
      '{text: $text, tooltip: $tooltip, class: $class, alt: "connected"}'
else
    # --- DISCONNECTED CASE ---
    jq -cn \
      --arg text " 󰒗 " \
      --arg tooltip "WireGuard: Disconnected" \
      --arg class "disconnected" \
      '{text: $text, tooltip: $tooltip, class: $class, alt: "disconnected"}'
fi

