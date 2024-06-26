return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-nio',
      'plenary.nvim',
      'nvim-treesitter',
      'neotest-vitest',
      'rustaceanvim',
    },
    keys = {
      { '<leader>t', '', desc = '+test' },
      {
        '<leader>tt',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'run file',
      },
      {
        '<leader>tT',
        function()
          require('neotest').run.run(vim.uv.cwd())
        end,
        desc = 'run all test files',
      },
      {
        '<leader>tr',
        function()
          require('neotest').run.run()
        end,
        desc = 'run nearest',
      },
      {
        '<leader>tl',
        function()
          require('neotest').run.run_last()
        end,
        desc = 'run last',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'toggle summary',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true, auto_close = true }
        end,
        desc = 'show output',
      },
      {
        '<leader>tO',
        function()
          require('neotest').output_panel.toggle()
        end,
        desc = 'toggle output panel',
      },
      {
        '<leader>tS',
        function()
          require('neotest').run.stop()
        end,
        desc = 'stop',
      },
      {
        '<leader>tw',
        function()
          require('neotest').watch.toggle(vim.fn.expand '%')
        end,
        desc = 'toggle watch',
      },
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-vitest' {
            filter_dir = function(name, _rel_path, _root)
              return name ~= 'node_modules'
            end,
          },
        },
        require 'rustaceanvim.neotest',
      }
    end,
  },
}
