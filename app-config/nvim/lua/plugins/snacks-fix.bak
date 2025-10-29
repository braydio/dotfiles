-- lua/plugins/snacks-fix.lu

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      statuscolumn = {
        enabled = true,
        separator = '│', -- clean vertical line
        setopt = true, -- let snacks manage `vim.o.statuscolumn`
        foldsymbols = {
          open = '', -- Nerd Font downward arrow
          closed = '', -- Nerd Font right arrow
          separator = ' ', -- spacing between fold icon and line number
        },
        number = true, -- show line numbers
        relativenumber = true, -- use relative line numbers
        signcolumn = 'auto', -- use whatever signs are present (e.g., Git, LSP)
      },
      -- Optionally, enable more snacks modules:
      notifications = {
        enabled = true, -- popup notifications
      },
      breadcrumbs = {
        enabled = true, -- show file/module path in winbar
      },
    },
  },
}
