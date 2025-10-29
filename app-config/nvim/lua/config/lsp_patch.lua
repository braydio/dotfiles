-- ~/.config/nvim/lua/config/lsp_patch.lua
-- Patch vim.lsp.sync to avoid crashes due to nil 'prev_line'

local sync = require 'vim.lsp.sync'

-- Safely get line or fallback to empty string
local function safe_get_line(bufnr, line)
  local ok, lines = pcall(vim.api.nvim_buf_get_lines, bufnr, line, line + 1, true)
  if ok and lines and #lines > 0 then
    return lines[1]
  end
  return ''
end

-- Monkey-patch compute_start_range to handle nil prev_line
local original_compute_start_range = sync._compute_start_range
sync._compute_start_range = function(a, b, prev_lines, curr_lines, bufnr)
  for i, line in ipairs(prev_lines or {}) do
    if line == nil or type(line) ~= 'string' then
      prev_lines[i] = safe_get_line(bufnr, i - 1)
    end
  end
  return original_compute_start_range(a, b, prev_lines, curr_lines, bufnr)
end
