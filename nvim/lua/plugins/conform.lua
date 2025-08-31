return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  cmd = { 'ConformInfo', 'FormatDisable', 'FormatEnable' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
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
  opts = function()
    return {
      formatters = {
        ['markdown-toc'] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find '<!%-%- toc %-%->' then
                return true
              end
            end
          end,
        },
        ['markdownlint-cli2'] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == 'markdownlint'
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
        taplo = {
          args = { 'fmt', '-o', 'column_width=80', '-' },
        },
      },
      formatters_by_ft = {
        -- stylua: ignore start
        lua             = { 'stylua' },
        javascript      = { 'biome-check' },
        javascriptreact = { 'biome-check' },
        typescript      = { 'biome-check' },
        typescriptreact = { 'biome-check' },
        json         = { 'deno_fmt' },
        -- json            = { 'biome' },
        toml            = { 'taplo' },
        yaml            = { 'yamlfmt' },
        html            = { { 'prettier', 'rustywind' } },
        css             = { 'prettier' },
        scss            = { 'prettier' },
        sass            = { 'prettier' },
        sh              = { 'shfmt' },
        zsh             = { 'shfmt' },
        markdown        = { 'prettier', 'markdownlint-cli2', "markdown-toc" },
        kdl             = { 'kdlfmt' },
        -- stylua: ignore end
      },
      default_format_opts = {
        lsp_format = 'fallback',
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = 'fallback' }
      end,
      format_after_save = {
        lsp_fallback = true,
      },
      -- log_level = vim.log.levels.ERROR,
      -- notify_on_error = false,
    }
  end,
}
