return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  dependencies = {
    'telescope-fzf-native.nvim',
    'telescope-symbols.nvim',
    -- 'nvim-telescope/telescope-project.nvim',
    -- 'nvim-telescope/telescope-file-browser.nvim',
  },
  cmd = 'Telescope',
  keys = {
    { '<leader>,', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', desc = 'buffers' },
    { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
    { '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', desc = 'find files' },
    { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = 'grep string' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'live grep' },
    { '<leader>?', '<cmd>Telescope oldfiles<cr>', desc = 'oldfiles' },
    { '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'current buffer fuzzy' },

    { '<leader>fd', "<cmd>lua require('telescope.builtin').diagnostics()<cr>", desc = 'diagnostics' },
    -- { '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', desc = 'document diagnostics' },
    -- { '<leader>sD', '<cmd>Telescope diagnostics<cr>', desc = 'workspace diagnostics' },
    -- { '<leader>sj', '<cmd>Telescope jumplist<cr>', desc = 'jumplist' },
    -- { '<space>fp', "<cmd>lua require'telescope'.extensions.project.project()<cr>", desc = 'project' },
  },
  opts = {
    defaults = {
      vimgrep_arguments = {
        'rg',
        '-L',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
      },
      prompt_prefix = ' ',
      selection_caret = '  ',
      sorting_strategy = 'ascending',
      results_title = false,
      layout_strategy = 'center',
      layout_config = {
        preview_cutoff = 1,
        width = function(_, max_columns, _)
          return math.min(max_columns, 80)
        end,
        height = function(_, _, max_lines)
          return math.min(max_lines, 15)
        end,
      },
      file_ignore_patterns = {
        'node_modules',
        'lazy-lock.json',
        '.vscode',
        'Cargo.lock',
        -- '^pnpm-lock.yaml',
      },
      path_display = { 'truncate' },
      border = true,
      borderchars = {
        prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
        results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
        preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      },
      color_devicons = true,
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      -- file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      -- grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      -- qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      -- buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
      mappings = {
        n = {
          ['q'] = function(...)
            return require('telescope.actions').close(...)
          end,
        },
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
          -- ['jk'] = require('telescope.actions').close,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    },

    pickers = {},
    -- symbols = {
    --   sources = { 'emoji', 'kaomoji', 'gitmoji' },
    -- },
    extensions_list = { 'fzf', 'macros' },
  },
  config = function(_, opts)
    local telescope = require 'telescope'
    telescope.setup(opts)

    for _, ext in ipairs(opts.extensions_list) do
      telescope.load_extension(ext)
    end
  end,
}
