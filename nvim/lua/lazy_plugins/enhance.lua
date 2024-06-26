return {

  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    dependencies = {
      { 'nvim-treesitter', build = ':TSUpdate' },
      'nvim-pqf',
    },
    opts = {},
  },

  {
    'ecthelionvi/neocomposer.nvim',
    dependencies = 'sqlite.lua',
    event = 'VeryLazy',
    cmd = { 'EditMacros', 'ClearNeoComposer' },
    keys = {
      { 'qe', '<cmd>EditMacros<cr>', desc = 'neocomposer toggle' },
    },
    opts = {
      keymaps = {
        play_macro = 'qp',
        toggle_record = 'qm',
      },
    },
  },
  {
    'ptdewey/yankbank-nvim',
    keys = {
      { '<space>y', '<cmd>YankBank<CR>', desc = 'yank bank' },
    },
    config = function()
      require('yankbank').setup()
    end,
  },
  {
    'Wansmer/treesj',
    keys = {
      { 'gs', "<cmd>lua require('treesj').toggle()<CR>", desc = 'splitjoin' },
    },
    dependencies = { 'nvim-treesitter' },
    opts = {
      use_default_keymaps = false,
      max_join_length = 500,
    },
  },
  {
    'mizlan/iswap.nvim',
    cmd = {
      'ISwap',
      'ISwapWith',
      'ISwapNode',
      'ISwapNodeWith',
    },
    keys = {
      { '<leader>is', '<cmd>ISwap<cr>', desc = 'ISwap' },
    },
    opts = {},
  },
}
