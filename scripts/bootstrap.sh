#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-$HOME/.config/hypr}"
PRINT_INSTALL=0
PM="${PM:-}"

usage() {
  cat <<'EOF'
Usage: bootstrap.sh [--print-install] [--pm <manager>]

Checks Hyprland config dependencies and referenced assets. By default this is
read-only and safe to run mid-session.

Options:
  --print-install   Print a best-effort install command for missing packages.
  --pm <manager>    Override detected package manager (pacman, apt, dnf, zypper).
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --print-install)
      PRINT_INSTALL=1
      shift
      ;;
    --pm)
      PM="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

detect_pm() {
  if [[ -n "$PM" ]]; then
    echo "$PM"
    return
  fi
  if command -v pacman >/dev/null 2>&1; then
    echo "pacman"
  elif command -v apt-get >/dev/null 2>&1; then
    echo "apt"
  elif command -v dnf >/dev/null 2>&1; then
    echo "dnf"
  elif command -v zypper >/dev/null 2>&1; then
    echo "zypper"
  else
    echo ""
  fi
}

declare -A CMD_PKG
CMD_PKG=(
  [hyprland]="hyprland"
  [hyprctl]="hyprland"
  [hyprpaper]="hyprpaper"
  [waybar]="waybar"
  [waybar-msg]="waybar"
  [wpctl]="wireplumber"
  [pactl]="pulseaudio-utils"
  [playerctl]="playerctl"
  [bluetoothctl]="bluez"
  [brightnessctl]="brightnessctl"
  [swaylock]="swaylock"
  [swayidle]="swayidle"
  [wl-copy]="wl-clipboard"
  [kitty]="kitty"
  [rofi]="rofi"
  [dolphin]="dolphin"
  [mako]="mako"
  [swww]="swww"
  [darkman]="darkman"
  [wayvnc]="wayvnc"
  [discord-ptb]="aur:discord-ptb"
  [multibg-wayland]="aur:multibg-wayland"
)

declare -A CMD_SOURCES

add_cmd() {
  local cmd="$1"
  local source="$2"

  if [[ -z "$cmd" ]]; then
    return
  fi

  if [[ -n "${CMD_SOURCES[$cmd]:-}" ]]; then
    CMD_SOURCES["$cmd"]+=",${source}"
  else
    CMD_SOURCES["$cmd"]="$source"
  fi
}

collect_exec_binaries() {
  local file="$1"
  local source="$2"
  local line cmd

  [[ -f "$file" ]] || return

  while IFS= read -r line; do
    line="${line%%#*}"
    if [[ $line =~ ^[[:space:]]*exec(-once)?[[:space:]]*= ]]; then
      cmd="${line#*=}"
      cmd="${cmd#"${cmd%%[![:space:]]*}"}"
      cmd="${cmd%%[[:space:]]*}"
      add_cmd "$cmd" "$source"
    fi
  done < "$file"
}

collect_keybind_execs() {
  local file="$1"
  local line cmd

  [[ -f "$file" ]] || return

  while IFS= read -r line; do
    line="${line%%#*}"
    if [[ $line =~ ,[[:space:]]*exec,[[:space:]]*(.+)$ ]]; then
      cmd="${BASH_REMATCH[1]}"
      cmd="${cmd#"${cmd%%[![:space:]]*}"}"
      cmd="${cmd%%[[:space:]]*}"
      add_cmd "$cmd" "keybinds"
    fi
  done < "$file"
}

echo "== Hyprland Bootstrap =="
echo "Config root: $REPO_DIR"

if [[ ! -d "$REPO_DIR" ]]; then
  echo "Missing config directory at $REPO_DIR" >&2
fi

add_cmd "hyprland" "core"
add_cmd "hyprctl" "core"
add_cmd "waybar-msg" "core"

collect_exec_binaries "$REPO_DIR/autostart.conf" "autostart"
collect_exec_binaries "$REPO_DIR/extra.conf" "extra"
collect_keybind_execs "$REPO_DIR/keybinds.conf"

missing_cmds=()
present_cmds=()

for cmd in "${!CMD_SOURCES[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    present_cmds+=("$cmd")
  else
    missing_cmds+=("$cmd")
  fi
done

echo
echo "== Commands =="
if ((${#missing_cmds[@]} == 0)); then
  echo "All referenced commands are available."
else
  for cmd in "${missing_cmds[@]}"; do
    pkg="${CMD_PKG[$cmd]:-$cmd}"
    echo "Missing: $cmd (suggested package: $pkg; sources: ${CMD_SOURCES[$cmd]})" >&2
  done
fi

if ((PRINT_INSTALL == 1)); then
  pm="$(detect_pm)"
  if [[ -z "$pm" ]]; then
    echo "No supported package manager detected (pacman, apt, dnf, zypper)." >&2
  else
    declare -A pkg_set
    declare -A aur_set
    pkgs=()
    aur_pkgs=()
    for cmd in "${missing_cmds[@]}"; do
      pkg="${CMD_PKG[$cmd]:-$cmd}"
      if [[ "$pkg" == aur:* ]]; then
        pkg="${pkg#aur:}"
        if [[ -z "${aur_set[$pkg]:-}" ]]; then
          aur_set["$pkg"]=1
          aur_pkgs+=("$pkg")
        fi
        continue
      fi
      if [[ -z "${pkg_set[$pkg]:-}" ]]; then
        pkg_set["$pkg"]=1
        pkgs+=("$pkg")
      fi
    done
    if ((${#pkgs[@]} > 0)); then
      case "$pm" in
        pacman)
          echo "Install (Arch/pacman): sudo pacman -S --needed ${pkgs[*]}"
          ;;
        apt)
          echo "Install (Debian/Ubuntu): sudo apt-get install ${pkgs[*]}"
          ;;
        dnf)
          echo "Install (Fedora): sudo dnf install ${pkgs[*]}"
          ;;
        zypper)
          echo "Install (openSUSE): sudo zypper install ${pkgs[*]}"
          ;;
        *)
          echo "Install via $pm: ${pkgs[*]}"
          ;;
      esac
      if ((${#aur_pkgs[@]} > 0)); then
        echo "AUR packages: ${aur_pkgs[*]}"
        echo "Install with your AUR helper (example): yay -S --needed ${aur_pkgs[*]}"
      fi
      echo "Package names may vary by distro; adjust as needed."
    fi
  fi
fi

echo
echo "== Paths =="
declare -A PATH_SOURCES
PATH_SOURCES=(
  ["$HOME/Pictures/Wallpapers/MultiBG"]="autostart.conf"
  ["$HOME/Pictures/Wallpapers/HyprPaper.png"]="hyprpaper.conf"
  ["$HOME/Pictures/Wallpapers/HyprPaperVNC.png"]="hyprpaper.conf"
  ["$HOME/Pictures/Lockscreen/HyprLock.png"]="autostart.conf"
  ["$HOME/Pictures/Lockscreen/HyprPaper.png"]="autostart.conf/keybinds.conf"
  ["$HOME/Scripts/utility/screenshot.sh"]="keybinds.conf"
  ["$HOME/Scripts/terminal-mgmt/grid-kitty.sh"]="keybinds.conf"
)

missing_paths=0
for path in "${!PATH_SOURCES[@]}"; do
  if [[ ! -e "$path" ]]; then
    echo "Missing: $path (referenced by ${PATH_SOURCES[$path]})" >&2
    missing_paths=$((missing_paths + 1))
  fi
done

if ((missing_paths == 0)); then
  echo "Referenced assets/scripts are present."
fi

echo
echo "== Next steps =="
echo "- Run 'hyprctl reload' after changes."
echo "- Run 'scripts/link-configs.sh' to stow app configs into ~/.config."
echo "- Run 'scripts/sanity.sh' to inspect logs."

if ((${#missing_cmds[@]} > 0 || missing_paths > 0)); then
  exit 1
fi
