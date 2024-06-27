local nodejs = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  nodejs(context(trig 'cr', name 'const .. = require(..)'), [[const {} = require({})]], { 1, 0 }),
}
