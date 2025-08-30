local colorscheme = require 'M3Y.colorscheme'

return {
  normal = {
    a = { fg = colorscheme.theme.fg0 },
    b = { fg = colorscheme.theme.fg0 },
    c = { fg = colorscheme.theme.fg0 },
  },
  insert = {
    a = { fg = colorscheme.theme.blue },
    b = { fg = colorscheme.theme.fg0 },
    c = { fg = colorscheme.theme.fg0 },
  },
  visual = {
    a = { fg = colorscheme.theme.bright_orange },
    b = { fg = colorscheme.theme.white },
    c = { fg = colorscheme.theme.white },
  },
  replace = {
    a = { fg = colorscheme.theme.green },
    b = { fg = colorscheme.theme.white },
    c = { fg = colorscheme.theme.white },
  },
  command = {
    -- a = { fg = _G.m3id.theme.color.orange, gui = "bold" },
    -- b = { fg = _G.m3id.theme.color.white },
    -- c = { fg = _G.m3id.theme.color.white },
  },
  inactive = {
    a = { fg = colorscheme.theme.gray },
    b = { fg = colorscheme.theme.white },
    c = { fg = colorscheme.theme.neural_green },
  },
}
