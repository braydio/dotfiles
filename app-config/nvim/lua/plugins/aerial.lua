-- plugins/aerial.lua
return {
  'stevearc/aerial.nvim',
  lazy = true,
  cmd = { 'AerialToggle', 'AerialOpen', 'AerialClose', 'AerialNavOpen' },
  keys = {
    { '<leader>ss', '<cmd>AerialToggle!<CR>', desc = 'Symbols Outline (Aerial)' },
  },
  opts = {
    -- Optional: you can put your own options here, or leave empty to use defaults
    -- Example options:
    -- backends = { "treesitter", "lsp", "markdown" },
  },
  config = function(_, opts)
    require('aerial').setup(opts)
  end,
}
