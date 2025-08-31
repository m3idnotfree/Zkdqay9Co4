return {
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    opts = function()
      local ai = require 'mini.ai'
      return {
        n_lines = 500,
        custom_textobjects = {
          -- code block
          o = ai.gen_spec.treesitter {
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          },
          -- function
          f = ai.gen_spec.treesitter {
            a = '@function.outer',
            i = '@function.inner',
          },
          -- class
          c = ai.gen_spec.treesitter {
            a = '@class.outer',
            i = '@class.inner',
          },
          -- tags
          t = {
            '<([%p%w]-)%f[^<%w][^<>]->.-</%1>',
            '^<.->().*()</[^/]->$',
          },
          -- digits
          d = { '%f[%d]%d+' },
          -- Word with case
          e = {
            {
              '%u[%l%d]+%f[^%l%d]',
              '%f[%S][%l%d]+%f[^%l%d]',
              '%f[%P][%l%d]+%f[^%l%d]',
              '^[%l%d]+%f[^%l%d]',
            },
            '^().*()$',
          },
          -- i = ai_indent, -- indent
          -- -- buffer
          -- g = ai_buffer,
          -- u for "Usage"
          u = ai.gen_spec.function_call(),
          U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function namew
        },
      }
    end,
  },
  {
    'echasnovski/mini.surround',
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
  },
  {
    'echasnovski/mini.move',
    keys = {
      { '<M-j>', mode = { 'n', 'x', 'v' } },
      { '<M-k>', mode = { 'n', 'x', 'v' } },
      { '<M-h>', mode = { 'n', 'x', 'v' } },
      { '<M-l>', mode = { 'n', 'x', 'v' } },
    },
    opts = {},
  },
  {
    'echasnovski/mini.bufremove',
    keys = {
      -- stylua: ignore start
      { '<leader>bd', function() require('mini.bufremove').delete(0, false) end, desc = 'Delete Buffer' },
      { '<leader>bw', function() require('mini.bufremove').wipeout(0, false) end, desc = 'Wipeout Buffer' },
      -- stylua: ignore end
    },
    opts = {},
  },
  {
    'echasnovski/mini.indentscope',
    event = 'VeryLazy',
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
      local symbol = function()
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
        symbol = symbol(),
        options = {
          try_as_border = true,
        },
      }
    end,
  },
  {
    'echasnovski/mini.icons',
    lazy = false,
    specs = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      package.preload['nvim-web-devicons'] = function()
        require('mini.icons').mock_nvim_web_devicons()
        return package.loaded['nvim-web-devicons']
      end
    end,
    opts = {},
  },
}
