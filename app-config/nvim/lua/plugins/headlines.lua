-- plugins/headlines.lua
return {
  'lukas-reineke/headlines.nvim',
  ft = { 'markdown', 'norg', 'org', 'rmd' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('headlines').setup() -- Uses default config
  end,
}
