#!/bin/bash

WALLPAPER_DIR=~/Pictures/wallpaper
WALL_CACHE="$HOME/.cache/current_wallpaper.txt"

CURRENT_WALL=$(cat "$WALL_CACHE")

if [ -z "$CURRENT_WALL" ]; then # -z returns true if string is null
  # grep → finds all lines containing "wallpaper"
  # awk  → extracts the second part after the comma (the path)
  # xargs basename → passes each path to basename to get just the filename
  CURRENT_WALL=$(grep 'wallpaper' ~/.config/hypr/hyprpaper.conf | awk -F',' '{print $2}' | xargs -r basename)
fi

WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
while [ "$WALLPAPER" == "$CURRENT_WALL" ]; do
  WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
done

echo "$WALLPAPER" >"$HOME/.cache/current_wallpaper.txt"

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper "eDP-1, $WALLPAPER"

hyprctl hyprpaper unload unused
