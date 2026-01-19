#!/usr/bin/env bash


SINK="@DEFAULT_AUDIO_SINK@"

# Toggle mute
wpctl set-mute "$SINK" toggle

# Get current status line, e.g. "Volume: 0.37 [MUTED]" or "Volume: 0.37"
STATUS="$(wpctl get-volume "$SINK")"

# Extract numeric value (float) and multiply by 100
VOL_PERCENTAGE=$(awk '{print int($2 * 100)}' <<< "$STATUS")

# Check if muted
if [[ "$STATUS" == *"[MUTED]"* ]]; then
    ICON=""
    TITLE="Volume"
    MESSAGE="Muted"
    VALUE_HINT=0
else
    ICON=""
    TITLE="Volume"
    MESSAGE="${VOL_PERCENTAGE}%"
    VALUE_HINT=$VOL_PERCENTAGE
fi

# Send unified notification (won’t stack)
notify-send \
    -h string:x-canonical-private-synchronous:sys \
    -h "int:value:$VALUE_HINT" \
    -a "sys" "$ICON $TITLE" "$MESSAGE"

# wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
#
# VOL_PERCENTAGE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
#
# notify-send \
#     -h string:x-canonical-private-synchronous:sys-brightness \
#     -h "int:value:$VOL_PERCENTAGE" \
#     -a "sys" " Volume Up" "$VOL_PERCENTAGE"
