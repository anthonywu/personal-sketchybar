#!/bin/sh

update=$(/opt/homebrew/bin/uv run --with ollama python - <<EOF
import ollama
ps_info = []
for model in ollama.ps()["models"]:
    ps_info.append(f'{model["name"]} {round(model["size"] / (1e9), 1)} GB')
if ps_info:
    print(f'running: {", ".join(ps_info)}')
else:
    print(f'no models running')
EOF
)

sketchybar --set "$NAME" label="$update"
