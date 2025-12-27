# Modules Catalog

This list captures the active Waybar modules, their IDs, and key settings. Use these IDs for targeted styling and scripting.

Top bar modules
- custom/launcher — App launcher glyph; attempts wofi/fuzzel/rofi or falls back to kitty.
- hyprland/workspaces — Workspaces indicator.
- hyprland/window — Active window title.
- mpris — Media title with paused formatting.
- network — SSID or offline; alt shows bandwidth.
- pulseaudio — Volume with icon set; click toggles mute.
- bluetooth — Status with click to power on/off.
- idle_inhibitor — Caffeinator toggle (coffee/moon icons).
- tray — System tray with spacing.

Bottom bar modules
- cpu — Usage percentage, icon ``.
- memory — Usage percentage, icon ``.
- temperature — Temperature in °C, critical at 80.
- disk — Root filesystem usage (path "/").
- battery — Icon + capacity; warning/critical thresholds.
- clock#lower — Time by default; alt shows date; click toggles.

Shared config notes
- Module IDs like `clock#lower` create separate instances with their own settings.
- Tooltip strings provide quick hints; avoid long shell commands in `on-click` unless necessary.
- Prefer built-in modules before custom scripts.

