local colors = require 'config.colors'

local overrides = {
  { name = 'MatchParen', val = { fg = colors.light_grey } },
  { name = 'Select', val = { fg = colors.orange, bg = colors.prussian_blue } },
  { name = 'IncSearch', val = { fg = colors.white, bg = colors.magenta } },
  { name = 'Search', val = { fg = colors.light_grey, bg = colors.wine } },

  { name = 'Pmenu', val = {} },
  { name = 'PmenuSel', val = { link = 'Select' } },

  { name = 'Reverse', val = { reverse = true } },

  { name = 'ErrorMsg', val = { bold = false, link = 'error' } },

  { name = 'NormalFloat', val = {} },
  { name = 'Floatborder', val = {} },
  { name = 'LspInfoBorder', val = { link = 'Floatborder' } },

  { name = 'TelescopeMatching', val = { link = 'Error' } },
  { name = 'TelescopeSelection', val = { link = 'PmenuSel' } },

  { name = 'CmpItemAbbrMatch', val = { fg = colors.yellow } },
  { name = 'CmpItemAbbrMatchFuzzy', val = { link = 'Error' } },

  { name = 'Winbar', val = { fg = colors.orange, bold = false } },

  { name = 'StatusLine', val = {} },
  { name = 'UfoText', val = { fg = colors.yellow_ocher, bg = colors.dark_brown } },

  { name = 'TreesitterContext', val = { bg = colors.sepia } },

  { name = 'Forsythia', val = { fg = colors.yellow } },
}

for _, v in pairs(overrides) do
  vim.api.nvim_set_hl(0, v.name, v.val)
end
