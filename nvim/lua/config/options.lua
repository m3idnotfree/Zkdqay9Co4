local opt = vim.opt

-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L117
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

opt.backupdir = vim.fn.expand '$HOME/.config/nvim/backup'
opt.directory = vim.fn.expand '$HOME/.config/nvim/swap'
opt.undofile = true
opt.undolevels = 10000

opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.cursorline = true
opt.colorcolumn = '80'
opt.signcolumn = 'yes'
opt.ruler = false
opt.showmode = false
opt.laststatus = 3
-- https://www.swift.org/documentation/articles/zero-to-swift-nvim.html
opt.winbar = '%=%f%='

opt.list = false
opt.listchars = 'tab:> ,extends:…,precedes:…,nbsp:␣'
opt.fillchars = 'eob: '
opt.conceallevel = 2
opt.termguicolors = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = 'nosplit'
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.smartindent = true
opt.breakindent = true
-- o.formatoptions = 'qjl1' -- Don't autoformat comments
opt.formatoptions = 'jcroqlnt'

opt.wrap = false
opt.linebreak = true
opt.smoothscroll = true

opt.foldcolumn = '1'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldtext = ''

opt.completeopt = 'menu,menuone,noselect,noinsert'
opt.pumblend = 27
opt.pumheight = 10
opt.infercase = true
-- opt.wildmode = 'list:longest,list:full' -- don't insert, show options
opt.wildmode = 'longest:full,full'

opt.splitbelow = true
opt.splitright = true
opt.splitkeep = 'screen'
opt.winblend = 27
opt.winminwidth = 5

opt.scrolloff = 4
opt.sidescrolloff = 8
opt.jumpoptions = 'view'
opt.virtualedit = 'block'

opt.mouse = 'a'
opt.timeoutlen = 300
opt.updatetime = 200
opt.confirm = true

opt.shortmess:append { W = true, I = true, c = true, C = true }

for _, provider in ipairs { 'node', 'perl', 'python3', 'ruby' } do
  vim.g['loaded_' .. provider .. '_provider'] = 0
end

local disabled_built_ins = {
  '2html_plugin',
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
}

for _, plugin in ipairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end
