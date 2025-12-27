# Testing & Validation

Hot-reload and verify changes safely.

Hyprland
- Reload: `hyprctl reload`
- Force-read entry chain: `hyprctl keyword source ~/.config/hypr/hyprland.conf`
- Log: `~/.local/share/hyprland/hyprland.log`

Waybar
- Reload signal: `make waybar-reload` (best-effort USR2)
- Logs: `~/.local/share/waybar/waybar.log` and `make waybar-logs`
- Toggle caffeination: `make waybar-caffeinate` (requires `waybar-msg`)

Sanity checks
- `~/.config/hypr/scripts/sanity.sh` — checks versions, logs, presence of key modules.
- `make validate` — re-sources Hyprland entry and confirms Waybar config presence.

