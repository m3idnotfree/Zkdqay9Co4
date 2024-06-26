return {
  'which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 1000
  end,
  opts = {
    window = {
      border = 'single', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 25, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      zindex = 1000, -- positive value to position WhichKey above other floating windows.
    },
    -- defaults = {
    --   mode = { 'n', 'v' },
    -- ['g'] = { name = '+comment/dial' },
    -- ['gs'] = { name = '+surround' },
    -- ['z'] = { name = '+fold' },
    -- [']'] = { name = '+next' },
    -- ['['] = { name = '+prev' },
    -- ['<leader><tab>'] = { name = '+tabs' },
    -- ['<leader>b'] = { name = '+buffer' },
    -- ['<leader>c'] = { name = '+code' },
    -- ['<leader>f'] = { name = '+file/find' },
    -- ['<leader>g'] = { name = '+git' },
    -- ['<leader>gh'] = { name = '+hunks' },
    -- ['<leader>q'] = { name = '+quit/session' },
    -- ['<leader>s'] = { name = '+search' },
    -- ['<leader>u'] = { name = '+ui' },
    -- ['<leader>w'] = { name = '+windows' },
    -- ['<leader>x'] = { name = '+diagnostics/quickfix' },
    -- },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)

    wk.register({
      ['g'] = { name = '+comment/lsp' },
      ['s'] = { name = '+flash/surround' },
      ['['] = { name = '+prev' },
      [']'] = { name = '+next' },
      ['q'] = { name = '+quit' },
    }, { mode = 'n' })

    wk.register({
      ['g'] = { name = '+comment/dial' },
    }, { mode = 'v' })

    wk.register({
      ['h'] = { name = '+git/signs' },
      ['i'] = { name = '+inlay hint' },
      ['x'] = { name = '+trouble' },
      ['n'] = { name = '+neo tree/noice' },
      ['f'] = { name = '+telescope' },
      ['c'] = { name = '+lsp/crates' },
      ['g'] = { name = '+ssr/mini align' },
      ['r'] = { name = '+rename/markdown/lsp' },
      ['w'] = { name = '+window' },
    }, { prefix = '<leader>' })

    -- local i = {
    --   [' '] = 'Whitespace',
    --   ['"'] = 'Balanced "',
    --   ["'"] = "Balanced '",
    --   ['`'] = 'Balanced `',
    --   ['('] = 'Balanced (',
    --   [')'] = 'Balanced ) including white-space',
    --   ['>'] = 'Balanced > including white-space',
    --   ['<lt>'] = 'Balanced <',
    --   [']'] = 'Balanced ] including white-space',
    --   ['['] = 'Balanced [',
    --   ['}'] = 'Balanced } including white-space',
    --   ['{'] = 'Balanced {',
    --   ['?'] = 'User Prompt',
    --   _ = 'Underscore',
    --   a = 'Argument',
    --   b = 'Balanced ), ], }',
    --   c = 'Class',
    --   d = 'Digit(s)',
    --   e = 'Word in CamelCase & snake_case',
    --   f = 'Function',
    --   g = 'Entire file',
    --   o = 'Block, conditional, loop',
    --   q = 'Quote `, ", \'',
    --   t = 'Tag',
    --   u = 'Use/call function & method',
    --   U = 'Use/call without dot in name',
    -- }
    -- local a = vim.deepcopy(i)
    -- for k, v in pairs(a) do
    --   a[k] = v:gsub(' including.*', '')
    -- end
    --
    -- local ic = vim.deepcopy(i)
    -- local ac = vim.deepcopy(a)
    -- for key, name in pairs { n = 'Next', l = 'Last' } do
    --   i[key] = vim.tbl_extend('force', { name = 'Inside ' .. name .. ' textobject' }, ic)
    --   a[key] = vim.tbl_extend('force', { name = 'Around ' .. name .. ' textobject' }, ac)
    -- end
    -- require('which-key').register {
    --   mode = { 'o', 'x' },
    --   i = i,
    --   a = a,
    -- }
  end,
}
