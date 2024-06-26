return {
  { import = 'core.lsp.langs.markdown' },
  { import = 'core.lsp.langs.typescript.extends' },
  { import = 'core.lsp.langs.css' },
  { import = 'core.lsp.langs.rust' },
  { import = 'core.lsp.langs.lua.extends' },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      'nvim-vtsls',
      'cmp-nvim-lsp',
    },
    opts = function()
      local nvim_lsp = require 'lspconfig'

      local langs = require 'core.lsp.langs'

      -- local tsserver = {
      --   root_dir = nvim_lsp.util.root_pattern 'package.json',
      --   single_file_support = false,
      --   on_attach = langs.typescript.on_attach,
      --   settings = langs.typescript.settings,
      --   handlers = langs.typescript.handlers,
      -- }

      local denols = {
        root_dir = nvim_lsp.util.root_pattern('deno.json', 'deno.jsonc'),
      }

      return {
        denols = denols,
        biome = {},
        html = {},
        cssls = {},
        stylelint_lsp = langs.stylelint,
        tailwindcss = langs.tailwindcss,
        lua_ls = langs.lua.settings,
        jsonls = langs.json.settings,
        yamlls = langs.yaml.settings,
        taplo = {},
        bashls = {
          filetypes = { 'sh', 'zsh' },
        },
        -- ruff_lsp = {},
        -- clangd = {},
      }
    end,
    config = function(_, opts)
      require('lspconfig.ui.windows').default_options.border = 'rounded'
      -- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      -- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
      -- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

      local cmp_nvim_lsp = require 'cmp_nvim_lsp'

      local capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

      local diagnostic_goto = function(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
          go { severity = severity }
        end
      end

      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Lsp diagnostic open float' })
      -- map('n', ']d', diagnostic_goto(true), opt 'Next Diagnostic')
      -- map('n', '[d', diagnostic_goto(false), opt 'Prev Diagnostic')
      vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'next error' })
      vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'prev error' })
      vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'next warning' })
      vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'prev warning' })
      --     -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { desc = 'Lsp diagnostic setloclist' })

      vim.keymap.set('n', '<leader>ih', '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>', { desc = 'toggle inlay hints' })

      require 'core.lsp.diagnostic'()

      local configs = require 'lspconfig.configs'
      -- local sf = require('lspconfig/')

      configs.zk = {
        default_config = {
          cmd = { 'zk', 'lsp' },
          filetypes = { 'markdown' },
          root_dir = function()
            return vim.loop.cwd()
          end,
          settings = {},
        },
      }
      require('lspconfig').zk.setup {
        on_attach = function(client, buffer)
          -- Add keybindings here, see https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
        end,
      }

      require('lspconfig.configs').vtsls = require('vtsls').lspconfig
      -- If the lsp setup is taken over by other plugin, it is the same to call the counterpart setup function
      require('lspconfig').vtsls.setup {
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = 'always' },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = 'literals' },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
      }

      for server, options in pairs(opts) do
        local setting = vim.tbl_deep_extend('force', { capabilities = capabilities }, options)
        require('lspconfig')[server].setup(setting)
      end
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {

      'cmp-nvim-lsp',
      'cmp-buffer',
      'cmp-path',
      'cmp-cmdline',
      'nvim-cmp',

      'LuaSnip',
      'cmp_luasnip',
      -- 'petertriho/cmp-git',

      'cmp-cmdline-history',

      'cmp-nvim-lsp-signature-help',
      'lspkind.nvim',
      'nvim-autopairs',
      -- 'lukas-reineke/cmp-rg',
      -- 'lukas-reineke/cmp-under-comparator',
      -- crates
    },
    config = function()
      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })

      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      local defaults = require 'cmp.config.default'()

      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

      cmp.setup {
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = function(_, item)
            -- local MAX = 10
            item.abbr = item.abbr:match '[^(]+'

            -- if string.len(item.abbr) > MAX then
            --   item.abbr = string.sub(item.abbr, 1, 10) .. ELLIPSIS_CHAR
            -- end

            -- item.abbr = string.sub(item.abbr, 1, 10)

            if item.menu ~= nil then
              -- item.menu = item.menu:match '/[^(?:(use )].+$/gm'
              item.menu = string.sub(item.menu, 1, 25)
            -- item.abbr = string.sub(item.abbr, 1, 10) .. ELLIPSIS_CHAR
            else
            end

            item.kind = string.lower(string.sub(item.kind, 1, 3))

            return item
          end,
          expandable_indicator = true,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered {
            -- scrollbar = true,
          },
          documentation = {
            border = 'rounded',
            max_width = 0,
          },
          -- documentation = cmp.config.window.bordered {
          --   -- scrollbar = true,
          -- },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-Tab>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources({
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
        experimental = {
          ghost_text = {
            hl_group = 'CmpGhostText',
          },
        },
        sorting = defaults.sorting,
      }
      -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
      -- Set configuration for specific filetype.
      --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline {
          ['<space>'] = {
            c = cmp.mapping.confirm { select = false },
          },
        },
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
  {
    'folke/trouble.nvim',
    -- branch = 'dev',
    cmd = { 'TroubleToggle', 'Trouble' },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'diagnostics (trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'buffer diagnostics (trouble)' },
      { '<leader>cs', '<md>Trouble symbols toggle focus=false<cr>', desc = 'symbols (trouble)' },
      { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'lsp definitions / references / ... (trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'location list (trouble)' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'quickfix list (trouble)' },
    },
    init = function()
      -- local win = vim.api.nvim_get_current_win()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'Trouble',
        callback = function()
          -- vim.api.nvim_win_set_option(win, 'wrap', true)
          vim.opt.wrap = true
        end,
      })
    end,
    opts = {
      heigh = 8,
      mode = 'document_diagnostics',
      indent_lines = false,
      auto_open = false,
      use_diagnostic_signs = true,
    },
  },
  {
    'lewis6991/hover.nvim',
    keys = {
      { 'K', desc = '"hover.nvim"' },
      { 'gK', desc = '"hover.nvim (select)"' },
      -- { '<C-p>', desc = '"hover.nvim (previous source)"' },
      -- { '<C-n>', desc = '"hover.nvim (next source)"' },
    },
    config = function()
      require('hover').setup {
        init = function()
          -- Require providers
          require 'hover.providers.lsp'
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          -- require('hover.providers.jira')
          -- require('hover.providers.dap')
          -- require('hover.providers.man')
          -- require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = 'single',
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
        mouse_providers = {
          'LSP',
        },
        mouse_delay = 1000,
      }

      -- Setup keymaps
      vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
      vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })
      vim.keymap.set('n', '<C-p>', function()
        require('hover').hover_switch 'previous'
      end, { desc = 'hover.nvim (previous source)' })
      vim.keymap.set('n', '<C-n>', function()
        require('hover').hover_switch 'next'
      end, { desc = 'hover.nvim (next source)' })

      -- Mouse support
      vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
      vim.o.mousemoveevent = true
    end,
  },
  -- {
  --   'RRethy/vim-illuminate',
  --   -- event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  --   event = 'VeryLazy',
  --   opts = {
  --     delay = 200,
  --     large_file_cutoff = 2000,
  --     large_file_overrides = {
  --       providers = { 'lsp' },
  --     },
  --     filetypes_denylist = {
  --       'NvimTree',
  --       'OUTLINE',
  --     },
  --   },
  --   config = function(opts)
  --     require('illuminate').configure(opts)
  --     local function map(key, dir, buffer)
  --       vim.keymap.set('n', key, function()
  --         require('illuminate')['goto_' .. dir .. '_reference'](false)
  --       end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer, silent = true })
  --     end
  --
  --     map(']]', 'next')
  --     map('[[', 'prev')
  --
  --     -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
  --     vim.api.nvim_create_autocmd('FileType', {
  --       callback = function()
  --         local buffer = vim.api.nvim_get_current_buf()
  --         map(']]', 'next', buffer)
  --         map('[[', 'prev', buffer)
  --       end,
  --     })
  --   end,
  --   keys = {
  --     { ']]', desc = 'Next Reference' },
  --     { '[[', desc = 'Prev Reference' },
  --   },
  -- },
}
