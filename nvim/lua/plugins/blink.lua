local cmdline = {
  enabled = true,
  completion = { menu = { auto_show = true } },
  keymap = {
    preset = 'inherit',
    ['<Tab>'] = { 'show', 'accept' },
    ['<CR>'] = { 'accept_and_enter', 'fallback' },
  },
}

local completion = {
  menu = {
    draw = {
      treesitter = { 'lsp' },
    },
    border = 'rounded',
    winblend = vim.o.pumblend,
  },
  documentation = {
    auto_show = true,
    treesitter_highlighting = true,
    window = {
      border = 'rounded',
      winblend = vim.o.pumblend,
    },
  },
}

local signature = {
  enabled = true,
  window = {
    border = 'rounded',
    winblend = vim.o.pumblend,
  },
}

local fuzzy = {
  implementation = 'lua',
}

local sources = {
  default = { 'lsp', 'path', 'snippets', 'buffer', 'dictionary' },
  per_filetype = {
    lua = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'dictionary' },
  },
  providers = {
    lazydev = {
      name = 'LazyDev',
      module = 'lazydev.integrations.blink',
      -- make lazydev completions top priority (see `:h blink.cmp`)
      score_offset = 100,
    },
    dictionary = {
      module = 'blink-cmp-dictionary',
      name = 'Dict',
      -- Make sure this is at least 2.
      -- 3 is recommended
      min_keyword_length = 3,
      opts = {
        -- options for blink-cmp-dictionary
      },
    },
    -- dadbod = { module = 'vim_dadbod_completion.blink' },
  },
}

return {
  'saghen/blink.cmp',
  version = '1.*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    {
      'Kaiser-Yang/blink-cmp-dictionary',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  opts = {
    keymap = { preset = 'default' },
    cmdline = cmdline,
    completion = completion,
    signature = signature,
    snippets = { preset = 'luasnip' },
    fuzzy = fuzzy,
    sources = sources,
  },
}
