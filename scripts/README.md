# scripts/

Helper scripts invoked by keybinds or used for quick validation.

## toggle_idle_inhibitor.sh
- Purpose: Toggle Waybar’s built-in `idle_inhibitor` (caffeinator) module.
- Usage: `~/.config/hypr/scripts/toggle_idle_inhibitor.sh`
- Called by: `$mainMod + I` in `keybinds.conf`.
- Dependencies: `waybar-msg` (usually provided by the Waybar package).
- Behavior: Attempts `waybar-msg module idle_inhibitor toggle`; prints a helpful message if `waybar-msg` is unavailable.

## sanity.sh
- Purpose: Quick, non-destructive environment and config checks.
- Usage: `~/.config/hypr/scripts/sanity.sh`
- What it does:
  - Shows Hyprland version and tails the recent Hyprland log lines for warnings/errors.
  - Verifies presence of Waybar config and caffeinator module.
  - Checks for common dependencies (`waybar-msg`, `hyprctl`).
  - Does not restart or kill running processes.

## bootstrap.sh
- Purpose: Validate dependencies and referenced assets for a clean first-time setup.
- Usage: `~/.config/hypr/scripts/bootstrap.sh`
- Options: `--print-install` to show a best-effort install command for missing packages.
- What it does:
  - Scans autostart/extra/keybind configs for referenced commands and checks PATH.
  - Verifies known asset/script paths used by this config.
- Exits non-zero if required commands or paths are missing.

## link-configs.sh
- Purpose: Link app configs under `app-config/` into `~/.config` using GNU stow.
- Usage: `~/.config/hypr/scripts/link-configs.sh`
- Options: `--dry-run`, `--restow`, `--target <dir>`, plus optional package names.
- Behavior:
  - Stows all `app-config/*` folders into `~/.config` by default.
  - Backs up existing real configs to `*.bak.<timestamp>` before linking.

Conventions
- All scripts include a shebang and use `set -euo pipefail`.
- Keep scripts idempotent and safe to run mid-session.
- Prefer invoking scripts via `bash -lc '<script>'` in binds for consistent PATH resolution.
