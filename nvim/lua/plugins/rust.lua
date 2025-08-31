return {
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
    ft = 'rust',
    opts = function()
      local default_settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            -- runBuildScripts = true,
            buildScripts = {
              enable = true,
            },
          },
          -- Add clippy lints for Rust.
          checkOnSave = {
            allFeatures = true,
            command = 'clippy',
            extraArgs = { '--no-deps' },
          },
          procMacro = {
            enable = true,
            ignored = {
              ['async-trait'] = { 'async_trait' },
              ['napi-derive'] = { 'napi' },
              ['async-recursion'] = { 'async_recursion' },
            },
          },
        },
      }

      local on_attach = function(_, _bufnr)
        -- local lsp = vim.lsp

        -- lsp.handlers['textDocument/hover'] = lsp.with(vim.lsp.handlers.hover, {
        --   border = 'rounded',
        -- })

        -- vim.keymap.set('n', '<leader>co', function()
        --   vim.cmd.RustLsp 'openCargo'
        -- end, { desc = 'cargo.toml open', buffer = bufnr, silent = true })
        --
        -- vim.keymap.set('n', '<leader>cR', function()
        --   vim.cmd.RustLsp 'codeAction'
        -- end, { desc = 'rust code action', buffer = bufnr, silent = true })

        -- vim.keymap.set('n', '<leader>dr', function()
        --   vim.cmd.RustLsp 'debuggables'
        -- end, { desc = 'rust debuggables', buffer = bufnr })
      end
      return {
        tools = {
          code_actions = {
            ui_select_fallback = true,
          },
          float_win_config = {
            border = 'rounded',
          },
        },
        inlay_hints = {
          highlight = 'NonText',
        },
        -- tools = tools,
        server = {
          on_attach = on_attach,
          default_settings = default_settings,
        },
      }
    end,
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
    end,
  },
  {
    'saecki/crates.nvim',
    tag = 'stable',
    event = { 'BufRead Cargo.toml' },
    keys = {
      { '<space>ct', "<cmd>lua require('crates').toggle()<cr>", silent = true, desc = 'crates topplet' },
      { '<space>cf', "<cmd>lua require('crates').show_features_popup()<cr>", silent = true, desc = 'show features' },
      { '<space>cu', "<cmd>lua require('crates').update_all_crates()<cr>", silent = true, desc = 'update all crates' },
      { '<space>cU', "<cmd>lua require('crates').upgrade_crates()<cr>", silent = true, desc = 'upgrade crates' },
      { '<space>cD', "<cmd>lua require('crates').open_documentation()<cr>", silent = true, desc = 'open documentation' },
      { '<space>cR', "<cmd>lua require('crates').open_repository()<cr>", silent = true, desc = 'open repository' },
    },
    -- init = function()
    --   vim.api.nvim_create_autocmd('BufRead', {
    --     group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
    --     pattern = 'Cargo.toml',
    --     callback = function()
    --       require('cmp').setup.buffer { sources = { { name = 'crates' } } }
    --     end,
    --   })
    -- end,
    opts = {
      open_programs = { 'open' },
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
}
