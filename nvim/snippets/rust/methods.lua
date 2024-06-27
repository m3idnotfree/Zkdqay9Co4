local macro = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  macro(context(trig 'ts', name 'to_string'), 'to_string();'),
  macro(context(trig 'to', name 'to_owned'), 'to_owned();'),
  macro(context(trig 'uw', name 'unwrap'), 'unwrap();'),
  macro(context(trig 'ep', name 'expect'), 'expect({});', { 0 }),
  macro(context(trig 'aw', name 'await'), 'await'),
}
