#!/usr/bin/env bash
set -euo pipefail

theme=${1:-}
if [[ $theme != "dark" && $theme != "light" ]]; then
  echo "Usage: ${0##*/} {dark|light}" >&2
  exit 1
fi

HYPR_DIR="$HOME/.config/hypr"
THEME_DIR="$HYPR_DIR/themes/$theme"
WAYBAR_DIR="$HYPR_DIR/waybar"

ln -sfn "$THEME_DIR/hypr-colors.conf" "$HYPR_DIR/colors.conf"
ln -sfn "$THEME_DIR/waybar-colors.css" "$WAYBAR_DIR/way_colors.css"

# Reload Hyprland and ask Waybar to refresh its CSS.
if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload >/dev/null 2>&1 || true
fi

if pgrep -x waybar >/dev/null 2>&1; then
  pkill -SIGUSR2 waybar || true
fi

echo "Applied $theme theme."
