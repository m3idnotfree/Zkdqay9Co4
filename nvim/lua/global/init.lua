local M = {}

M.forEach = function(fn)
  return function(tbl)
    for k, v in pairs(tbl) do
      fn(v, k)
    end
  end
end

M.formatexpr = function()
  if require('lazy.core.config').spec.plugins['conform'] ~= nil then
    return require('conform').formatexpr()
  end
  return vim.lsp.formatexpr { timeout_ms = 3000 }
end
-- https://github.com/lunarmodules/Penlight/blob/master/lua/pl/utils.lua

_G.M3id = M

return M
