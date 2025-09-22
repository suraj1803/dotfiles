#!/bin/bash

CONFIG_FILE="$(pwd)/config.jsonc"
STYLE_FILE="$(pwd)/style.css"

if ! command -v inotifywait >/dev/null 2>&1; then
  echo "Error: inotifywait not found. Please install inotify-tools."
  exit 1
fi

if [[ ! -f "$CONFIG_FILE" || ! -f "$STYLE_FILE" ]]; then
  echo "Error: Config or style file not found."
  exit 1
fi

echo "Monitoring Waybar config and style files for changes..."

inotifywait -m "$CONFIG_FILE" "$STYLE_FILE" -e modify |
while read -r path _; do
  echo "Change detected in $path. Reloading Waybar..."
  pkill -x waybar
  waybar -c $CONFIG_FILE -s $STYLE_FILE &
  echo "Waybar reloaded."
done