return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  build = 'make install_jsregexp',
  event = 'VeryLazy',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    history = true,
    delete_check_events = 'TextChanged',
  },
  config = function(_, opts)
    local ls = require 'luasnip'
    ls.setup(opts)

    vim.tbl_map(function(type)
      require('luasnip.loaders.from_' .. type).lazy_load()
    end, { 'vscode', 'snipmate', 'lua' })

    -- ls.filetype_extend('typescript', { 'tsdoc' })
    -- ls.filetype_extend('javascript', { 'jsdoc' })
    -- ls.filetype_extend('javascript', { 'typescript' })
    -- ls.filetype_extend('typescriptreact', { 'typescript' })
    -- ls.filetype_extend('NeogitCommitMessage', { 'gitcommit' })
    -- require('luasnip.loaders.from_lua').lazy_load { paths = { vim.fn.expand '~' .. '/.config/nvim/snippets' } }
    -- require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.expand '~' .. '/.config/nvim/snippets/vscode' } }

    vim.api.nvim_create_autocmd('InsertLeave', {
      callback = function()
        if require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()] and not require('luasnip').session.jump_active then
          require('luasnip').unlink_current()
        end
      end,
    })
  end,
}
