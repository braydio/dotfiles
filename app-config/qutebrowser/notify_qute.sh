#!/usr/bin/env bash

TARGET_WINDOW_TITLE="$1" # e.g. "Arch Linux Assistant - OpenGithubSDK Status Report - qutebrowser"
MESSAGE="$2"             # e.g. "Docs updated for OpenGithubSDK 🚀"

# Find matching window ID using hyprctl
WIN_ID=$(hyprctl clients -j | jq -r \
  --arg title "$TARGET_WINDOW_TITLE" \
  '.[] | select(.title == $title) | .address')

if [[ -z "$WIN_ID" ]]; then
  echo "Window with title '$TARGET_WINDOW_TITLE' not found"
  exit 1
fi

# Focus the window
hyprctl dispatch focuswindow address:"$WIN_ID"

# Send message to qutebrowser via userscript or simulated keystroke (see notes below)
qutebrowser ":message-info '$MESSAGE'"
