#!/usr/bin/env bash

# Init wallpaper
swww init &

# Set wallpaper
swww img ~/Pictures/fantasy_landscape.jpg &

# Network manager
nm-applet --indicator &

# The bar
waybar &

# Notifications
dunst