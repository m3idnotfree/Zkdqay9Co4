local format = require('util.luasnip.format').format

local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  format(context(trig 'l', name 'local ..'), [[local {}]], { 0 }),
  format(context(trig 'req', name 'require(..)'), [[require('{}')]], { 0 }),
  format(context(trig 'lreq', name 'local .. = require(..)'), [[local {} = require('{}')]], { 1, 0 }),
  format(context(trig 'r', name 'return ..'), [[return {}]], { 0 }),
  format(
    context(trig 'fn', name 'function ..'),
    [[function {}({})
    {}
  end]],
    { 1, 2, 0 }
  ),
}
