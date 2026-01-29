#!/usr/bin/env bash
set -euo pipefail

# 1. Get current default sink name
DEFAULT_SINK=$(pactl get-default-sink)

# 2. Get list of sinks
# We parsing 'pactl -f json list sinks' which is structured and stable.
# We create a list formatted as: "Name | Description | [Active]"
MENU_ITEMS=$(pactl -f json list sinks | jq -r --arg def "$DEFAULT_SINK" '.[] | 
    (.name) + "\t" + 
    (.description) + 
    (if .name == $def then "  [ACTIVE]" else "" end)'
)

if [ -z "$MENU_ITEMS" ]; then
    notify-send "Audio Menu" "No output devices found."
    exit 1
fi

# 3. Open Walker
# We display the Description (2nd field) to the user, but pass the full line
# delimiter is tab (\t)
SELECTED=$(echo "$MENU_ITEMS" | awk -F'\t' '{printf "%-50s\t%s\n", $2, $3}' | walker --dmenu --placeholder "Select Audio Output")

if [ -n "$SELECTED" ]; then
    # 4. Find the matching real name
    # We grep the original MENU_ITEMS using the selected description to find the internal name.
    # The walker output is "Description [ACTIVE]". We strip the [ACTIVE] part to match.
    SELECTED_DESC=$(echo "$SELECTED" | sed 's/  \[ACTIVE\]$//' | sed 's/[[:space:]]*$//')
    
    # Extract the technical name (first field) from the original list where the description matches
    SINK_NAME=$(echo "$MENU_ITEMS" | grep -F "$SELECTED_DESC" | awk -F'\t' '{print $1}' | head -n1)

    if [ -n "$SINK_NAME" ]; then
        # 5. Set the default sink
        pactl set-default-sink "$SINK_NAME"

        # Optional: Move currently playing streams to the new sink
        # This ensures music/video switches immediately
        pactl list short sink-inputs | cut -f1 | while read -r stream; do
            pactl move-sink-input "$stream" "$SINK_NAME"
        done

        notify-send -u low "Audio Changed" "Output: $SELECTED_DESC"
    else
        notify-send -u critical "Audio Error" "Could not resolve sink name."
    fi
fi
