#!/usr/bin/env bash
set -euo pipefail

echo "== Hyprland =="
if command -v hyprctl >/dev/null 2>&1; then
  hyprctl version || true
else
  echo "hyprctl not found in PATH" >&2
fi

LOG_HYPR="$HOME/.local/share/hyprland/hyprland.log"
if [[ -f "$LOG_HYPR" ]]; then
  echo "-- recent hyprland.log (last 200 lines) --"
  tail -n 200 "$LOG_HYPR" | sed -e 's/^/  /'
else
  echo "hyprland.log not found at $LOG_HYPR"
fi

echo
echo "== Waybar =="
WAYBAR_CFG="$HOME/.config/hypr/waybar/config"
if [[ -f "$WAYBAR_CFG" ]]; then
  echo "Found Waybar config: $WAYBAR_CFG"
  if rg -n '"idle_inhibitor"' "$WAYBAR_CFG" >/dev/null 2>&1; then
    echo "idle_inhibitor module present"
  else
    echo "idle_inhibitor module NOT found in Waybar config" >&2
  fi
else
  echo "Waybar config missing at $WAYBAR_CFG" >&2
fi

if command -v waybar-msg >/dev/null 2>&1; then
  echo "waybar-msg is available"
else
  echo "waybar-msg not found. Install your distro's Waybar package to enable IPC toggles." >&2
fi

LOG_WAYBAR="$HOME/.local/share/waybar/waybar.log"
if [[ -f "$LOG_WAYBAR" ]]; then
  echo "-- recent waybar.log (last 200 lines) --"
  tail -n 200 "$LOG_WAYBAR" | sed -e 's/^/  /'
else
  echo "waybar.log not found at $LOG_WAYBAR"
fi

echo
echo "== Summary =="
echo "- Use 'hyprctl reload' after editing configs."
echo "- Press '$mainMod + I' to toggle caffeination (requires waybar-msg)."
echo "- Run 'make check-logs' or this script to review logs."

