-- ~/.config/nvim/lua/config/whichkey.lua

return {
  -- Put this in ~/.config/nvim/lua/config/keymaps.lua or similar
  vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent line' }),
  vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Unindent line' }),
}
