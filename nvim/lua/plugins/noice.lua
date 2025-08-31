return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  keys = {
    -- stylua: ignore start
    { '<leader>sn',  '',                                                                            desc = '+noice' },
    { '<S-Enter>',   function() require('noice').redirect(vim.fn.getcmdline()) end,                 desc = 'Redirect Cmdline', mode = 'c' },
    { '<leader>snl', function() require('noice').cmd 'last' end,                                    desc = 'Noice Last Message' },
    { '<leader>snh', function() require('noice').cmd 'history' end,                                 desc = 'Noice History' },
    { '<leader>sna', function() require('noice').cmd 'all' end,                                     desc = 'Noice All' },
    { '<leader>snd', function() require('noice').cmd 'dismiss' end,                                 desc = 'Dismiss All' },
    { '<leader>snt', function() require('noice').cmd 'pick' end,                                    desc = 'Noice Picker (Telescope/FzfLua)' },
    { '<c-f>',       function() if not require('noice.lsp').scroll(4) then return '<c-f>' end end,  desc = 'Scroll Forward',   silent = true, expr = true,   mode = { 'i', 'n', 's' } },
    { '<c-b>',       function() if not require('noice.lsp').scroll(-4) then return '<c-b>' end end, desc = 'Scroll Backward',  expr = true,   silent = true, mode = { 'i', 'n', 's' } },
    -- stylua: ignore end
  },
  opts = {
    lsp = {
      progress = {
        enabled = false,
        format = {
          '({data.progress.percentage}%) ',
          { '{spinner} ', hl_group = 'NoiceLspProgressSpinner' },
          { '{data.progress.title} ', hl_group = 'NoiceLspProgressTitle' },
          { '{data.progress.client} ', hl_group = 'NoiceLspProgressClient' },
        },
      },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        -- ['cmp.entry.get_documentation'] = true,
      },
      message = {
        view = 'mini',
      },
      signature = {
        enabled = false,
        view = 'bottompopup',
      },
      -- documentation = {
      --   view = 'bottompopup',
      -- },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
    routes = {
      {
        view = 'notify',
        filter = {
          event = 'notify',
          any = {
            { find = 'Changed to LSP root' },
            { find = 'LSP root' },
            { find = 'Project:' },
            { find = 'Directory:' },
          },
        },
        opts = {
          timeout = 2000,
        },
      },

      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true },
      },
      {
        -- view = 'mini',
        filter = {
          event = 'msg_show',
          any = {
            { find = '%d+L, %d+B' },
            { find = '; after #%d+' },
            { find = '; before #%d+' },
            { find = 'save' },
          },
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = 'msg_show',
          kind = 'emsg',
          find = 'E486',
        },
        opts = { skip = true },
      },
      -- {
      --   view = 'notify',
      --   filter = { event = 'msg_showmode' },
      -- },
      -- {
      --   view = 'mini',
      --   filter = {
      --     event = 'notify',
      --   },
      --   opts = {
      --     title = 'lazy.nvim',
      --   },
      -- },
      -- {
      --   filter = {
      --     event = 'msg_show',
      --     find = '/',
      --   },
      --   opts = { skip = true },
      -- },
      {
        filter = {
          event = 'notify',
          find = 'lazy%.nvim',
        },
        opts = { skip = true },
      },
      -- {
      --   filter = {
      --     event = 'notify',
      --     error = false,
      --     warning = false,
      --   },
      --   opts = {
      --     title = 'lazy.nvim',
      --     skip = true,
      --   },
      -- },
    },
    views = {
      -- tpopup = {
      --   backend = 'popup',
      --   relative = 'editor',
      --   focusable = false,
      --   enter = true,
      --   zindex = 210,
      --   format = { '{confirm}' },
      --   close = {
      --     events = { 'BufLeave' },
      --     keys = { 'q' },
      --   },
      --   border = {
      --     style = 'rounded',
      --     padding = { 0, 1 },
      --   },
      --   position = {
      --     row = '90%',
      --     col = '50%',
      --   },
      --   size = {
      --     width = '90%',
      --     height = '20%',
      --   },
      --   win_options = {
      --     winhighlight = { Normal = 'NoicePopup', FloatBorder = 'NoicePopupBorder' },
      --     winbar = '',
      --     foldenable = false,
      --     wrap = true,
      --     linebreak = true,
      --   },
      -- },
      bottompopup = {
        backend = 'popup',
        relative = 'editor',
        zindex = 45,
        border = {
          style = 'rounded',
          padding = { 0, 2 },
        },
        position = {
          row = '100%',
          col = '50%',
        },
        size = {
          min_width = 60,
          max_width = 120,
          max_height = 3,
          width = 'auto',
          height = 'auto',
        },
      },
      -- errormini = {
      --   backend = 'mini',
      --   relative = 'editor',
      --   timeout = 2000,
      --   reverse = true,
      --   focusable = false,
      --   zindex = 6,
      --   position = {
      --     row = '90%',
      --     col = '50%',
      --   },
      --   size = {
      --     width = '90%',
      --     height = '10%',
      --   },
      --   border = {
      --     style = { '', '─', '', '', '', '', '', '' },
      --   },
      -- },
    },
  },
}
