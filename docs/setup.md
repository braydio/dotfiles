# New Machine Setup

Use this checklist to bootstrap the Hyprland config cleanly on a new laptop.

1) Place this repo at `~/.config/hypr` (or set `REPO_DIR` for scripts).
2) Run `~/.config/hypr/scripts/bootstrap.sh` to check dependencies and assets.
3) Install missing packages and add the referenced wallpapers/scripts.
4) Install GNU stow, then run `~/.config/hypr/scripts/link-configs.sh` to link app configs into `~/.config`.
5) Run `hyprctl reload` and review `~/.local/share/hyprland/hyprland.log`.

Arch Linux notes
- Run `~/.config/hypr/scripts/bootstrap.sh --print-install` for pacman + AUR hints.
- AUR helpers (like `yay`) are not required but make AUR installs easier.

Optional helpers
- `~/.config/hypr/scripts/link-configs.sh` to stow `app-config/` into `~/.config`.
- `~/.config/hypr/scripts/sanity.sh` to review logs and Waybar status.
