local tests = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  tests(
    context(trig 'desc', name 'describe'),
    [[describe("{}",()=>{{
  {} 
}})]],
    { 1, 0 }
  ),
  tests(
    context(trig 'its', name 'it synchronous'),
    [[it("{}",()=>{{
  {} 
}})]],
    { 1, 0 }
  ),
}
