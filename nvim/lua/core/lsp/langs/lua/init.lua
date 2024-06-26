local export = {}

export.settings = {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        checkThirdParty = false,
      },
      completion = {
        callSnippet = 'Replace',
      },
      -- diagnostics = {
      --   globals = { 'vim' },
      -- },
    },
  },
}

return export
