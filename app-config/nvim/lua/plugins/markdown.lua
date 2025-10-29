-- Markdown-related tooling: LSP, preview, and rendering
return {
  -- Ensure marksman LSP is available and enabled for Markdown
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts = opts or {}
      opts.servers = opts.servers or {}
      opts.servers.marksman = opts.servers.marksman or {}

      -- Inject handler to disable virtual_text for marksman diagnostics only
      opts.setup = opts.setup or {}
      local prev = opts.setup.marksman
      opts.setup.marksman = function(server, server_opts)
        server_opts.handlers = vim.tbl_deep_extend("force", server_opts.handlers or {}, {
          ["textDocument/publishDiagnostics"] = vim.lsp.with(
            vim.lsp.diagnostic.on_publish_diagnostics,
            { virtual_text = false, underline = true, signs = true, update_in_insert = false }
          ),
        })
        if prev then
          return prev(server, server_opts)
        end
        -- return false/nil to continue with default setup using modified opts
      end
      return opts
    end,
  },

  -- Install marksman via Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.ensure_installed = opts.ensure_installed or {}
      local ensure = opts.ensure_installed
      local to_add = { "marksman" }
      for _, pkg in ipairs(to_add) do
        if not vim.tbl_contains(ensure, pkg) then
          table.insert(ensure, pkg)
        end
      end
      return opts
    end,
  },

  -- Markdown preview in browser
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  -- Render Markdown nicely in Neovim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      -- Use mostly defaults; lightweight tweaks only
      render_modes = { "n", "i" },
      code = { enabled = true },
      heading = { enabled = true },
      bullet = { enabled = true },
    },
  },
}
