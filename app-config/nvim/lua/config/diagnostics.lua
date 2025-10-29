vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  signs = true,
  update_in_insert = false,
})

-- Disable inline diagnostics (virtual text) for Markdown by default
local md_diag_group = vim.api.nvim_create_augroup('MarkdownDiagnostics', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = md_diag_group,
  pattern = 'markdown',
  callback = function(args)
    -- Apply buffer-local diagnostic config
    vim.diagnostic.config({ virtual_text = false }, args.buf)
  end,
})
