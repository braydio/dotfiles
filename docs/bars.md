# Bars

This setup defines two Waybar instances in a single config (array form):
- Top bar — workspaces, window title, media, system toggles, tray
- Bottom bar — system resource indicators and a right-aligned clock

File: waybar/config
- The file is a JSON array with two bar objects.
- Each bar specifies `position`, `height`, and `modules-*` sections.

Top bar (position: top)
- modules-left: `group/workspaces-title` (launcher, workspaces, active window)
- modules-center: `custom/center_l`, `clock`, `custom/center_r`
- modules-right: `group/media` (mpris), `group/system` (network, audio, bluetooth, idle_inhibitor), `tray`

Bottom bar (position: bottom)
- modules-left: `cpu`, `memory`, `temperature`, `disk`, `battery`
- modules-right: `clock#lower` (time/date toggle on click)

Clock behavior
- Top: `clock` shows day+date+time and supports an alternate format via `format-alt`.
- Bottom: `clock#lower` defines its own format/alt and toggles with `on-click: mode`.

Caffeination
- The `idle_inhibitor` module lives on the top bar in `group/system`.
- Toggle via `$mainMod + I` or `make waybar-caffeinate` (IPC required).

Notes
- Styling is shared via `waybar/style.css`. Module IDs can be targeted with `#cpu`, `#memory`, etc.
- Use palette tokens from `waybar/way_colors.css` (symlink to theme) rather than raw hex.

