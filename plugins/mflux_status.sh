#!/bin/bash

ps_result=$(ps -ef | grep '[b]in/mflux-generate')
if [ $? -eq 0 ]; then
    output_filename=$(sed -n 's|.*--output \([^ ]*\).*|\1|p' <(echo "$ps_result"))
    if [ -n "$output_filename" ]; then
        label="mflux is rendering $output_filename"
    else
        label="mflux is rendering"
    fi
    sketchybar --set "$NAME" icon="􀲲" label="$label"
else
    sketchybar --set "$NAME" icon="" label="􀜚"
fi
