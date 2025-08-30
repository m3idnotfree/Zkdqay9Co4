local M = {}

function M.trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
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

function M.staring_padding()
  return function()
    local ci = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())
    local bheight = vim.api.nvim_buf_line_count(0)
    local row, col = ci[1], ci[2]

    col = col + 1

    return string.format('%02d [%03d/%03d]', col, row, bheight)
  end
end

function M.modified()
  return function()
    local get_opt_value = vim.api.nvim_get_option_value
    local buf_modified = get_opt_value('modified', { scope = 'local' })
    local buf_modifiable = get_opt_value('modifiable', { scope = 'local' })
    -- local buf_readonly = value('readonly', { scope = 'local' })
    -- local buf_buftype = value('buftype', { scope = 'local' })
    -- local buf_filetype = value('filetype', { scope = 'local' })

    -- local modified_format = function(color, icon)
    --   color = string.format('%%#%s#', color)
    --   return string.format('[%s%s%s]', color, icon, '%#Normal#')
    -- end

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
end

function M.custom_fname()
  local custom_fname = require('lualine.components.filename'):extend()
  local highlight = require 'lualine.highlight'
  local default_status_colors = { saved = '', modified = '#ea6962' }

  function custom_fname:init(options)
    custom_fname.super.init(self, options)
    self.status_colors = {
      saved = highlight.create_component_highlight_group({ fg = default_status_colors.saved }, 'filename_status_saved', self.options),
      modified = highlight.create_component_highlight_group({ fg = default_status_colors.modified }, 'filename_status_modified', self.options),
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

return M
