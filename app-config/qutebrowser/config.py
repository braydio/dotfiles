# ~/.config/qutebrowser/config.py
config.load_autoconfig(False)

c.url.start_pages = ["http://192.168.1.198:8085"]
c.url.default_page = "http://192.168.1.198:8085"

c.completion.web_history.max_items = 1000
c.completion.cmd_history_max_items = 500
c.completion.height = "30%"
c.completion.shrink = True

c.fonts.default_family = "JetBrains Mono"
c.fonts.default_size = "11pt"

# 🔹 Source the *current* theme (symlink will point to Nightfox or Nord)
config.source("theme_current.py")

# Binds
config.bind(",t", "spawn --userscript ~/.config/qutebrowser/toggle_theme.sh")
config.bind(",w", "spawn --userscript ~/.config/qutebrowser/toggle_waybar.sh")
config.bind(
    ",h", "open file:///home/braydenchaffee/.config/qutebrowser/cheatsheet.html"
)
config.bind(",p", "open file:///home/braydenchaffee/Pictures/Screenshots/")

# Dark mode tuning (still useful for non-themed content)
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.darkmode.policy.images", "smart")
config.set("colors.webpage.darkmode.threshold.foreground", 120)
config.set("colors.webpage.darkmode.threshold.background", 230)
