local M = {}
function M.formatexpr()
  if require('lazy.core.config').spec.plugins['conform'] ~= nil then
    return require('conform').formatexpr()
  end
  return vim.lsp.formatexpr { timeout_ms = 3000 }
end

return M
