# CODEMAP

This repository contains Hyprland, Waybar, and related config for daily use. This map highlights where to edit specific behaviors and how modules connect.

## Entrypoint and Include Order
- `hyprland.conf` — session bootstrap; sources, in order:
  1. `monitors.conf`
  2. `autostart.conf`
  3. `env.conf`
  4. `colors.conf` (symlink into `themes/`)
  5. `style.conf`
  6. `keybinds.conf`
  7. `rules.conf`
  8. `input.conf`
  9. `workspaces.conf`
  10. `extra.conf`

## Core Configs
- `monitors.conf` — outputs, modes, scale.
- `autostart.conf` — session autostart commands.
- `env.conf` — environment variables; use placeholders for machine secrets.
- `colors.conf` — palette tokens, symlinked to `themes/.../hypr-colors.conf`.
- `style.conf` — shared style, rounded corners, gaps, shadows.
- `keybinds.conf` — all binds; uses `$mainMod` (`SUPER`). Includes `$mainMod + I` for Waybar caffeination.
- `rules.conf` — window rules, floats, sizes.
- `input.conf` — keyboard, mouse, touchpad settings.
- `workspaces.conf` — workspace definitions, specials.
- `extra.conf` — overflow and experiments (non-disruptive).

## Waybar
- `app-config/waybar/config` — module layout and behavior.
  - Caffeinator module: `idle_inhibitor` (icons: activated = coffee, deactivated = moon).
  - Groups: `group/workspaces-title`, `group/system`, etc.
- `app-config/waybar/style.css` — GTK CSS theme for Waybar; uses tokens imported via `app-config/waybar/way_colors.css` (symlink to theme).
- `app-config/waybar/way_colors.css` — palette import; keep hex usage centralized.

## Scripts
- `scripts/toggle_idle_inhibitor.sh` — toggles Waybar `idle_inhibitor` via `waybar-msg`.
- `scripts/sanity.sh` — quick checks for config and common deps; tails logs.
- Conventions: shebang, executable bit, and called from binds via `bash -lc`.

## App- and Theme-Specific
- `app-config/` — per-application tweaks.
- `themes/` — theme palettes for Hyprland and Waybar; `colors.conf` and `app-config/waybar/way_colors.css` link here.

## Logs and Validation
- Hyprland log: `~/.local/share/hyprland/hyprland.log`.
- Waybar log: `~/.local/share/waybar/waybar.log`.
- Common commands:
  - `hyprctl reload` to hot-reload Hyprland.
  - `hyprctl keyword source ~/.config/hypr/hyprland.conf` to test include chain.
  - `waybar-msg module idle_inhibitor toggle` to toggle caffeination (if `waybar-msg` available).
