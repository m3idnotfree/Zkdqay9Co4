local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local km = require 'M3Y.keymap'
local keymaps = km.keymaps
local leader = km.K.leader

keymaps(
  leader.n('ll', '<cmd>:Lazy<cr>', 'Lazy'),
  leader.n('lu', '<cmd>:Lazy update<cr>', 'Lazy update'),
  leader.n('lp', '<cmd>:Telescope lazy_plugins<cr>', 'Lazy plugins')
)

require('lazy').setup {
  spec = {
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
    { import = 'plugins' },
  },
  defaults = {
    lazy = true,
    version = false, -- always use the latest git commit
  },
  install = {
    colorscheme = { 'gruvbox-material' },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  ui = {
    border = 'rounded',
  },
}
