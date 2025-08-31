return {
  'Wansmer/treesj',
  keys = {
    { 'gS', "<cmd>lua require('treesj').toggle()<cr>", { desc = 'Toggle splitjoin' } },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    use_default_keymaps = false,
    max_join_length = 200,
  },
}
