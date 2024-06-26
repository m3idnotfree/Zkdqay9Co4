return {
  'LuaSnip',
  version = 'v2.*',
  build = 'make install_jsregexp',
    --  stylua: ignore
    keys = {
    { '<tab>', function() return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>' end, expr = true, silent = true, mode = 'i' },
    { '<tab>', function() require('luasnip').jump(1) end, mode = 's' },
    { '<s-tab>', function() require('luasnip').jump(-1) end, mode = { 'i', 's' } },
},
  opts = {
    -- enable_autosnippets = true,
    delete_check_events = 'TextChanged',
  },
  config = function(_, opts)
    local ls = require 'luasnip'
    -- ls.setup(opts)
    if opts then
      ls.setup(opts)
    end
    vim.tbl_map(function(type)
      require('luasnip.loaders.from_' .. type).lazy_load()
    end, { 'vscode', 'snipmate', 'lua' })
    ls.filetype_extend('typescript', { 'tsdoc' })
    ls.filetype_extend('javascript', { 'jsdoc' })
    ls.filetype_extend('javascript', { 'typescript' })
    ls.filetype_extend('typescriptreact', { 'typescript' })
    ls.filetype_extend('NeogitCommitMessage', { 'gitcommit' })
    require('luasnip.loaders.from_lua').lazy_load { paths = { vim.fn.expand '~' .. '/.config/nvim/snippets' } }
  end,
}
