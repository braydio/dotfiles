# Hyprland Config (Personal)

This is my daily-driver Hyprland + Waybar configuration. It is organized to be safe to hot-reload mid-session and keep machine-specific bits isolated.

## Quick Start (New Machine)
1) Place this repo at `~/.config/hypr` (or set `REPO_DIR` for scripts).
2) Run `~/.config/hypr/scripts/bootstrap.sh` to check dependencies and referenced assets.
3) Install missing packages and add the referenced wallpapers/scripts.
4) Run `hyprctl reload` and review `~/.local/share/hyprland/hyprland.log`.

Arch notes
- Run `~/.config/hypr/scripts/bootstrap.sh --print-install` for pacman + AUR hints.
- AUR helpers (like `yay`) are optional.

## Auto Install / Bootstrap Script
The repo includes a lightweight, read-only bootstrap checker:

- Script: `scripts/bootstrap.sh`
- What it does:
  - Scans `autostart.conf`, `extra.conf`, and `keybinds.conf` for referenced commands.
  - Verifies known asset/script paths (wallpapers, lockscreen image, helper scripts).
  - Exits non-zero if required commands or paths are missing.
- Optional output: `--print-install` prints best-effort install commands for missing packages.

## Layout and Include Order
The Hyprland entrypoint is `hyprland.conf`, which sources configs in this order:
1) `monitors.conf`
2) `autostart.conf`
3) `env.conf`
4) `colors.conf`
5) `style.conf`
6) `keybinds.conf`
7) `rules.conf`
8) `input.conf`
9) `workspaces.conf`
10) `extra.conf`

## Waybar Notes
- Waybar config lives at `waybar/config` and styling at `waybar/style.css`.
- The caffeinator module is `idle_inhibitor` and is wired to `$mainMod + I` via `scripts/toggle_idle_inhibitor.sh`.

## Scripts
See `scripts/README.md` for the full list. Highlights:
- `scripts/toggle_idle_inhibitor.sh` toggles Waybar’s idle inhibitor.
- `scripts/sanity.sh` performs quick, non-destructive checks and tails logs.
- `scripts/bootstrap.sh` validates dependencies/assets for first-time setup.

## Useful Commands
- `hyprctl reload` — reload Hyprland and catch config errors.
- `hyprctl keyword source ~/.config/hypr/hyprland.conf` — re-read the include chain.
- `hyprpaper reload` — refresh wallpapers after edits.
- `waybar-msg module idle_inhibitor toggle` — toggle caffeination (if Waybar IPC is available).

## Reference Docs
- `CODEMAP.md` — map of key files and how they connect.
- `MACHINE.md` — expected binaries and machine-specific notes.
- `docs/` — deeper notes on bars, modules, setup, testing, and conventions.
