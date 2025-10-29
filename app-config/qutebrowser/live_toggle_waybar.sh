#!/bin/bash
echo "SETUP THEMES BEFORE RUNNING THIS SON"

current=$(cat ~/.cache/waybar_theme 2>/dev/null || echo "mocha")

if [[ "$current" == "mocha" ]]; then
  cp ~/.config/waybar/style-latte.css ~/.config/waybar/style.css
  echo "latte" >~/.cache/waybar_theme
else
  cp ~/.config/waybar/style-mocha.css ~/.config/waybar/style.css
  echo "mocha" >~/.cache/waybar_theme
fi

pkill -SIGUSR2 waybar
