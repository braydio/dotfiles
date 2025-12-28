#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$HOME/.config/hypr}"
APP_DIR="$REPO_DIR/app-config"
TARGET_DIR="${TARGET_DIR:-$HOME/.config}"
timestamp="$(date +%Y%m%d%H%M%S)"
DRY_RUN=0
RESTOW=0

usage() {
  cat <<'EOF'
Usage: link-configs.sh [--dry-run] [--restow] [--target <dir>] [package...]

Stow app configs from app-config/ into ~/.config (or TARGET_DIR).
When no packages are provided, all app-config subfolders are stowed.

Options:
  --dry-run        Show actions without writing changes.
  --restow         Restow existing packages (useful after updates).
  --target <dir>   Override target (default: ~/.config).
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --restow)
      RESTOW=1
      shift
      ;;
    --target)
      TARGET_DIR="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      break
      ;;
  esac
done

if ! command -v stow >/dev/null 2>&1; then
  echo "stow not found. Install GNU stow and re-run this script." >&2
  exit 1
fi

if [[ ! -d "$APP_DIR" ]]; then
  echo "Missing app-config directory at $APP_DIR" >&2
  exit 1
fi

packages=()
if [[ $# -gt 0 ]]; then
  for pkg in "$@"; do
    if [[ ! -d "$APP_DIR/$pkg" ]]; then
      echo "[warn] Package not found: $APP_DIR/$pkg" >&2
      continue
    fi
    packages+=("$pkg")
  done
else
  while IFS= read -r pkg; do
    packages+=("$pkg")
  done < <(find "$APP_DIR" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)
fi

if ((${#packages[@]} == 0)); then
  echo "No packages to stow." >&2
  exit 1
fi

backup_target() {
  local path=$1
  local expected=$2
  if ((DRY_RUN == 1)); then
    if [ -L "$path" ]; then
      echo "[dry-run] Would remove conflicting symlink: $path"
    elif [ -e "$path" ]; then
      echo "[dry-run] Would backup $path -> ${path}.bak.${timestamp}"
    fi
    return
  fi
  if [ -L "$path" ]; then
    local target
    target="$(readlink -f "$path" || true)"
    if [[ "$target" != "$expected" ]]; then
      rm "$path"
    fi
    return
  fi
  if [ -e "$path" ]; then
    mv "$path" "${path}.bak.${timestamp}"
  fi
}

for pkg in "${packages[@]}"; do
  backup_target "$TARGET_DIR/$pkg" "$APP_DIR/$pkg"
done

stow_args=("-d" "$APP_DIR" "-t" "$TARGET_DIR")
if ((DRY_RUN == 1)); then
  stow_args+=("-n")
fi
if ((RESTOW == 1)); then
  stow_args+=("-R")
fi

stow "${stow_args[@]}" "${packages[@]}"

if ((DRY_RUN == 1)); then
  echo "Dry run complete."
else
  echo "Done. Backups (if any) carry the .bak.${timestamp} suffix."
fi
