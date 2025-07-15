#!/bin/bash

# get list of profiles
PROFILE_LIST=$(gsettings get org.gnome.Terminal.ProfilesList list)

# new UUID
NEW_UUID=$(uuidgen)

# Add UUID to the list
NEW_LIST=$(echo "$PROFILE_LIST" | sed "s/]$/, '$NEW_UUID']/")
gsettings set org.gnome.Terminal.ProfilesList list "$NEW_LIST"

# new profile with the default
DEFAULT=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
BASE_PATH="/org/gnome/terminal/legacy/profiles:/:$DEFAULT/"
NEW_PATH="/org/gnome/terminal/legacy/profiles:/:$NEW_UUID/"

# Name and colors
gsettings set org.gnome.Terminal.Legacy.Profile:/$NEW_PATH visible-name 'xtropicalneon'
gsettings set org.gnome.Terminal.Legacy.Profile:/$NEW_PATH use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/$NEW_PATH background-color '#000000'
gsettings set org.gnome.Terminal.Legacy.Profile:/$NEW_PATH foreground-color '#ffffff'
gsettings set org.gnome.Terminal.Legacy.Profile:/$NEW_PATH palette "['#000000', '#ff5151', '#00ff87', '#ffe600', '#00b7ff', '#d99dff', '#00ffd1', '#ffffff', '#111111', '#ff8787', '#50fa7b', '#ffffa5', '#79d9ff', '#ff00a8', '#41b3ff', '#ffffff']"
