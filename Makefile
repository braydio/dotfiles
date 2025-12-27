# Quality-of-life targets for local validation. Safe to run mid-session.

.PHONY: reload waybar-reload check-logs waybar-logs validate bars docs waybar-caffeinate

HYPR_DIR ?= $(HOME)/.config/hypr
WAYBAR_DIR ?= $(HYPR_DIR)/waybar

reload:
	@echo "[hypr] reload"
	hyprctl reload || true

waybar-reload:
	@echo "[waybar] send USR2 (if supported)"
	- pkill -USR2 waybar 2>/dev/null || true
	@echo "If Waybar did not reload, consider restarting it manually."

check-logs:
	@echo "[hypr] tail recent log lines"
	@LOG_FILE="$(HOME)/.local/share/hyprland/hyprland.log"; \
	if [ -f "$$LOG_FILE" ]; then tail -n 200 "$$LOG_FILE"; else echo "No hyprland.log found at $$LOG_FILE"; fi

waybar-logs:
	@echo "[waybar] tail recent log lines"
	@LOG_FILE="$(HOME)/.local/share/waybar/waybar.log"; \
	if [ -f "$$LOG_FILE" ]; then tail -n 200 "$$LOG_FILE"; else echo "No waybar.log found at $$LOG_FILE"; fi

validate:
	@echo "[hypr] re-source entry chain"
	hyprctl keyword source $(HYPR_DIR)/hyprland.conf || true
	@echo "[waybar] config present?"
	@test -f $(WAYBAR_DIR)/config && echo "Found: $(WAYBAR_DIR)/config" || echo "Missing: $(WAYBAR_DIR)/config"

bars:
	@echo "[waybar] configured bars and positions"
	@rg -n '"position"\s*:\s*' $(WAYBAR_DIR)/config || cat $(WAYBAR_DIR)/config | sed -n '1,80p'

docs:
	@echo "Docs index: $(HYPR_DIR)/docs/README.md"
	@test -f $(HYPR_DIR)/docs/README.md && sed -n '1,120p' $(HYPR_DIR)/docs/README.md || echo "docs/README.md missing"

waybar-caffeinate:
	@echo "[waybar] toggle idle inhibitor via IPC"
	@command -v waybar-msg >/dev/null 2>&1 && waybar-msg module idle_inhibitor toggle || echo "waybar-msg not found; install Waybar with IPC support"
