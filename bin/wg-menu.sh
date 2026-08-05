#!/bin/bash

# 1. Get list of interfaces (strip path and .conf extension)
#    We check /etc/wireguard for any .conf files.
INTERFACES=$(ls /etc/wireguard/*.conf 2>/dev/null | xargs -n 1 basename | sed 's/\.conf$//')

if [ -z "$INTERFACES" ]; then
    notify-send "WireGuard" "No config files found in /etc/wireguard."
    exit 1
fi

# 2. Mark active interfaces in the menu list
#    We loop through the interfaces and add a marker (e.g., "[ON]") if they are active.
MENU_ITEMS=""
for iface in $INTERFACES; do
    if ip link show "$iface" >/dev/null 2>&1; then
        MENU_ITEMS+="$iface  [CONNECTED]\n"
    else
        MENU_ITEMS+="$iface\n"
    fi
done

# 3. Pipe to walker
#    -e enables interpretation of backslash escapes (newline)
SELECTED_LINE=$(echo -e "$MENU_ITEMS" | walker --dmenu --placeholder "Toggle WireGuard Interface")

if [ -n "$SELECTED_LINE" ]; then
    # Extract just the interface name (remove the "  [CONNECTED]" part if present)
    SELECTED=$(echo "$SELECTED_LINE" | awk '{print $1}')

    # 4. Toggle logic
    if ip link show "$SELECTED" >/dev/null 2>&1; then
        # Interface exists -> Disconnect
        sudo wg-quick down "$SELECTED"
        if [ $? -eq 0 ]; then
            notify-send "WireGuard" "Disconnected $SELECTED"
        else
            notify-send -u critical "WireGuard" "Failed to disconnect $SELECTED"
        fi
    else
        # Interface does not exist -> Connect
        sudo wg-quick up "$SELECTED"
        if [ $? -eq 0 ]; then
            notify-send "WireGuard" "Connected to $SELECTED"
        else
            notify-send -u critical "WireGuard" "Failed to connect to $SELECTED"
        fi
    fi
fi
