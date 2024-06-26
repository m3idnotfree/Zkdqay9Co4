return function()
  local icons = { Error = '✘', Warn = '▲', Hint = '⚑', Info = '' }
  -- local diagnosticUI = {
  --   signs = true,
  --   underline = true,
  --   update_in_insert = false,
  --   float = {
  --     border = 'rounded',
  --     header = '',
  --     prefix = '',
  --   },
  -- }
  local diagnosticUI = {
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = icons.Error,
        [vim.diagnostic.severity.WARN] = icons.Warn,
        [vim.diagnostic.severity.HINT] = icons.Hint,
        [vim.diagnostic.severity.INFO] = icons.Info,
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

  -- for type, icon in pairs(icons) do
  --   local hl = 'DiagnosticSign' .. type
  --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  -- end

  vim.diagnostic.config(diagnosticUI)
end
