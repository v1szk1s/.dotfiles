#!/usr/bin/env bash

wpctl set-volume @DEFAULT_AUDIO_SINK@ $1

VOL_PERCENTAGE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')

notify-send \
    -h string:x-canonical-private-synchronous:sys \
    -h "int:value:$VOL_PERCENTAGE" \
    -a "sys" " Volume Up" "$VOL_PERCENTAGE"
