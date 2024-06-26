return {
  {
    'jsongerber/nvim-px-to-rem',
    ft = {
      'css',
      'scss',
      'sass',
    },
    config = true,
  },
  {
    'roginfarrer/cmp-css-variables',
    ft = { 'css', 'scss', 'sass' },
    init = function()
      vim.api.nvim_create_autocmd('BufRead', {
        group = vim.api.nvim_create_augroup('CmpSourceCss', { clear = true }),
        pattern = 'Cargo.toml',
        callback = function()
          require('cmp').setup.buffer { sources = { { name = 'css-variables' } } }
        end,
      })
    end,
  },
}
