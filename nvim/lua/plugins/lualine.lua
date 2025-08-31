local colorscheme = require 'M3Y.colorscheme'
local icons = require 'M3Y.icons'
local theme = require 'M3Y.lualine.theme'
local util = require 'M3Y.lualine.util'

local symbols = {
  error = icons.error .. ' ',
  warn = icons.warn .. ' ',
  info = icons.hint .. ' ',
  hint = icons.info .. ' ',
}

return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/noice.nvim',
  },
  opts = {
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
        { '' },
        {
          'mode',
          fmt = function(str)
            return string.lower(str:sub(1, 2))
          end,
        },
        { util.modified() },
      },
      lualine_b = {
        { 'branch', fmt = util.trunc(80, 4, nil, true) },
        'diff',
      },
      lualine_c = {
        -- '%=',
        -- { custom_fname },
        {
          'diagnostics',
          sections = { 'error', 'warn', 'info', 'hint' },
          symbols = symbols,
          always_visible = true,
        },
        -- { lsp_active },
      },
      lualine_x = {
        -- hardtime_component(),
        {
          function()
            local ok, noice = pcall(require, 'noice')
            if ok then
              return noice.api.status.mode.get()
            end
            return ''
          end,
          -- require('noice').api.status.mode.get,
          -- cond = require('noice').api.status.mode.has,
          cond = function()
            local ok, noice = pcall(require, 'noice')
            if ok then
              return noice.api.status.mode.has()
            end
            return false
          end,
          color = { fg = colorscheme.theme.orange2 },
        },
      },
      lualine_z = {
        { util.staring_padding() },
        -- { 'progress', padding = { left = 0, right = 0 } },
        -- { 'location', padding = { left = 1, right = 0 } },
        {
          padding = { right = 0, left = 1 },
        },
      },
    },
  },
}
