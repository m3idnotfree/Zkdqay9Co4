return {
  {
    'nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      fast_wrap = {},
    },
  },
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'nvim-ts-context-commentstring',
    },
    keys = {
      { 'gcc', desc = 'comment toggle current line' },
      { 'gc', mode = { 'n', 'o' }, desc = 'comment  toggle linewise' },
      { 'gc', mode = 'x', desc = 'comment toggle linewise (visual)' },
      { 'gbc', desc = 'comment toggle current block' },
      { 'gb', mode = { 'n', 'o' }, desc = 'comment  toggle blockwise' },
      { 'gb', mode = 'x', desc = 'comment toggle blockwise (visual)' },
    },
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    config = function(_, opts)
      require('Comment').setup(opts)

      local ft = require 'Comment.ft'
      ft.set('kdl', { '//%s', '/*%s*/' })
    end,
  },
  {
    'stevearc/conform.nvim',
    cond = not vim.g.vscode,
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    keys = {
      {
        '<leader>fq',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = { '' },
        desc = 'format buffer',
      },
    },
    init = function()
      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = 'Disable autoformat-on-save',
        bang = true,
      })
      vim.api.nvim_create_user_command('FormatEnable', function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = 'Re-enable autoformat-on-save',
      })
    end,
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'biome-check' },
        javascriptreact = { 'biome-check' },
        typescript = { 'biome-check' },
        typescriptreact = { 'biome-check' },
        -- json = { 'deno_fmt' },
        json = { 'biome' },
        toml = { 'taplo' },
        yaml = { 'yamlfmt' },
        html = { { 'prettier', 'rustywind' } },
        css = { 'prettier' },
        scss = { 'prettier' },
        sass = { 'prettier' },
        sh = { 'shfmt' },
        zsh = { 'shfmt' },
        markdown = { 'deno_fmt' },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      format_after_save = {
        lsp_fallback = true,
      },
      -- log_level = vim.log.levels.ERROR,
      notify_on_error = false,
    },
  },
}
