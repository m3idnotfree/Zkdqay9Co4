return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts_extend = { 'spec' },
  opts = {
    preset = 'helix',
    win = {
      wo = {
        winblend = 25,
      },
    },
    icons = { rules = false },
    spec = {},
  },
}
