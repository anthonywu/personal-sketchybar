#!/bin/bash

weather_info=$(curl -s 'https://wttr.in/San+Francisco?format=+%m+%c+%t+☀️%u')

sketchybar --set "$NAME" icon="" label="$weather_info"
