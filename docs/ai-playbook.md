# AI Playbook

Purpose
- Provide a safe, deterministic workflow for AI assistants modifying this repo.

Quick rules
- Keep changes small, reviewable, and hot-reload safe.
- Update related docs under `docs/` when adding modules or bindings.
- Prefer built-in Waybar/Hyprland mechanisms over complex scripts.

Where to make changes
- Bars and modules: `app-config/waybar/config` (JSON array supports top and bottom bars).
- Styles: `app-config/waybar/style.css` (GTK CSS) with palette at `app-config/waybar/way_colors.css`.
- Hyprland binds and behaviors: `keybinds.conf` and friends loaded by `hyprland.conf`.
- Scripts: `scripts/` with shebang + executable bit.

Validation flow
- Run `make validate` to re-source Hyprland entry.
- Run `make waybar-reload` (or restart Waybar) after editing `app-config/waybar/`.
- Check logs: `make check-logs` and `make waybar-logs`.
- For caffeination, test `make waybar-caffeinate` or press `$mainMod + I`.

Gotchas
- Waybar’s CSS is GTK, not web CSS; unsupported props will log parse errors.
- Multiple bars share the same config file; use instance IDs like `clock#lower` if you need per-bar variants.
- Avoid machine-specific hardcoding; use `env.conf` placeholders.
