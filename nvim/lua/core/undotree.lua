vim.g.undotree_WindowLayout = 2
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.Undotree_CustomMap = function()
  vim.keymap.set('n', 'k', '<plug>UndotreeNextState', { buffer = true })
  vim.keymap.set('n', 'j', '<plug>UndotreePreviousState', { buffer = true })
end

return {
  'mbbill/undotree',
  keys = {
    { '<leader>u', '<cmd>:UndotreeToggle<CR>', desc = '[Undotree]' },
  },
}
