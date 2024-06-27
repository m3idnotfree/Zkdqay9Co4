local operations = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  operations(context(trig 'to', name 'typeof ..'), [[typeof {} === {}]], { 1, 0 }),
  operations(context(trig 'iof', name '.. instanceof ..'), [[{} instanceof {}]], { 1, 0 }),
}
