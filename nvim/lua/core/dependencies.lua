return {
  -- https://www.lazyvim.org/plugins/ui#dressingnvim
  {
    'stevearc/dressing.nvim',
    lazy = true,
    cond = not vim.g.vscode,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require('lazy').load { plugins = { 'dressing.nvim' } }
        return vim.ui.input(...)
      end
    end,
  },
  { 'nvim-lua/plenary.nvim', lazy = true, module = true },
  { 'MunifTanjim/nui.nvim', lazy = true, module = true },
  { 'nvim-treesitter/nvim-treesitter', lazy = true, module = true },
  { 'nvim-treesitter/nvim-treesitter-textobjects', lazy = true, module = true },
  { 'nvim-tree/nvim-web-devicons', lazy = true, module = true },
  { 'sindrets/diffview.nvim', lazy = true, module = true },
  { 'ibhagwan/fzf-lua', lazy = true, module = true },
  { 'nvim-telescope/telescope.nvim', lazy = true, module = true },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    lazy = true,
    module = true,
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  },
  { 'nvim-telescope/telescope-symbols.nvim', lazy = true, module = true },
  -- 'nvim-telescope/telescope-project.nvim',
  -- 'nvim-telescope/telescope-file-browser.nvim',
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    module = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    's1n7ax/nvim-window-picker',
    version = '2.*',
    lazy = true,
    module = true,
    config = function()
      require('window-picker').setup {
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { 'terminal', 'quickfix' },
          },
        },
      }
    end,
  },
  {
    'antosha417/nvim-lsp-file-operations',
    lazy = true,
    module = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim',
    },
    opts = {
      debug = false,
      timeout_ms = 10000,
    },
  },
  { 'b0o/schemastore.nvim', lazy = true, version = false, module = true },
  { 'folke/which-key.nvim', lazy = true },
  { 'yioneko/nvim-vtsls', lazy = true, module = true },
  { 'hrsh7th/cmp-nvim-lsp', lazy = true },
  { 'windwp/nvim-autopairs', lazy = true },
  { 'L3MON4D3/LuaSnip', lazy = true },
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      progress = {
        poll_rate = 1,
        ignore_done_already = true,
        ignore_empty_message = true,
        display = {
          render_limit = 3,
        },
      },
    },
  },

  { 'ecthelionvi/neocomposer.nvim', lazy = true, module = true },
  { 'folke/noice.nvim', lazy = true, module = true },
  { 'hrsh7th/cmp-buffer', lazy = true, module = true },
  { 'hrsh7th/cmp-path', lazy = true, module = true },
  { 'hrsh7th/cmp-cmdline', lazy = true, module = true },
  { 'hrsh7th/nvim-cmp', lazy = true, module = true },
  { 'saadparwaiz1/cmp_luasnip', lazy = true, module = true },
  { 'dmitmel/cmp-cmdline-history', lazy = true, module = true },
  { 'hrsh7th/cmp-nvim-lsp-signature-help', lazy = true, module = true },
  { 'onsails/lspkind.nvim', lazy = true, module = true },
  { 'mfussenegger/nvim-dap', lazy = true, module = true },
  { 'kkharji/sqlite.lua', lazy = true, module = true },
  {
    'yorickpeterse/nvim-pqf',
    lazy = true,
    module = true,
    opts = {},
  },
  { 'nvim-neotest/nvim-nio', lazy = true, module = true },
  { 'marilari88/neotest-vitest', lazy = true, module = true },
  { 'mrcjkb/rustaceanvim', lazy = true, module = true },
}
