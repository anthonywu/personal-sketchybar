if ps -ef | grep '[b]in/mflux-generate'; then
    sketchybar --set "$NAME" icon="􀲲" label="mflux is rendering"
else
    sketchybar --set "$NAME" icon="" label=""
fi
