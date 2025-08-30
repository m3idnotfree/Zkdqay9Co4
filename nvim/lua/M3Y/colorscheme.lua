local M = {}

M.theme = {
  white = '#dcd7ba',
  fg0 = '#d4be98',
  fg1 = '#ddc7a1',
  red = '#ea6962',
  bright_red = '#fb4934',
  orange = '#e78a4e',
  orange2 = '#ff9e64',
  bright_orange = '#fe8019',
  yellow_ocher = '#d8a657',
  yellow = '#fabd2f',
  magenta = '#fc56B1',
  gray = '#44475a',
  light_grey = '#dbdbdb',
  wine = '#ba508a',
  blue = '#7daea3',
  prussian_blue = '#0f3a42',
  dark_brown = '#420f42',
  sepia = '#574833',
  green = '#a9b665',
  neural_green = '#98971a',
  aqua = '#89b482',
  purple = '#d3869b',
  modified = '#c70039',
}

M.overrides_colorscheme = function()
  local overrides = {
    MatchParen = { fg = M.theme.yellow, bold = true },
    Select = { fg = M.theme.orange, bg = M.theme.prussian_blue },
    IncSearch = { fg = M.theme.white, bg = M.theme.magenta },
    Search = { fg = M.theme.light_grey, bg = M.theme.wine },

    Pmenu = {},
    PmenuSel = { link = 'Select' },

    Reverse = { reverse = true },

    ErrorMsg = { bold = false, link = 'error' },

    NormalFloat = {},
    Floatborder = {},
    LspInfoBorder = { link = 'Floatborder' },

    TelescopeMatching = { link = 'Error' },
    TelescopeSelection = { link = 'PmenuSel' },
    TelescopeNormal = { link = 'Grey' },

    CmpItemAbbrMatch = { fg = M.theme.yellow },
    CmpItemAbbrMatchFuzzy = { link = 'Error' },

    Winbar = { fg = M.theme.orange, bold = false },

    StatusLine = {},
    UfoText = { fg = M.theme.yellow_ocher, bg = M.theme.dark_brown },

    TreesitterContext = { bg = M.theme.sepia },

    Forsythia = { fg = M.theme.yellow },

    IlluminatedWordRead = { underline = true },
  }

  for key, value in pairs(overrides) do
    vim.api.nvim_set_hl(0, key, value)
  end
end

return M
