# Repository Guidelines

This repository stores the Hyprland configuration for daily use, so ship small, reviewable changes that remain safe to reload mid-session. Use this guide to keep behavior consistent across machines.

## Project Structure & Module Organization
- `hyprland.conf` bootstraps the session and sources, in order: `monitors.conf`, `autostart.conf`, `env.conf`, `colors.conf`, `style.conf`, `keybinds.conf`, `rules.conf`, `input.conf`, `workspaces.conf`, and `extra.conf`. Confirm placement before adding new includes.
- Keep module assets beside their config (`themes/` for palette files, scripts next to the callers) and make helpers in `scripts/` executable.
- Park experiments in `backups/` using a timestamp suffix (`monitors-20240221.conf`) to avoid contaminating the active load.
- Per-application tweaks live in `app-config/`, and Waybar overrides live under `waybar/`. Reuse tokens from `colors.conf` instead of duplicating hex values.

## Build, Test, and Development Commands
- `hyprctl reload` — hot reload the session and surface syntax errors.
- `hyprctl keyword source ~/.config/hypr/hyprland.conf` — force-read the entry chain when testing include changes.
- `hyprpaper reload` — refresh wallpapers after editing `hyprpaper.conf` or swapping assets.
- `git diff` — inspect pending edits before staging to avoid clobbering generated content.

## Coding Style & Naming Conventions
- Write settings as `keyword=value` with spaced comma lists (`monitor=HDMI-A-1, preferred, auto, auto`).
- Use banner comments (`################`) to group related options; avoid nesting blocks unless a rule demands it.
- Name reusable commands with lowercase `$variable_names` (e.g., `$launcher_app=fuzzel`), and keep inline comments to short intent notes.

## Testing Guidelines
- After each change, run `hyprctl reload` and read `~/.local/share/hyprland/hyprland.log` for warnings.
- Dry-run disruptive bindings via `hyprctl dispatch keyword` before enabling them.
- Validate display or workspace edits across all outputs with `hyprctl monitors` and workspace cycling.

## Commit & Pull Request Guidelines
- Prefix commits with Conventional headers (`feat:`, `fix:`, `docs:`) and keep summaries under 72 characters.
- Document motivation, validation steps, and required restarts in the PR; include before/after screenshots for visual tweaks.
- Link related issues or TODOs so reviewers understand the change path.

## Security & Configuration Tips
- Never commit secrets or machine-specific tokens; reference them from `env.conf` placeholders instead.
- New scripts need a shebang, `chmod +x`, and should be invoked via `$` variables so dispatchers stay consistent.

## Waybar Styling Notes
- Waybar styles use GTK CSS (libgtk-3) syntax rather than web CSS; confirm selectors against the GTK widget tree with `GTK_DEBUG=interactive waybar` if unsure.
- Stick to the supported GTK properties (e.g., `background`, `border`, `padding`, `box-shadow`, `transition`); web-only features like flexbox shorthands, `filter`, `backdrop-filter`, or text alignment (`text-align`) are ignored and raise parse errors (e.g., `gap`, `justify-content`, `align-items`, `text-align`).
- GTK lacks flex layout support; avoid `display: flex` entirely and recreate spacing with `margin`/`padding` on the child nodes.
- Style individual modules through the shared `.module` class (Waybar assigns it automatically) and override specific IDs (`#cpu`, `#clock`, etc.) for color tweaks rather than relying on unsupported container layout rules.
- Root styling should target `window#waybar`; `#waybar` works for legacy themes but the GTK window selector keeps overrides predictable.
- Leverage the palette tokens defined in `waybar/way_colors.css` via `@import` instead of raw hex codes to keep themes consistent.
- Scoped selectors target GTK node IDs such as `#waybar`, `#workspaces button`, and module IDs; pseudo-classes are limited to `:hover`, `:active`, and `:checked`.
- Always reload with `hyprctl reload` (or restart Waybar) after editing CSS to catch parse errors logged to `~/.local/share/waybar/waybar.log`.
