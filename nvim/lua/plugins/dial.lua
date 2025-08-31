local function dial_map(kind, g)
  if kind == 'inc' then
    require('dial.map').manipulate('increment', g and 'gvisual' or 'normal')
  else
    require('dial.map').manipulate('decrement', g and 'gvisual' or 'normal')
  end
end

return {
  'monaqa/dial.nvim',
  -- stylua: ignore start
  keys = {
    { '<C-a>',  function() dial_map 'inc' end,        desc = 'increment' },
    { '<C-x>',  function() dial_map 'dec' end,        desc = 'decrement' },
    { 'g<C-a>', function() dial_map('inc', true) end, desc = 'increment linear', mode = 'v' },
    { 'g<C-x>', function() dial_map('dec', true) end, desc = 'decrement linear', mode = 'v' },
  },
  -- stylua: ignore end
  config = function()
    local augend = require 'dial.augend'
    require('dial.config').augends:register_group {
      default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias['%Y/%m/%d'],
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
        augend.constant.alias.bool,
        -- augend.paren.alias.brackets,
      },
      typescript = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.constant.new { elements = { 'let', 'const' } },
      },
      visual = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias['%Y/%m/%d'],
        augend.constant.alias.alpha,
        augend.constant.alias.Alpha,
      },
      mygroup = {
        augend.integer.alias.decimal,
        augend.constant.alias.bool,
        augend.date.alias['%m/%d/%Y'],
      },
    }
  end,
}
