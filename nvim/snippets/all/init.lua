local ls = require 'luasnip'

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig
local dscr = contexts.dscr
local format = require('util.luasnip.format').format

local function fnf(_, snip, _user_args)
  return snip.trigger .. '('
end
return {
  format(context(trig 'pkgworkspace', name 'packages', dscr 'pnpm workspace packages'), { 'packages:', '  - packages/*' }),
  -- format(context(trig 'ppppp', name 'packages', dscr 'pnpm workspace packages'), [[]]),
  s('trig', {
    i(1, 'text_of_first'),
    i(2, { 'first_line_of_second', 'second_line_of_second' }),
    f(function(args, snip)
      --here
      -- order is 2,1, not 1,2!!
    end, { 2, 1 }),
  }),
}
