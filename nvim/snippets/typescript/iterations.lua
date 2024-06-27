local iterations = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  iterations(
    context(trig 'fi', name 'for .. in ..'),
    [[for (const {} in {}) {{
  {} 
}}]],
    { 1, 2, 0 }
  ),
  iterations(
    context(trig 'fo', name 'for .. of'),
    [[for (const {} of {}) {{
  {} 
}}]],
    { 1, 2, 0 }
  ),
  iterations(
    context(trig 'while', name 'while ..'),
    [[while({}){{
  {} 
}}]],
    { 1, 0 }
  ),
}
