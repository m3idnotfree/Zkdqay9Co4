return {
  'mbbill/undotree',
  keys = {
    { '<leader>uu', '<cmd>:UndotreeToggle<CR>', desc = 'undo tree' },
  },
  init = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.Undotree_CustomMap = function()
      vim.keymap.set('n', 'k', '<plug>UndotreeNextState', { buffer = true, silent = true })
      vim.keymap.set('n', 'j', '<plug>UndotreePreviousState', { buffer = true, silent = true })
    end
  end,
}
