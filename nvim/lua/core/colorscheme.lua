return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000,
    lazy = false,
    init = function()
      vim.g.gruvbox_material_background = 'soft'
      vim.g.gruvbox_material_better_performance = 1

      vim.cmd [[colorscheme gruvbox-material]]
    end,
  },
  {
    'slugbyte/lackluster.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    -- init = function()
    -- vim.cmd.colorscheme 'lackluster'
    -- vim.cmd.colorscheme 'lackluster-hack' -- my favorite
    --   vim.cmd.colorscheme 'lackluster-mint'
    -- end,
  },
}
