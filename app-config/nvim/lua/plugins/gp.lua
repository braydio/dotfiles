return {
  'Robitx/gp.nvim',
  event = 'VeryLazy',
  config = function()
    local gp = require 'gp'
    gp.setup {
      providers = {
        openai = {
          disable = false,
          endpoint = 'https://api.openai.com/v1/chat/completions',
          secret = os.getenv 'OPENAI_API_KEY',
        },
        -- Free/local option using Ollama's OpenAI-compatible API
        ollama = {
          disable = false,
          endpoint = os.getenv('OLLAMA_OPENAI_URL')
            or 'http://192.168.1.69:11434/v1/chat/completions',
          secret = 'dummy secret',
        },
      },

      cmd_prefix = 'Gp',
      -- no proxy by default; set CURL_PROXY env if needed
      curl_params = {},
      log_file = vim.fn.stdpath('config') .. '/lazy_log.log',
      log_sensitive = false,

      agents = {
        {
          provider = 'openai',
          name = 'ChatGPT4.1',
          chat = true,
          command = false,
          model = { model = 'gpt-4.1', temperature = 1.1, top_p = 1 },
          system_prompt = 'You are a helpful assistant.',
        },
        {
          provider = 'openai',
          name = 'ChatGPT4.1-nano',
          chat = true,
          command = false,
          model = { model = 'gpt-4.1-nano', temperature = 1.1, top_p = 1 },
          system_prompt = 'You are a helpful assistant.',
        },
        {
          provider = 'openai',
          name = 'CodeGPT-o3-mini',
          chat = false,
          command = true,
          model = { model = 'o3-mini', temperature = 0.8, top_p = 1 },
          system_prompt = require('gp.defaults').code_system_prompt,
        },
        -- Local, free agent using Ollama (adjust model to what you have pulled)
        {
          provider = 'ollama',
          name = 'OllamaCoder',
          chat = true,
          command = true,
          model = { model = (os.getenv('OLLAMA_MODEL') or 'qwen2.5-coder:7b'), temperature = 0.6 },
          system_prompt = require('gp.defaults').code_system_prompt,
        },
      },

      system_prompt = 'You are a helpful coding assistant',

      templates = {
        rewrite = {
          ReviewCode = {
            prompt = [[
Please review the following code block. Identify any errors or corrections that should be implemented, and describe them in brief comments or docstrings.

{{selection}}

Respond with the corrected code. Include *only* the corrected code in your response and nothing else.
]],
          },
          RefactorCode = {
            prompt = [[
Refactor the following code to improve readability, performance, and maintainability. Keep behavior the same.

{{selection}}

Return only the refactored code.
]],
          },
          ExplainCode = {
            prompt = [[
Explain what the following code does, line by line.

{{selection}}

Write the explanation in plain English for someone new to this language.
]],
          },
          CommentCode = {
            prompt = [[
Add helpful comments to the following code to clarify its purpose.

{{selection}}

Return only the updated code with comments.
]],
          },
          AddTypes = {
            prompt = [[
Add appropriate type annotations to the following code, based on standard typing practices for the language.

{{selection}}

Return only the updated code.
]],
          },
          FormatMarkdown = {
            prompt = [[
Rewrite the selection in markdown formatted syntax. Fix grammar, spelling, and punctuation as needed:

{{selection}}

Return only the rewritten content. Do not include any explanations, prefaces, or extra detail.
]],
          },
        },
      },
    }

    -- Visual mode keymaps (outside gp.setup)
    vim.keymap.set('n', '<leader>gn', '<Cmd>GpChatNew<CR>', { desc = '💬 Start a new GP chat' })
    vim.keymap.set(
      'v',
      '<leader>gr',
      ':<C-u>GpRewrite ReviewCode<CR>',
      { desc = '🧪 Review code' }
    )
    vim.keymap.set(
      'v',
      '<leader>gf',
      ':<C-u>GpRewrite RefactorCode<CR>',
      { desc = '🛠 Refactor code' }
    )
    vim.keymap.set(
      'v',
      '<leader>ge',
      ':<C-u>GpRewrite ExplainCode<CR>',
      { desc = '🧠 Explain code' }
    )
    vim.keymap.set(
      'v',
      '<leader>gc',
      ':<C-u>GpRewrite CommentCode<CR>',
      { desc = '💬 Add comments' }
    )
    vim.keymap.set(
      'v',
      '<leader>gm',
      ':<C-u>GpRewrite FormatMarkdown<CR>',
      { desc = '💬 Markdown format' }
    )
    vim.keymap.set(
      'v',
      '<leader>gt',
      ':<C-u>GpRewrite AddTypes<CR>',
      { desc = '🏷 Add type annotations' }
    )
  end,
}
