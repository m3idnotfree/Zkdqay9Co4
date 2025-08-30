local augroup = function(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua#L35
-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'last_loc',
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
      return
    end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankedHighlight', {}),
  pattern = '*',
  callback = function()
    vim.hl.on_yank { higroup = 'Reverse', timeout = 300 }
  end,
  desc = 'Highlight yanked text',
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup 'resize_splits',
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- HACK: re-caclulate folds when entering a buffer through Telescope
-- @see https://github.com/nvim-telescope/telescope.nvim/issues/699
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup 'fix_folds',
  callback = function()
    if vim.opt.foldmethod:get() == 'expr' then
      vim.schedule(function()
        vim.opt.foldmethod = 'expr'
      end)
    end
  end,
})

-- close q
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'man',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
    'LuaSnip',
    'grug-far',
    -- 'log',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        -- nowait = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'man_unlisted',
  pattern = { 'man' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup 'json_conceal',
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup 'auto_create_dir',
  callback = function(event)
    if event.match:match '^%w%w+:[\\/][\\/]' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- vim.api.nvim_create_autocmd({ 'BufWinLeave', 'BufWritePost', 'WinLeave' }, {
--   group = augroup 'save_view',
--   callback = function(event)
--     if vim.b[event.buf].view_activated then
--       vim.cmd.mkview { mods = { emsg_silent = true } }
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd('BufWinEnter', {
--   group = augroup 'load_view',
--   callback = function(event)
--     if not vim.b[event.buf].view_activated then
--       local filetype = vim.bo[event.buf].filetype
--       local buftype = vim.bo[event.buf].buftype
--       local ignore_filetypes = { 'gitcommit', 'gitrebase', 'svg', 'hgcommit' }
--       if buftype == '' and filetype and filetype ~= '' and not vim.tbl_contains(ignore_filetypes, filetype) then
--         vim.b[event.buf].view_activated = true
--         vim.cmd.loadview { mods = { emsg_silent = true } }
--       end
--     end
--   end,
-- })

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = augroup 'keymap_c',
  pattern = '*.keymap',
  callback = function()
    vim.bo.filetype = 'c'
  end,
})

vim.api.nvim_create_autocmd({ 'BufWinLeave', 'BufWritePost', 'WinLeave' }, {
  group = augroup 'FoldPersistence',
  pattern = '*',
  callback = function()
    if vim.bo.buftype == '' then
      vim.cmd 'silent! mkview'
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
  group = augroup 'FoldPersistence',
  pattern = '*',
  callback = function()
    if vim.bo.buftype == '' then
      vim.cmd 'silent! loadview'
    end
  end,
})
