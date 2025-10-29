# ~/.config/qutebrowser/theme_nord.py
# Nord: https://www.nordtheme.com
nord0 = "#2E3440"
nord1 = "#3B4252"
nord2 = "#434C5E"
nord3 = "#4C566A"
nord4 = "#D8DEE9"
nord5 = "#E5E9F0"
nord6 = "#ECEFF4"
nord7 = "#8FBCBB"
nord8 = "#88C0D0"
nord9 = "#81A1C1"
nord10 = "#5E81AC"
nord11 = "#BF616A"
nord12 = "#D08770"
nord13 = "#EBCB8B"
nord14 = "#A3BE8C"
nord15 = "#B48EAD"

bg0 = nord0
bg1 = nord1
bg2 = nord2
fg = nord6
fg_dim = nord4

# Completion
c.colors.completion.category.bg = bg1
c.colors.completion.category.fg = fg
c.colors.completion.category.border.top = bg1
c.colors.completion.category.border.bottom = bg1
c.colors.completion.even.bg = bg0
c.colors.completion.odd.bg = bg0
c.colors.completion.fg = [fg, fg, fg_dim]
c.colors.completion.item.selected.bg = bg2
c.colors.completion.item.selected.fg = nord8
c.colors.completion.item.selected.border.top = bg2
c.colors.completion.item.selected.border.bottom = bg2
c.colors.completion.match.fg = nord9
c.colors.completion.scrollbar.bg = bg0
c.colors.completion.scrollbar.fg = fg_dim

# Statusbar
c.colors.statusbar.normal.bg = bg1
c.colors.statusbar.normal.fg = fg
c.colors.statusbar.insert.bg = nord10
c.colors.statusbar.insert.fg = bg1
c.colors.statusbar.command.bg = bg0
c.colors.statusbar.command.fg = fg
c.colors.statusbar.caret.bg = nord15
c.colors.statusbar.caret.fg = bg1
c.colors.statusbar.passthrough.bg = nord8
c.colors.statusbar.passthrough.fg = bg1
c.colors.statusbar.progress.bg = nord9
c.colors.statusbar.url.fg = fg
c.colors.statusbar.url.hover.fg = nord8
c.colors.statusbar.url.success.http.fg = nord14
c.colors.statusbar.url.success.https.fg = nord14
c.colors.statusbar.url.warn.fg = nord13
c.colors.statusbar.url.error.fg = nord11

# Tabs
c.colors.tabs.bar.bg = bg1
c.colors.tabs.indicator.error = nord11
c.colors.tabs.indicator.start = nord9
c.colors.tabs.indicator.stop = nord8

c.colors.tabs.even.bg = bg0
c.colors.tabs.even.fg = fg_dim
c.colors.tabs.odd.bg = bg0
c.colors.tabs.odd.fg = fg_dim

c.colors.tabs.selected.even.bg = bg2
c.colors.tabs.selected.even.fg = fg
c.colors.tabs.selected.odd.bg = bg2
c.colors.tabs.selected.odd.fg = fg

# Downloads
c.colors.downloads.bar.bg = bg1
c.colors.downloads.start.bg = nord9
c.colors.downloads.stop.bg = nord14
c.colors.downloads.error.fg = nord11

# Hints / Messages
c.colors.hints.bg = nord13
c.colors.hints.fg = bg1
c.colors.hints.match.fg = nord11

c.colors.messages.error.bg = bg1
c.colors.messages.error.border = nord11
c.colors.messages.error.fg = nord11
c.colors.messages.warning.bg = bg1
c.colors.messages.warning.border = nord13
c.colors.messages.warning.fg = nord13
c.colors.messages.info.bg = bg1
c.colors.messages.info.border = nord9
c.colors.messages.info.fg = fg

# Prompts
c.colors.prompts.bg = bg0
c.colors.prompts.border = bg1
c.colors.prompts.fg = fg
c.colors.prompts.selected.bg = bg2

# Keyhints
c.colors.keyhint.bg = bg0
c.colors.keyhint.fg = fg
c.colors.keyhint.suffix.fg = nord9
