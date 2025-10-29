# ~/.config/qutebrowser/theme_nightfox.py
# Palette (Nightfox-ish): https://github.com/EdenEast/nightfox.nvim (approx)
bg0 = "#111319"
bg1 = "#1a1c23"
bg2 = "#22262e"
fg = "#cdcecf"
fg_dim = "#9da3af"

blue = "#89b4fa"
cyan = "#7dcfff"
green = "#a6e3a1"
mag = "#cba6f7"
red = "#f38ba8"
yellow = "#f9e2af"
orange = "#fab387"

# ----- Completion -------------------------------------------------------------
c.colors.completion.category.bg = bg1
c.colors.completion.category.border.bottom = bg1
c.colors.completion.category.border.top = bg1
c.colors.completion.category.fg = fg

c.colors.completion.even.bg = bg0
c.colors.completion.odd.bg = bg0
c.colors.completion.fg = [fg, fg, fg_dim]
c.colors.completion.item.selected.bg = bg2
c.colors.completion.item.selected.border.bottom = bg2
c.colors.completion.item.selected.border.top = bg2
c.colors.completion.item.selected.fg = blue
c.colors.completion.match.fg = blue
c.colors.completion.scrollbar.bg = bg0
c.colors.completion.scrollbar.fg = fg_dim

# ----- Statusbar --------------------------------------------------------------
c.colors.statusbar.normal.bg = bg1
c.colors.statusbar.normal.fg = fg
c.colors.statusbar.insert.bg = blue
c.colors.statusbar.insert.fg = bg1
c.colors.statusbar.command.bg = bg0
c.colors.statusbar.command.fg = fg
c.colors.statusbar.caret.bg = mag
c.colors.statusbar.caret.fg = bg1
c.colors.statusbar.passthrough.bg = cyan
c.colors.statusbar.passthrough.fg = bg1
c.colors.statusbar.progress.bg = blue
c.colors.statusbar.url.fg = fg
c.colors.statusbar.url.hover.fg = cyan
c.colors.statusbar.url.success.http.fg = green
c.colors.statusbar.url.success.https.fg = green
c.colors.statusbar.url.warn.fg = yellow
c.colors.statusbar.url.error.fg = red

# ----- Tabs -------------------------------------------------------------------
c.colors.tabs.bar.bg = bg1
c.colors.tabs.indicator.error = red
c.colors.tabs.indicator.start = blue
c.colors.tabs.indicator.stop = cyan

c.colors.tabs.even.bg = bg0
c.colors.tabs.even.fg = fg_dim
c.colors.tabs.odd.bg = bg0
c.colors.tabs.odd.fg = fg_dim

c.colors.tabs.selected.even.bg = bg2
c.colors.tabs.selected.even.fg = fg
c.colors.tabs.selected.odd.bg = bg2
c.colors.tabs.selected.odd.fg = fg

# ----- Downloads --------------------------------------------------------------
c.colors.downloads.bar.bg = bg1
c.colors.downloads.start.bg = blue
c.colors.downloads.stop.bg = green
c.colors.downloads.error.fg = red

# ----- Hints / Messages -------------------------------------------------------
c.colors.hints.bg = yellow
c.colors.hints.fg = bg1
c.colors.hints.match.fg = red

c.colors.messages.error.bg = bg1
c.colors.messages.error.border = red
c.colors.messages.error.fg = red
c.colors.messages.warning.bg = bg1
c.colors.messages.warning.border = yellow
c.colors.messages.warning.fg = yellow
c.colors.messages.info.bg = bg1
c.colors.messages.info.border = blue
c.colors.messages.info.fg = fg

# ----- Prompts ----------------------------------------------------------------
c.colors.prompts.bg = bg0
c.colors.prompts.border = bg1
c.colors.prompts.fg = fg
c.colors.prompts.selected.bg = bg2

# ----- Keyhints ---------------------------------------------------------------
c.colors.keyhint.bg = bg0
c.colors.keyhint.fg = fg
c.colors.keyhint.suffix.fg = blue
