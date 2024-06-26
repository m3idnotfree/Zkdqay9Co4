return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = { 'Neotree' },
  dependencies = {
    'plenary.nvim',
    'nvim-web-devicons',
    'nui.nvim',
    'nvim-window-picker',
    'nvim-lsp-file-operations',
  },
  keys = {
    { '<leader>nn', '<cmd>Neotree toggle=true<cr>', desc = 'neotree toggle' },
    { '<leader>nd', '<cmd>Neotree document_symbols<cr>', desc = 'neotree document symboles' },
    { '<leader>nf', '<cmd>Neotree focus<cr>', desc = 'neotree focus' },
    { '<leader>ng', '<cmd>Neotree reveal<cr>', desc = 'neotree reveal' },
  },
  opts = function()
    return {
      sources = {
        'filesystem',
        'buffers',
        'git_status',
        'document_symbols',
      },
      window = {
        mappings = {
          ['l'] = { 'toggle_node', nowait = true },
          ['<space>'] = {
            'toggle_node',
            nowait = true,
          },
        },
      },
      filesystem = {
        use_libuv_file_watcher = true,
      },
      event_handlers = {
        -- auto close
        {
          event = 'file_opened',
          handler = function()
            require('neo-tree.command').execute { action = 'close' }
          end,
        },
      },
    }
  end,
}
