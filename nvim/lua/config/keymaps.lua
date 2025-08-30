local n, i, v, x, o, nx, leader, ctrl, r, ex, keymaps = require('M3Y.keymap').all()

local diagnostic = require 'M3Y.diagnostic'

keymaps(
  leader.n('hs', '<cmd>!git add %<cr>', 'git add current buffer'),
  n('q', '<Nop>', 'Disabled macro recording'),
  leader.n('q', '<cmd>q<cr>', 'Quit '),
  leader.n('Q', '<cmd>qa<cr>', 'Quit all'),
  v('q', '<esc>'),

  nx('j', "v:count == 0 ? 'gj' : 'j'", 'Down', ex),
  nx('k', "v:count == 0 ? 'gk' : 'k'", 'Up', ex),

  ctrl.n('s', '<cmd>w<cr>', 'Save file'),
  ctrl.i('s', '<cmd>w<cr><esc>', 'Save file and exit insert'),

  leader.n('cg', require('M3Y.root').sync_directory, 'Smart CD (git root or current file)'),

  ctrl.n('h', '<C-w>h', 'Go to left window', r),
  ctrl.n('j', '<C-w>j', 'Go to lower window', r),
  ctrl.n('k', '<C-w>k', 'Go to upper window', r),
  ctrl.n('l', '<C-w>l', 'Go to right window', r),

  leader.n('-', '<C-W>s', 'Split window below', r),
  leader.n('|', '<C-W>v', 'Split window right', r),
  leader.n('wd', '<C-W>c', 'Delete Window', r),

  n('<M-Up>', '<cmd>resize +2<cr>', 'Increase window height'),
  n('<M-Down>', '<cmd>resize -2<cr>', 'Decrease window height'),
  n('<M-Left>', '<cmd>vertical resize -2<cr>', 'Decrease window width'),
  n('<M-Right>', '<cmd>vertical resize +2<cr>', 'Increase window width'),

  -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
  n('n', "'Nn'[v:searchforward].'zv'", 'Next Search Result', ex),
  x('n', "'Nn'[v:searchforward]", 'Next Search Result', ex),
  o('n', "'Nn'[v:searchforward]", 'Next Search Result', ex),
  n('N', "'nN'[v:searchforward].'zv'", 'Prev Search Result', ex),
  x('N', "'nN'[v:searchforward]", 'Prev Search Result', ex),
  o('N', "'nN'[v:searchforward]", 'Prev Search Result', ex),

  i(',', ',<c-g>u', "add ',' Undo break point"),
  i('.', '.<c-g>u', "add '.' Undo break point"),
  i(';', ';<c-g>u', "add ';' Undo break point"),

  v('<', '<gv'),
  v('>', '>gv'),

  ctrl.n('d', '<C-d>zz'),
  ctrl.n('u', '<C-u>zz'),
  n('<PageUp>', '<C-u>zz'),
  n('<PageDown>', '<C-d>zz'),

  n('J', 'mzJ`z'),

  n('*', '*zzzv'),
  n('#', '#zzzv'),

  diagnostic.next(']e', 'ERROR'),
  diagnostic.prev('[e', 'ERROR'),
  diagnostic.next(']w', 'WARN'),
  diagnostic.prev('[w', 'WARN'),
  leader.n('cd', vim.diagnostic.open_float, 'line diagnostics'),

  leader.nv('d', '"_d', 'Delete without yanking'),
  v('p', '"_dP', 'Paste without yanking'),

  leader.n('m', 'q', 'macro recording'),
  leader.n('ur', '<cmd>noh<cr><esc>', 'Escape and clear hlsearch'),

  leader.n('uh', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, 'Toggle inlay hints'),

  leader.n('rn', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', 'Replace word under cursor'),
  leader.n('<leader>x', '<cmd>source %<cr>', 'Source current file'),

  leader.n('rf', function()
    local file = vim.fn.expand '%:p'

    if file == '' then
      vim.notify('No file in current buffer', vim.log.levels.WARN)
      return
    end

    local cmd
    if vim.fn.has 'mac' == 1 then
      cmd = 'open -R ' .. vim.fn.shellescape(file)
    elseif vim.fn.has 'win32' == 1 or vim.fn.has 'win64' == 1 then
      cmd = 'explorer /select,' .. vim.fn.shellescape(file)
    else
      if vim.fn.executable 'nautilus' == 1 then
        cmd = 'nautilus --select ' .. vim.fn.shellescape(file)
      elseif vim.fn.executable 'dolphin' == 1 then
        cmd = 'dolphin --select ' .. vim.fn.shellescape(file)
      elseif vim.fn.executable 'thunar' == 1 then
        cmd = 'thunar ' .. vim.fn.shellescape(vim.fn.fnamemodify(file, ':h'))
      elseif vim.fn.executable 'xdg-open' == 1 then
        cmd = 'xdg-open ' .. vim.fn.shellescape(vim.fn.fnamemodify(file, ':h'))
      else
        vim.notify('No supported file manager found', vim.log.levels.ERROR)
        return
      end
    end

    vim.fn.jobstart(cmd, { detach = true })
    vim.notify('Revealed: ' .. vim.fn.fnamemodify(file, ':t'))
  end, 'Reveal file in explorer')
)
