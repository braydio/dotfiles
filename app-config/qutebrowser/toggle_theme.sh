# ~/.config/qutebrowser/toggle_theme.sh
#!/usr/bin/env bash
set -euo pipefail

CFG_DIR="${HOME}/.config/qutebrowser"
CURRENT="${CFG_DIR}/theme_current.py"
NIGHTFOX="${CFG_DIR}/theme_nightfox.py"
NORD="${CFG_DIR}/theme_nord.py"
STATE="${CFG_DIR}/.theme_state"

# Default to Nightfox on first run
if [[ ! -e "$CURRENT" ]]; then
  ln -sfn "$NIGHTFOX" "$CURRENT"
  echo "nightfox" >"$STATE"
fi

cur="nightfox"
[[ -f "$STATE" ]] && cur="$(cat "$STATE" || echo nightfox)"

if [[ "$cur" == "nightfox" ]]; then
  ln -sfn "$NORD" "$CURRENT"
  echo "nord" >"$STATE"
  msg="Theme: Nord"
else
  ln -sfn "$NIGHTFOX" "$CURRENT"
  echo "nightfox" >"$STATE"
  msg="Theme: Nightfox"
fi

# Reload qutebrowser config live if QUTE_FIFO is available
if [[ -n "${QUTE_FIFO:-}" && -p "$QUTE_FIFO" ]]; then
  printf '%s\n' "message-info '$msg'" >"$QUTE_FIFO"
  printf '%s\n' "config-source" >"$QUTE_FIFO"
fi
