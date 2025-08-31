return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  lazy = false,
  keys = {
    { 'zR', "<cmd>lua require('ufo').openAllFolds()<cr>", desc = 'Ufo open all' },
    { 'zM', "<cmd>lua require('ufo').closeAllFolds()<cr>", desc = 'Ufo close all' },
    { 'zr', "<cmd>lua require('ufo').openFoldsExceptKinds()<cr>", desc = 'Ufo open fold except' },
    { 'zm', "<cmd>lua require('ufo').closeFoldsWith()<cr>", desc = 'Ufo close with' },
    { 'zK', "<cmd>lua require('ufo').peekFoldedLinesUnderCursor()<cr>", desc = 'Ufo peek' },
  },
  opts = {
    fold_virt_text_handler = require('M3Y.ufo').handler,
    provider_selector = function(_bufnr, _filetype, _buftype)
      return { 'treesitter', 'indent' }
    end,
  },
}
