update=$(tailscale ip -4)

if [ -n "$update" ]; then
    sketchybar --set "$NAME" label="$update"
else
    sketchybar --set "$NAME" label="tailscale off"
fi
