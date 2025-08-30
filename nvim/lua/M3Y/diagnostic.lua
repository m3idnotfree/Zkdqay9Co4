local icons = require 'M3Y.icons'
local K = require('M3Y.keymap').K

return {
  config = function()
    vim.diagnostic.config {
      -- virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = icons.error,
          [vim.diagnostic.severity.WARN] = icons.warn,
          [vim.diagnostic.severity.HINT] = icons.hint,
          [vim.diagnostic.severity.INFO] = icons.info,
        },
      },
      underline = true,
      update_in_insert = false,
      float = {
        border = 'rounded',
        header = '',
        prefix = '',
      },
      severity_sort = true,
    }
  end,
  prev = function(lhs, severity)
    local s = severity and vim.diagnostic.severity[severity] or nil
    return K.n(lhs, function()
      vim.diagnostic.jump { count = -1, severity = s, float = true }
    end, K.desc('Prev ' .. severity))
  end,

  next = function(lhs, severity)
    local s = severity and vim.diagnostic.severity[severity] or nil
    return K.n(lhs, function()
      vim.diagnostic.jump { count = 1, severity = s, float = true }
    end, K.desc('Next ' .. severity))
  end,
}
