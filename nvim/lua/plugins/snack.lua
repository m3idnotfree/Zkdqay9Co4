return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- notifier = { enabled = true },
    bigfile = { enabled = true },
    -- explorer = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    -- quickfile = { enabled = true },
    words = { enabled = true },
    -- styles = {
    --   notification = {
    --     wo = { wrap = true }, -- Wrap notifications
    --   },
    -- },
  },
  keys = {
    -- stylua: ignore start
    -- LSP
    {'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition',},
    {'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration',},
    {'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References',},
    {'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation',},
    {'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition',},
    {'<leader>cR', function() Snacks.rename.rename_file() end, desc = 'Rename File',},
    -- Top Pickers & Explorer
    {'<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files',},
    {'<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers',},
    {'<leader>/', function() Snacks.picker.grep() end, desc = 'Grep',},
    {'<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History',},
    -- stylua: ignore start
    -- {'<leader>fg', function() Snacks.picker.git_files() end, desc = 'Find Git Files',},
    {'<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects',},
    {'<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent',},
    -- git
    {'<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git Branches',},
    {'<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log',},
    {'<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line',},
    {'<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status',},
    {'<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash',},
    {'<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)',},
    {'<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File',},
    -- Grep
    {'<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines',},
    {'<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers',},
    -- {'<leader>sg', function() Snacks.picker.grep { cwd = require('util.root').lazy_workspace_root() } end, desc = 'Grep',},
    {'<leader>sw', function() Snacks.picker.grep_word() end, desc = 'Visual selection or word', mode = { 'n', 'x' },},
    -- search
    {'<leader>s"', function() Snacks.picker.registers() end, desc = 'Registers',},
    {'<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History',},
    {'<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines',},
    {'<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History',},
    {'<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics',},
    {'<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics',},
    {'<leader>si', function() Snacks.picker.icons() end, desc = 'Icons',},
    {'<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps',},
    {'<leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List',},
    {'<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks',},
    {'<leader>sM', function() Snacks.picker.man() end, desc = 'Man Pages',},
    {'<leader>sp', function() Snacks.picker.lazy() end, desc = 'Search for Plugin Spec',},
    {'<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List',},
    {'<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume',},
    {'<leader>su', function() Snacks.picker.undo() end, desc = 'Undo History',},
    {'<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes',},
    {'<leader>ss', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols',},
    {'<leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols',},
    -- stylua: ignore end
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps {
          actions = {
            toggle_normal = function(picker)
              picker.opts.modes = { 'n' }
              picker:find()
            end,
            toggle_insert = function(picker)
              picker.opts.modes = { 'i' }
              picker:find()
            end,
            toggle_visual = function(picker)
              picker.opts.modes = { 'v', 'x' }
              picker:find()
            end,
            toggle_modes = function(picker)
              if #picker.opts.modes == 8 then
                picker.opts.modes = { 'n' }
              else
                if picker.opts.modes[1] == 'n' then
                  picker.opts.modes = { 'i' }
                elseif picker.opts.modes[1] == 'i' then
                  picker.opts.modes = { 'v', 'x' }
                else
                  picker.opts.modes = { 'n', 'v', 'x', 's', 'o', 'i', 'c', 't' }
                end
              end
              picker:find()
            end,
          },
          win = {
            input = {
              keys = {
                ['<a-n>'] = { 'toggle_normal', mode = { 'n', 'i' } },
                ['<a-i>'] = { 'toggle_insert', mode = { 'n', 'i' } },
                ['<a-v>'] = { 'toggle_visual', mode = { 'n', 'i' } },
                ['<a-n>'] = { 'toggle_modes', mode = { 'n', 'i' } },
              },
            },
          },
        }
      end,
      desc = 'Keymaps',
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
      end,
    })
  end,
}
