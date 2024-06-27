local ls = require 'luasnip'

local L = {}

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local c = ls.choice_node
local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require 'luasnip.util.events'
-- local ai = require 'luasnip.nodes.absolute_indexer'
-- local l = require('luasnip.extras').lambda
-- local rep = require('luasnip.extras').rep
-- local p = require('luasnip.extras').partial
-- local m = require('luasnip.extras').match
-- local n = require('luasnip.extras').nonempty
-- local dl = require('luasnip.extras').dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
-- local fmta = require('luasnip.extras.fmt').fmta
-- local types = require 'luasnip.util.types'
-- local conds = require 'luasnip.extras.expand_conditions'
-- local postfix = require('luasnip.extras.postfix').postfix

-- local s = ls.snippet
-- local t = ls.text_node
-- local i = ls.insert_node
-- -- local f = ls.function_node
-- local fmt = require('luasnip.extras.fmt').fmt

-- local contexts = require 'modules.luasnip.context'
-- local context = contexts.context
-- local name = contexts.name
-- local trig = contexts.trig
-- local dscr = contexts.dscr

function L.insert(...)
  i(...)
end

local text = function(context, text)
  return s(context, t(text))
end

function L.format(context, format, order)
  local o = {}
  if order == nil then
    return text(context, format)
  end

  -- if #order == 0 then
  -- return text(context, format)
  -- else
  for _, value in ipairs(order) do
    if type(value) == 'table' then
      table.insert(o, i(value[1], value[2]))
    else
      table.insert(o, i(value))
    end
  end
  return s(context, fmt(format, o))
  -- end
end

function L.gitcommit_snip(context)
  return s(context, {
    t(context.trig .. '('),
    i(1),
    t '): ',
    i(0),
  })
end

function L.tag(context)
  return s(
    {
      trig = context.trig,
      name = context.trig,
      dscr = '',
    },
    fmt([[<{} {}>{}</{}>]], { t(context.trig), i(1), i(0), t(context.trig) })
    -- {
    -- t('<' .. context.trig .. '>'),
    -- i(0),
    -- t('</' .. context.trig .. '>'),
    -- }
  )
end

function L.single_tag(context)
  return s({
    trig = context.trig,
    name = context.trig,
    dscr = '',
  }, { t('<' .. context.trig .. '>') })
end

function L.input(type)
  if type == nil then
    return s({ trig = 'input', name = 'input', dscr = '' }, fmt([[<input type={}>]], { i(1) }))
  end

  if type == 'checkbox' then
    return s({ trig = 'inputcheckbox', name = 'input checkbox', dscr = '' }, fmt([[<input type='checkbox' checked=true>]], {}))
  end

  if type == 'radio' then
    return s({ trig = 'inputradio', name = 'input radio', dscr = '' }, fmt([[<input type='radio' checked=true>]], {}))
  end
end

local date_format = function(format)
  return f(function()
    return os.date(format)
  end)
end

function L.date(context, format)
  return s(context, date_format(format))
end

function L.fn(context, fn)
  return s(context, f(fn))
end

function L.delimiters(context, format, order)
  local o = {}

  for _, value in ipairs(order) do
    table.insert(o, i(value))
  end
  return s(context, fmt(format, o, { delimiters = '<>' }))
end

function L.labelf()
  return s(
    { trig = 'labelf', name = 'label', dscr = '' },
    fmt(
      [[<label for='{}'>{}</label>
<input id='{}' type={}>
    ]],
      {
        i(1),
        i(0),
        d(3, function(args)
          return sn(nil, { t(args[1]) })
        end, { 1 }),

        i(2),
      }
    )
  )
end
return L
