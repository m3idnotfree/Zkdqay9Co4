-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/mini.lua
local ai_indent = function(ai_type)
  local spaces = (' '):rep(vim.o.tabstop)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local indents = {} ---@type {line: number, indent: number, text: string}[]

  for l, line in ipairs(lines) do
    if not line:find '^%s*$' then
      indents[#indents + 1] = { line = l, indent = #line:gsub('\t', spaces):match '^%s*', text = line }
    end
  end

  local ret = {} ---@type (Mini.ai.region | {indent: number})[]

  for i = 1, #indents do
    if i == 1 or indents[i - 1].indent < indents[i].indent then
      local from, to = i, i
      for j = i + 1, #indents do
        if indents[j].indent < indents[i].indent then
          break
        end
        to = j
      end
      from = ai_type == 'a' and from > 1 and from - 1 or from
      to = ai_type == 'a' and to < #indents and to + 1 or to
      ret[#ret + 1] = {
        indent = indents[i].indent,
        from = { line = indents[from].line, col = ai_type == 'a' and 1 or indents[from].indent + 1 },
        to = { line = indents[to].line, col = #indents[to].text },
      }
    end
  end

  return ret
end

local ai_buffer = function(ai_type)
  local start_line, end_line = 1, vim.fn.line '$'
  if ai_type == 'i' then
    -- Skip first and last blank lines for `i` textobject
    local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
    -- Do nothing for buffer with all blanks
    if first_nonblank == 0 or last_nonblank == 0 then
      return { from = { line = start_line, col = 1 } }
    end
    start_line, end_line = first_nonblank, last_nonblank
  end

  local to_col = math.max(vim.fn.getline(end_line):len(), 1)
  return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
end

return {
  {
    'echasnovski/mini.ai',
    version = false,
    dependencies = { 'nvim-treesitter-textobjects' },
    event = 'VeryLazy',
    main = 'mini.ai',
    opts = function()
      local ai = require 'mini.ai'

      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter { -- code block
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          },
          f = ai.gen_spec.treesitter {
            a = '@function.outer',
            i = '@function.inner',
          }, -- function
          c = ai.gen_spec.treesitter {
            a = '@class.outer',
            i = '@class.inner',
          }, -- class
          t = {
            '<([%p%w]-)%f[^<%w][^<>]->.-</%1>',
            '^<.->().*()</[^/]->$',
          }, -- tags
          d = { '%f[%d]%d+' }, -- digits
          e = { -- Word with case
            {
              '%u[%l%d]+%f[^%l%d]',
              '%f[%S][%l%d]+%f[^%l%d]',
              '%f[%P][%l%d]+%f[^%l%d]',
              '^[%l%d]+%f[^%l%d]',
            },
            '^().*()$',
          },
          -- i = ai_indent, -- indent
          g = ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function namew
        },
      }
    end,
    -- config = function(_, opts)
    --   require('mini.ai').setup(opts)
    -- end,
  },
  {
    'echasnovski/mini.surround',
    version = false,
    main = 'mini.surround',
    keys = {
      { 'sa', desc = 'add surround', mode = { 'n', 'v' } },
      { 'sd', desc = 'delete surround' },
      { 'sf', desc = 'find surround' },
      { 'sF', desc = 'find_left surround' },
      { 'sh', desc = 'highlight surround' },
      { 'sr', desc = 'replace surround' },
      { 'sn', desc = 'update n_line surround' },
    },
    opts = {
      custom_surroundings = {
        ['B'] = {
          input = { '%b{}', '^.().*().$' },
          output = { left = '{', right = '}' },
        },
        ['r'] = {
          input = { '%b[]', '^.().*().$' },
          output = { left = '[', right = ']' },
        },
        ['R'] = {
          input = { '%b<>', '^.().*().$' },
          output = { left = '<', right = '>' },
        },
      },
    },
    -- config = function(_, opts)
    --   require('mini.surround').setup(opts)
    -- end,
  },
  {
    'echasnovski/mini.move',
    version = false,
    main = 'mini.move',
    keys = {
      { '<M-j>', mode = { 'n', 'x', 'v' }, desc = 'move down' },
      { '<M-k>', mode = { 'n', 'x', 'v' }, desc = 'move up' },
      { '<M-h>', mode = { 'n', 'x', 'v' }, desc = 'move left' },
      { '<M-l>', mode = { 'n', 'x', 'v' }, desc = 'move right' },
    },
    config = function()
      require('mini.move').setup()
    end,
  },
  {
    'echasnovski/mini.bufremove',
    version = false,
    main = 'mini.bufremove',
    keys = {
      {
        'qw',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Delete Buffer',
      },
      {
        'qd',
        function()
          require('mini.bufremove').wipeout(0, false)
        end,
        desc = 'Delete Buffer',
      },
    },
    -- config = function()
    --   require('mini.bufremove').setup()
    -- end,
  },
  {
    'echasnovski/mini.align',
    version = false,
    main = 'mini.align',
    keys = { { '<space>ga', mode = { 'n', 'x' }, desc = 'mini align' } },
    -- config = function()
    --   require('mini.align').setup()
    -- end,
  },
  {
    'echasnovski/mini.indentscope',
    version = false,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    main = 'mini.indentscope',
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'lazy',
          'mason',
          'nvimtree',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    opts = function()
      local cym = function()
        if vim.g.vscode then
          return ''
        else
          return '│'
        end
      end

      return {
        draw = {
          animation = require('mini.indentscope').gen_animation.none(),
        },
        mappings = {
          -- Textobjects
          -- object_scope = '',
          -- object_scope_with_border = '',

          -- Motions (jump to respective border line; if not present - body line)
          goto_top = '[i',
          goto_bottom = ']i',
        },
        -- symbol = '│',
        symbol = cym(),
        options = {
          try_as_border = true,
        },
      }
    end,
    -- config = function(_, opts)
    --   require('mini.indentscope').setup(opts)
    -- end,
  },
  -- {
  --   'echasnovski/mini.clue',
  --   cond = not vim.g.vscode,
  --   event = 'VeryLazy',
  --   version = false,
  --   config = mini.clue.config,
  -- },
  -- M.clue = {
  --   triggers = {
  --     -- Leader triggers
  --     { mode = 'n', keys = '<Leader>' },
  --     { mode = 'x', keys = '<Leader>' },
  --
  --     -- Built-in completion
  --     { mode = 'i', keys = '<C-x>' },
  --
  --     -- `g` key
  --     { mode = 'n', keys = 'g' },
  --     { mode = 'x', keys = 'g' },
  --
  --     -- Marks
  --     { mode = 'n', keys = "'" },
  --     { mode = 'n', keys = '`' },
  --     { mode = 'x', keys = "'" },
  --     { mode = 'x', keys = '`' },
  --
  --     -- Registers
  --     { mode = 'n', keys = '"' },
  --     { mode = 'x', keys = '"' },
  --     { mode = 'i', keys = '<C-r>' },
  --     { mode = 'c', keys = '<C-r>' },
  --
  --     -- Window commands
  --     { mode = 'n', keys = '<C-w>' },
  --
  --     -- `z` key
  --     { mode = 'n', keys = 'z' },
  --     { mode = 'x', keys = 'z' },
  --
  --     -- 'a, i'
  --     { mode = 'o', keys = 'a' },
  --     { mode = 'x', keys = 'a' },
  --
  --     { mode = 'o', keys = 'i' },
  --     { mode = 'x', keys = 'i' },
  --
  --     { mode = 'n', keys = 's' },
  --     { mode = 'n', keys = '[' },
  --     { mode = 'n', keys = ']' },
  --   },
  --   clues = function(clue)
  --     return {
  --       -- Enhance this by adding descriptions for <Leader> mapping groups
  --       clue.gen_clues.builtin_completion(),
  --       clue.gen_clues.g(),
  --       clue.gen_clues.marks(),
  --       clue.gen_clues.registers(),
  --       clue.gen_clues.windows(),
  --       clue.gen_clues.z(),
  --       { mode = 'n', keys = '<Leader>f', desc = '+Telescope' },
  --       { mode = 'n', keys = '<Leader>n', desc = '+Noice,Neotree' },
  --       { mode = 'n', keys = '<Leader>x', desc = '+Trouble' },
  --       { mode = 'n', keys = '<Leader>r', desc = '+Refactor' },
  --       { mode = 'n', keys = '<Leader>w', desc = '+Workspace' },
  --       { mode = 'o', keys = 'ib', desc = 'balace' },
  --       { mode = 'x', keys = 'ib', desc = 'balace' },
  --     }
  --   end,
  --   config = function()
  --     local clue = require 'mini.clue'
  --     clue.setup {
  --       triggers = M.clue.triggers,
  --       clues = M.clue.clues(clue),
  --     }
  --   end,
  -- }
}
