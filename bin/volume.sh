#!/usr/bin/env bash


wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ $1
wpctl set-mute @DEFAULT_AUDIO_SINK@ 0


VOL_PERCENTAGE=$(
  wpctl get-volume @DEFAULT_AUDIO_SINK@ \
  | awk '{printf("%d\n", $2 * 100 + 0.5)}'
)

notify-send \
    -h string:x-canonical-private-synchronous:sys \
    -h "int:value:$VOL_PERCENTAGE" \
    -a "sys" " Volume Up" "$VOL_PERCENTAGE"
