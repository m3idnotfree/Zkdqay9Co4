vim.keymap.set('n', '<leader>ll', '<cmd>:Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>lu', '<cmd>:Lazy update<cr>', { desc = 'Lazy' })

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = {
    { import = 'core' },
    { import = 'lazy_plugins.luasnip' },
    { import = 'lazy_plugins.flash' },
    { import = 'lazy_plugins.dial' },
    { import = 'lazy_plugins.enhance' },
  },
  defaults = {
    lazy = true,
  },
  install = {
    colorscheme = { 'gruvbox-material' },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'tutor',
        'rplugin',
        'syntax',
        'synmenu',
        'optwin',
        'compiler',
        'bugreport',
        'ftplugin',
        'editorconfig',
      },
    },
  },
  ui = {
    border = 'rounded',
  },
}
