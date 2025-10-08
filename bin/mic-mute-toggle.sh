#!/usr/bin/env bash

SINK="@DEFAULT_AUDIO_SOURCE@"

# Toggle mic mute
wpctl set-mute "$SINK" toggle

# Get current status, e.g. "Volume: 0.75 [MUTED]" or "Volume: 0.75"
STATUS="$(wpctl get-volume "$SINK")"

# Extract numeric value and convert to percentage
VOL_PERCENTAGE=$(awk '{print int($2 * 100)}' <<< "$STATUS")

# Check mute state
if [[ "$STATUS" == *"[MUTED]"* ]]; then
    ICON=""  # muted mic
    TITLE="Microphone"
    MESSAGE="Muted"
    VALUE_HINT=0
else
    ICON=""  # active mic
    TITLE="Microphone"
    MESSAGE="${VOL_PERCENTAGE}%"
    VALUE_HINT=$VOL_PERCENTAGE
fi

# Send unified notification
notify-send \
    -h string:x-canonical-private-synchronous:sys \
    -h "int:value:$VALUE_HINT" \
    -a "sys" "$ICON $TITLE" "$MESSAGE"
