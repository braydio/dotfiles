# MACHINE

Host-specific notes and expectations to keep configs portable. Avoid committing secrets; reference placeholders in `env.conf`.

## Expected Binaries
- Hyprland stack: `hyprland`, `hyprctl`, `hyprpaper` (if wallpapers used)
- Waybar: `waybar`, `waybar-msg`
- Audio: `wpctl` (PipeWire), `pactl` (fallback)
- Media control: `playerctl`
- Bluetooth: `bluetoothctl`
- Power/brightness: `brightnessctl`
- Lock screen: `swaylock` (per current keybinds)
- Utilities: `wl-copy`, `kitty` (terminal), `rofi`/`wofi`/`fuzzel` (launcher)

## Environment
- Config root: `~/.config/hypr`
- Waybar config: `~/.config/hypr/waybar/config`
- Logs:
  - Hyprland: `~/.local/share/hyprland/hyprland.log`
  - Waybar: `~/.local/share/waybar/waybar.log`

## Machine-Specific Overrides
- Use `env.conf` for tokens and per-host customization via environment variables.
- If you need diverging monitor layouts, park alternates in `backups/` with a timestamp suffix and switch via symlink or manual copy.

## Validation Tips
- `hyprctl reload` after edits to catch syntax errors early.
- `waybar-msg module idle_inhibitor toggle` to test the caffeination module.
- `scripts/sanity.sh` for a quick health check (safe mid-session).

