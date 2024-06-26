return {
  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = 'markdown',
    cmd = { 'RenderMarkdownToggle' },
    keys = {
      { '<leader>rm', "<cmd>lua require('render-markdown').toggle()<cr>", desc = 'render markdown' },
    },
    config = function()
      require('render-markdown').setup {
        headings = { '1 ', '2. ', '3. ', '4. ', '5. ', '6. ' },
      }
    end,
  },
  {
    'lukas-reineke/headlines.nvim',
    enabled = false,
    ft = 'markdown',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = {},
  },
}
