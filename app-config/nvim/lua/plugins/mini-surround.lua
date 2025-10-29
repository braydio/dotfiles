return {
  'nvim-mini/mini.surround',
  event = 'VeryLazy', -- or "InsertEnter", or remove for immediate load
  opts = {},
  config = function(_, opts)
    require('mini.surround').setup(opts)
  end,
}
