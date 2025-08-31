local config = require 'plugins.lsp.config'

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'yioneko/nvim-vtsls' },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = function()
      return {
        inlay_hints = config.inlay_hints,
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        servers = config.servers,
      }
    end,
    config = function(_, opts)
      require('lspconfig.ui.windows').default_options.border = 'rounded'

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local buffer = args.buf ---@type number
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- `rust-analyzer`
          if client and (not 'rust-analyzer' or client.name == 'rust-analyzer') then
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, buffer = buffer, desc = 'hover' })
          end
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { silent = true, buffer = buffer, desc = 'code action' })
          vim.keymap.set('n', '<leader>cl', '<cmd>LspInfo<cr>', { silent = true, buffer = buffer, desc = 'Lsp Info' })
        end,
      })

      -- inlay hints
      -- lsp_util.on_supports_method('textDocument/inlayHint', function(_, buffer)
      --   if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == '' and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype) then
      --     vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
      --   end
      -- end)

      -- code lens
      -- if vim.lsp.codelens then
      --   lsp_util.on_supports_method('textDocument/codeLens', function(_, buffer)
      --     vim.lsp.codelens.refresh()
      --     vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      --       buffer = buffer,
      --       callback = vim.lsp.codelens.refresh,
      --     })
      --   end)
      -- end

      require('M3Y.diagnostic').config()

      local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      local has_blink, blink = pcall(require, 'blink.cmp')

      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        -- has_blink and blink.get_lsp_capabilities() or {},
        has_blink and blink.get_lsp_capabilities({}, false) or {},
        opts.capabilities or {}
      )

      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      vim.lsp.config('vtsls', require('vtsls').lspconfig)

      for server, options in pairs(opts.servers) do
        vim.lsp.config(server, options)
        vim.lsp.enable(server)
      end
    end,
  },
}
