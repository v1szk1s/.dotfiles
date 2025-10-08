#!/usr/bin/env bash


brightnessctl set $1

BR_PERCENTAGE=$(brightnessctl | grep Current | cut -d\( -f2 | cut -d% -f1)

notify-send \
    -h string:x-canonical-private-synchronous:sys \
    -h "int:value:$BR_PERCENTAGE" \
    -a "sys" " Brightness Up" "$BR_PERCENTAGE"
