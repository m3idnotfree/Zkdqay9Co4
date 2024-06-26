local colors = {
  white = '#dcd7ba',
  fg0 = '#d4be98',
  fg1 = '#ddc7a1',
  red = '#ea6962',
  orange = '#e78a4e',
  orange2 = '#ff9e64',
  yellow = '#d8a657',
  green = '#a9b665',
  aqua = '#89b482',
  blue = '#7daea3',
  purple = '#d3869b',
  bright_yellow = '#fabd2f',
  bright_red = '#fb4934',
  bright_orange = '#fe8019',
  bg_red = '#ea6962',
  bg_green = '#a9b665',
  bg_yellow = '#d8a657',
  gray = '#44475a',
  neural_green = '#98971a',
  modified = '#c70039',
}

local theme = {
  normal = {
    a = { fg = colors.fg0 },
    b = { fg = colors.fg0 },
    c = { fg = colors.fg0 },
  },
  insert = {
    -- a = { fg = colors.gruvbox_bright_blue, gui = "bold" },
    a = { fg = colors.blue },
    b = { fg = colors.fg0 },
    c = { fg = colors.fg0 },
  },
  visual = {
    a = { fg = colors.bright_orange },
    b = { fg = colors.white },
    c = { fg = colors.white },
  },
  replace = {
    -- a = { fg = colors.green, gui = "bold" },
    a = { fg = colors.green },
    b = { fg = colors.white },
    c = { fg = colors.white },
  },
  command = {
    -- a = { fg = colors.orange, gui = "bold" },
    -- b = { fg = colors.white },
    -- c = { fg = colors.white },
  },
  inactive = {
    -- a = { fg = colors.gray, gui = "bold" },
    a = { fg = colors.gray },
    b = { fg = colors.white },
    -- c = { fg = colors.neural_green, bg = colors.gruvbox_dark1 },
    c = { fg = colors.neural_green },
  },
}

local trunc = function(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

local custom_fname = function()
  local custom_fname = require('lualine.components.filename'):extend()
  local highlight = require 'lualine.highlight'
  local default_status_colors = { saved = '', modified = '#ea6962' }

  function custom_fname:init(options)
    custom_fname.super.init(self, options)
    self.status_colors = {
      saved = highlight.create_component_highlight_group(
        -- { bg = default_status_colors.saved }, 'filename_status_saved', self.options),
        { fg = default_status_colors.saved },
        'filename_status_saved',
        self.options
      ),
      modified = highlight.create_component_highlight_group(
        -- { bg = default_status_colors.modified }, 'filename_status_modified', self.options),
        { fg = default_status_colors.modified },
        'filename_status_modified',
        self.options
      ),
    }
    if self.options.color == nil then
      self.options.color = ''
    end
  end

  function custom_fname:update_status()
    local data = custom_fname.super.update_status(self)
    data = highlight.component_format_highlight(vim.bo.modified and self.status_colors.modified or self.status_colors.saved) .. data
    return data
  end
end

local string_padding = function()
  local ci = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
  -- local height = vim.api.nvim_win_get_height(vim.api.nvim_get_current_win())
  local bheight = vim.api.nvim_buf_line_count(0)
  local row, col = ci[1], ci[2]

  col = col + 1

  return string.format('%02d [%03d/%03d]', col, row, bheight)
end

local modified = function()
  -- local changed = {
  --   modified = vim.api.nvim_buf_get_option(0, 'modified'),
  --   readonly = vim.api.nvim_buf_get_option(0, 'modifiable'),
  -- }
  local buf_modified = vim.api.nvim_buf_get_option(0, 'modified')
  -- local buf_readonly = vim.api.nvim_buf_get_option(0, 'readonly')
  local buf_modifiable = vim.api.nvim_buf_get_option(0, 'modifiable')
  -- local buf_buftype = vim.api.nvim_buf_get_option(0, 'buftype')
  -- local buf_filetype = vim.api.nvim_buf_get_option(0, 'filetype')

  -- print(vim.inspect(vim.api.nvim_get_all_options_info()))
  local modified_format = function(color, icon)
    color = string.format('%%#%s#', color)
    return string.format('[%s%s%s]', color, icon, '%#Normal#')
  end
  if buf_modifiable ~= true then
    -- return "%#Comment#[x]"
    -- return modified_format('Comment', '-')
    return string.format('[%s]', '-')
  end

  if buf_modified then
    -- return "%#Error#[+]"
    -- return modified_format('Error', '+')
    return string.format('[%s]', '+')
  else
    return '[ ]'
  end
end

local lsp_active = function()
  local msg = 'No Active Lsp'
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

return {
  {
    'nvim-lualine/lualine.nvim',
    cond = not vim.g.vscode,
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-web-devicons',
      'noice.nvim',
      'neocomposer.nvim',
    },
    config = function()
      -- local lualine_util = require 'config.plugins.ui.util.lualine'

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = theme,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              '',
              -- padding = { left = 0, right = 1 },
            },
            {
              'mode',
              -- padding = { left = 0, right = 0 },
              fmt = function(str)
                return string.lower(str:sub(1, 2))
              end,
            },
            { modified },
          },
          lualine_b = {
            { 'branch', fmt = trunc(80, 4, nil, true) },
            'diff',
          },
          lualine_c = {
            -- '%=',
            -- { custom_fname },
            {
              'diagnostics',
              sections = { 'error', 'warn', 'info', 'hint' },
              symbols = { error = '✘ ', warn = '▲ ', info = '⚑ ', hint = ' ' },
              always_visible = true,
            },
            -- { lsp_active },
          },
          lualine_x = {
            {
              require('noice').api.status.message.get_hl,
              cond = require('noice').api.status.message.has,
              -- color = { fg = '#ff9e64' },
              color = { fg = colors.orange2 },
            },
            {
              require('noice').api.status.command.get,
              cond = require('noice').api.status.command.has,
              -- color = { fg = '#ff9e64' },
              color = { fg = colors.orange2 },
            },
            {
              require('noice').api.status.mode.get,
              cond = require('noice').api.status.mode.has,
              -- color = { fg = '#ff9e64' },
              color = { fg = colors.orange2 },
            },
            {
              require('noice').api.status.search.get,
              cond = require('noice').api.status.search.has,
              -- color = { fg = '#ff9e64' },
              color = { fg = colors.orange2 },
            },
            { require('NeoComposer.ui').status_recording },
          },
          lualine_z = {
            { string_padding },
            -- { 'progress', padding = { left = 0, right = 0 } },
            -- { 'location', padding = { left = 1, right = 0 } },
            {
              padding = { right = 0, left = 1 },
            },
          },
        },
      }
    end,
  },
  {
    'folke/noice.nvim',
    -- cond = vim.g.vscode ~= true,
    cond = not vim.g.vscode,
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nui.nvim',
      -- 'rcarriga/nvim-notify',
    },
    keys = {
      {
        '<space>nh',
        function()
          require('noice').cmd 'history'
        end,
        desc = 'noice history',
      },
      {
        '<space>nl',
        function()
          require('noice').cmd 'last'
        end,
        desc = 'noice last',
      },
      { '<space>ne', '<cmd>Noice errors<cr>', desc = 'noice errors' },
      {
        '<space>na',
        function()
          require('noice').cmd 'all'
        end,
        desc = 'noice all',
      },
      {
        '<space>nm',
        function()
          require('noice').cmd 'dismiss'
        end,
        desc = 'noice dismiss',
      },
      -- { '<space>ns', '<cmd>Noice stats<cr>', desc = 'Noice errors' },
    },
    opts = {
      -- commands = {
      --   last = {
      --     view = 'tpopup',
      --   },
      --   errors = {
      --     view = 'tpopup',
      --   },
      -- },
      -- messages = {
      --   view = 'mini',
      --   view_warn = 'errormini',
      --   view_error = 'messages',
      -- },
      -- notify = {
      --   view = 'mini',
      -- },
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
          ['cmp.entry.get_documentation'] = true,
        },
        message = {
          view = 'mini',
        },
        signature = {
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
        -- inc_rename = false,
        -- lsp_doc_border = true,
      },
      routes = {
        -- {
        --   filter = {
        --     event = 'msg_show',
        --     kind = '',
        --     find = 'written',
        --   },
        --   opts = { skip = true },
        -- },
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
              { find = 'save' },
            },
          },
          -- view = 'mini',
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
        --   view = 'mini',
        --   filter = {
        --     event = 'notify',
        --   },
        --   opts = {
        --     title = 'lazy.nvim',
        --   },
        -- },
        {
          filter = {
            event = 'msg_show',
            find = '/',
          },
          opts = { skip = true },
        },
      },
      views = {
        tpopup = {
          backend = 'popup',
          relative = 'editor',
          focusable = false,
          enter = true,
          zindex = 210,
          format = { '{confirm}' },
          close = {
            events = { 'BufLeave' },
            keys = { 'q' },
          },
          border = {
            style = 'rounded',
            padding = { 0, 1 },
          },
          position = {
            row = '90%',
            col = '50%',
          },
          size = {
            width = '90%',
            height = '20%',
          },
          win_options = {
            winhighlight = { Normal = 'NoicePopup', FloatBorder = 'NoicePopupBorder' },
            winbar = '',
            foldenable = false,
            wrap = true,
            linebreak = true,
          },
        },
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
        errormini = {
          backend = 'mini',
          relative = 'editor',
          timeout = 2000,
          reverse = true,
          focusable = false,
          zindex = 6,
          position = {
            row = '90%',
            col = '50%',
          },
          size = {
            width = '90%',
            height = '10%',
          },
          border = {
            style = { '', '─', '', '', '', '', '', '' },
          },
        },
      },
    },
  },
  { 'brenoprata10/nvim-highlight-colors', event = 'VeryLazy', opts = {} },
  {
    'tzachar/highlight-undo.nvim',
    event = 'VeryLazy',
    opts = {},
  },
}
