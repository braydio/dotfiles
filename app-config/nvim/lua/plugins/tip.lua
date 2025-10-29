return {
  'TobinPalmer/Tip.nvim',
  event = 'VimEnter',
  dependencies = { 'rcarriga/nvim-notify' },
  init = function()
    -- Ensure notify is active
    vim.notify = require 'notify'

    require('tip').setup {
      seconds = 5,
      title = '🧠 Vim Tip',
      url = 'https://vtip.43z.one', -- or try 'https://vimiscool.tech/neotip'
      notify = function(msg)
        require 'notify'(msg, 'info', {
          title = '🧠 Vim Tip',
          timeout = 5000,
          render = 'default',
        })
      end,
    }
  end,
}
