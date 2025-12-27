#!/usr/bin/env bash
set -euo pipefail

# Toggle Waybar's idle_inhibitor ("caffeinator") module.
# Tries waybar-msg if available; otherwise prints a helpful error.

toggle_with_waybar_msg() {
  if command -v waybar-msg >/dev/null 2>&1; then
    # Try common forms used by waybar-msg across versions
    if waybar-msg module idle_inhibitor toggle >/dev/null 2>&1; then
      return 0
    fi
    if waybar-msg -p module idle_inhibitor toggle >/dev/null 2>&1; then
      return 0
    fi
  fi
  return 1
}

if toggle_with_waybar_msg; then
  exit 0
fi

echo "toggle_idle_inhibitor: Could not toggle via waybar-msg. Ensure waybar-msg is installed and in PATH (often provided by the waybar package)." >&2
exit 1

