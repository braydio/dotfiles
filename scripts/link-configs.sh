#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$HOME/.config/hypr}"
timestamp="$(date +%Y%m%d%H%M%S)"

# Directories whose appearance/settings shape the Hyprland desktop experience.
DIRS=(
  "kitty"          # main terminal launched by Hypr keybinds
  "ghostty"        # alternate terminal referenced in keybinds
  "warp-terminal"  # Warp settings for the launcher keymap
  "eww"            # widget toolkit for Wayland status/overlays
  "gtk-3.0"        # GTK theming for most GUI apps
  "gtk-4.0"        # GTK4 apps (libadwaita et al.)
)

# Individual config files that influence look & feel.
FILES=(
  "starship.toml"  # shell prompt styling seen in Kitty/Ghostty
)

backup() {
  local path=$1
  if [ -e "$path" ] && [ ! -L "$path" ]; then
    mv "$path" "${path}.bak.${timestamp}"
  elif [ -L "$path" ]; then
    rm "$path"
  fi
}

link_dir() {
  local name=$1
  local src="$HOME/.config/$name"
  local dest="$REPO_DIR/$name"

  if [ -d "$src" ] && [ ! -e "$dest" ]; then
    mkdir -p "${dest%/*}"
    mv "$src" "$dest"
  elif [ ! -e "$dest" ]; then
    echo "[warn] Skipping $name (nothing to version at $dest)." >&2
    return
  fi

  mkdir -p "${dest%/*}"
  backup "$src"
  ln -s "$dest" "$src"
  echo "Linked $src -> $dest"
}

link_file() {
  local name=$1
  local src="$HOME/.config/$name"
  local dest="$REPO_DIR/$name"

  if [ -f "$src" ] && [ ! -e "$dest" ]; then
    mkdir -p "${dest%/*}"
    mv "$src" "$dest"
  elif [ ! -e "$dest" ]; then
    echo "[warn] Skipping $name (nothing to version at $dest)." >&2
    return
  fi

  mkdir -p "${dest%/*}"
  backup "$src"
  ln -s "$dest" "$src"
  echo "Linked $src -> $dest"
}

for dir in "${DIRS[@]}"; do
  link_dir "$dir"
done

for file in "${FILES[@]}"; do
  link_file "$file"
done

echo "Done. Backups (if any) carry the .bak.${timestamp} suffix."
