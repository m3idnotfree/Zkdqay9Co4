local macro = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  macro(context(trig 'tvec', name 'Vec<..>'), 'Vec<{}>', { 0 }),
  macro(context(trig 'thash', name 'HashMap<..>'), 'HashMap<{},{}>', { 1, 0 }),
  macro(context(trig 'tresult', name 'Result'), 'Result<{},{}>', { 1, 0 }),
  macro(context(trig 'toption', name 'Option'), 'Option<{}>', { 0 }),

  macro(context(trig 'err', name 'Err'), 'Err({})', { 0 }),
  macro(context(trig 'ok', name 'Ok'), 'Ok({})', { 0 }),
  macro(context(trig 'some', name 'Some'), 'Some({})', { 0 }),
  macro(context(trig 'none', name 'None'), 'None'),
}
