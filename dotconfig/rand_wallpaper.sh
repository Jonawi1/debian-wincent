#!/bin/bash

# Specify the path to your wallpaper directory
wallpaper_dir="$HOME/pictures/backgrounds"

# Check if the directory exists
if [ ! -d "$wallpaper_dir" ]; then
    echo "Error: Wallpaper directory not found."
    exit 1
fi

# Get a list of all files in the directory
wallpapers=("$wallpaper_dir"/*)

# Check if there are wallpapers in the directory
if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "Error: No wallpapers found in the directory."
    exit 1
fi

# Get a random index within the range of wallpapers array
random_index=$((RANDOM % ${#wallpapers[@]}))

# Select a random wallpaper
random_wallpaper="${wallpapers[$random_index]}"

# Set wallpaper
#$HOME/.local/bin/wal -i $random_wallpaper
feh --bg-fill $random_wallpaper
