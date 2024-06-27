local type_declaration = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  type_declaration(
    context(trig 'itf', name 'interface ..'),
    [[interface {} {{
  {}
}}]],
    { 1, 0 }
  ),
  type_declaration(context(trig 'tp', name 'type ..'), [[type {} = {}]], { 1, 0 }),
  type_declaration(context(trig 'gn', name '<..>'), [[<{}>]], { 0 }),
}
