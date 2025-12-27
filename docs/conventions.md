# Conventions

Structure
- `hyprland.conf` includes configs in a fixed order; respect it when adding files.
- Module assets live next to their configs; scripts under `scripts/` with executable bit.

Style
- Hyprland settings: `keyword=value` with spaced comma lists.
- Banner comments (`################`) group related options; avoid nested blocks unless rules require.
- Waybar CSS uses GTK syntax; target `window#waybar` and module IDs (e.g., `#cpu`). Avoid unsupported CSS features (flexbox, gap, text-align, etc.).
- Use palette tokens via `@import "way_colors.css"` instead of raw hex.

Bindings & Scripts
- Use named variables (`$mainMod`) and small, descriptive commands.
- Scripts: shebang + `chmod +x`; idempotent and safe mid-session.

Testing
- `hyprctl reload` after edits; check `~/.local/share/hyprland/hyprland.log`.
- Restart/Reload Waybar or `make waybar-reload`; check `~/.local/share/waybar/waybar.log`.

