local map = vim.keymap.set
-- NOP
map('n', '<space>', '<Nop>', { desc = 'Space Nop' })
map('n', 'q', '<Nop>', { desc = 'q Nop' })
map('n', 'J', '<Nop>', { desc = 'J Nop' })
map('n', 'H', '<Nop>', { desc = 'H Nop' })
map('n', 'L', '<Nop>', { desc = 'L Nop' })
map('n', 's', '<Nop>', { desc = 's Nop' })
map('n', '<leader>s', '<cmd>w<cr>', { desc = 'Save' })

map('n', 'qq', '<cmd>q<cr>', { desc = 'Close' })
map('n', 'qb', '<cmd>bd<cr>', { desc = 'Close buffer' })
map('n', 'qa', '<cmd>qa<cr>', { desc = 'Close all' })
map('n', 'qf', '<cmd>q!<cr>', { desc = 'Close force' })

map('n', '<leader>wd', '<C-w>c', { remap = true, desc = 'Close window' })

map('n', '<C-u>', '<C-u>zz')
map('n', '<C-d>', '<C-d>zz')
map('n', '<PageUp>', '<C-d>zz')
map('n', '<PageDown>', '<C-d>zz')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
map({ 'x', 'o' }, 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map({ 'x', 'o' }, 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- better indenting
map('v', 'q', '<esc>')
map('v', '<', '<gv')
map('v', '>', '>gv')

-- better up/down
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'btr k' })
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'btr j' })

map('n', '<leader>o', function()
  local cur = vim.fn.line '.'
  vim.api.nvim_buf_set_lines(0, cur, cur, false, { '' })
  vim.api.nvim_command 'silent update'
end, { desc = 'Below newline' })

map('n', '<leader>O', function()
  local cur = vim.fn.line '.'
  cur = cur - 1
  vim.api.nvim_buf_set_lines(0, cur, cur, false, { '' })
  vim.api.nvim_command 'silent update'
end, { desc = 'Above newline' })

-- Remaps to try from theprimaegen
-- Don't move cursor when joining lines
map('n', 'J', 'mzJ`z')

map('n', '<M-Up>', '<cmd>resize -2<cr>', { desc = 'Resize -2' })
map('n', '<M-Down>', '<cmd>res +2<cr>', { desc = 'Resize +2' })
map('n', '<M-Left>', '<cmd>vertical resize -2<cr>', { desc = 'VResize -2' })
map('n', '<M-Right>', '<cmd>vert res +2<cr>', { desc = 'VResize +2' })

map('n', '<leader>1', '<cmd>mkview<cr>', { desc = 'mkview' })
map('n', '<leader>2', '<cmd>loadview<cr>', { silent = true, desc = 'loaview' })
map('n', '<leader>hs', '<cmd>nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>', { desc = 'nohlsearch' })
map('n', '<leader>cq', '<cmd>cclose<cr>', { desc = 'close quickfix' })
map('n', ']q', '<cmd>cnext<cr>', { desc = 'next quickfix' })
map('n', '[q', '<cmd>cnext<cr>', { desc = 'prev quickfix' })
