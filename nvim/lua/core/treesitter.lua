local ensure_installed = {
  --lua, vim
  'lua',
  'vim',
  'vimdoc',
  -- web, javascript
  'html',
  'css',
  'scss',
  'javascript',
  'typescript',
  'tsx',
  -- data serialization
  'json',
  'jsonc',
  'kdl',
  'yaml',
  'toml',
  'ini',
  -- rust
  'rust',
  -- git
  'diff',
  'git_config',
  'gitcommit',
  'git_rebase',
  'gitignore',
  'gitattributes',
  'gitignore',
  -- text
  'markdown',
  'markdown_inline',
  -- haskell
  'haskell',
  'bash',
  'norg',
  'query',
  'regex',
  -- python
  'ninja',
  'python',
  'rst',
  -- qmk
  'c',
  'cpp',
  'devicetree',
  -- rest.nvim
  'xml',
  'http',
  'graphql',
}

local incremental_selection = {
  enable = true,
  keymaps = {
    init_selection = '<M-Space>', -- set to `false` to disable one of the mappings
    node_incremental = '<M-Space>',
    scope_incremental = false,
    node_decremental = '<bs>',
  },
}

local textobjects = {
  move = {
    enable = true,
    goto_next_start = {
      [']f'] = '@function.outer',
      [']c'] = '@class.outer',
    },
    goto_next_end = {
      [']F'] = '@function.outer',
      [']C'] = '@class.outer',
    },
    goto_previous_start = {
      ['[f'] = '@function.outer',
      ['[c'] = '@class.outer',
    },
    goto_previous_end = {
      ['[F'] = '@function.outer',
      ['[C'] = '@class.outer',
    },
  },
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    cmd = { 'TSUpdateSync' },
    dependencies = {
      'nvim-treesitter-textobjects',
      'nvim-ts-autotag',
    },
    opts = {
      ensure_installed = ensure_installed,
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = incremental_selection,
      textobjects = textobjects,
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end

      vim.defer_fn(function()
        require('nvim-treesitter.configs').setup(opts)
      end, 0)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    opts = { mode = 'cursor', max_lines = 3 },
  },
  { 'windwp/nvim-ts-autotag', lazy = false, config = true },
}
