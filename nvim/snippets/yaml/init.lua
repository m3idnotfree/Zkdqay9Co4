local ls = require 'luasnip'

local s = ls.snippet
local fmt = require('luasnip.extras.fmt').fmt

local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig
local dscr = contexts.dscr
local format = require('util.luasnip.format').format

return {
  format(
    context(trig 'pkgworkspace', name 'packages', dscr 'pnpm workspace packages'),
    [[packages:
  - 'packages/*']],
    {}
  ),
}
