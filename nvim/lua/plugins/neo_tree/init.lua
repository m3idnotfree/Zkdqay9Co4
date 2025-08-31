local lsp_file_operations = require 'plugins.neo_tree.lsp-file-operations'
local window_picker = require 'plugins.neo_tree.window_picker'

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
    window_picker,
    -- lsp_file_operations,
  },
  cmd = { 'Neotree' },
  keys = {
    -- stylua: ignore start
    { '<leader>e', '<cmd>Neotree toggle=true<cr>', desc = 'neotree toggle' },
    { '<leader>E', '<cmd>Neotree reveal<cr>', desc = 'neotree reveal' },
    {'<leader>ge', function() require('neo-tree.command').execute { source = 'git_status', toggle = true } end, desc = 'Git Explorer',},
    {'<leader>be', function() require('neo-tree.command').execute { source = 'buffers', toggle = true } end, desc = 'Buffer Explorer',},
    -- stylua: ignore end
  },
  opts = function()
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end

    local events = require 'neo-tree.events'

    return {
      sources = {
        'filesystem',
        'buffers',
        'git_status',
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
          event = events.FILE_OPENED,
          handler = function()
            require('neo-tree.command').execute { action = 'close' }
          end,
        },
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      },
    }
  end,
}
