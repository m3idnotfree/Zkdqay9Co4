local opt = vim.opt

opt.autowrite = true
opt.clipboard = 'unnamedplus'
opt.colorcolumn = '80'
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
opt.foldcolumn = '1'
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.formatoptions = 'jcroqlnt'
opt.laststatus = 3
opt.mouse = 'a'

opt.number = true
opt.numberwidth = 2
opt.pumblend = 27

opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 4

opt.shiftwidth = 2
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.wildmode = 'longest:full,full'
opt.winbar = '%=%f%='
opt.winblend = 27

opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true

opt.smoothscroll = true
opt.foldexpr = "v:lua.require'config.util'.foldexpr()"
opt.foldmethod = 'expr'
opt.foldtext = ''

opt.backupdir = vim.fn.expand '$NVIM_CONFIG/backup'
opt.directory = vim.fn.expand '$NVIM_CONFIG/swap'

for _, provider in ipairs { 'node', 'perl', 'python3', 'ruby' } do
  vim.g['loaded_' .. provider .. '_provider'] = 0
end

local is_windows = vim.loop.os_uname().sysname == 'Windows_NT'
vim.env.PATH = vim.fn.stdpath 'data' .. '/mason/bin' .. (is_windows and ';' or ':') .. vim.env.PATH
