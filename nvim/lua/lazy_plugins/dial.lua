return {
  'monaqa/dial.nvim',
  keys = {
    {
      '<C-a>',
      function()
        require('dial.map').manipulate('increment', 'normal')
      end,
      desc = 'increment',
    },
    {
      '<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'normal')
      end,
      desc = 'decrement',
    },
    {
      'g<C-a>',
      function()
        require('dial.map').manipulate('increment', 'gvisual')
      end,
      mode = 'v',
      desc = 'increment linear',
    },
    {
      'g<C-x>',
      function()
        require('dial.map').manipulate('decrement', 'gvisual')
      end,
      mode = 'v',
      desc = 'decrement linear',
    },
  },
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
