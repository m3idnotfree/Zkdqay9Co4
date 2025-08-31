return {
  'NeogitOrg/neogit',
  cmd = { 'Neogit' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  keys = {
    { '<space>gg', '<cmd>Neogit cwd=%:p:h<CR>', desc = 'neogit' },
  },
  opts = {},
}
