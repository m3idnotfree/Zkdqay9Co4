local dom = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  dom(context(trig 'qs', name 'document.querySelector("..")'), [[document.querySelector("{}")]], { 0 }),
  dom(context(trig 'dqi', name 'document.querySelector("#..")'), [[document.querySelector("#{}")]], { 0 }),
  dom(context(trig 'dqc', name 'document.querySelector("...")'), [[document.querySelector(".{}")]], { 0 }),
  dom(
    context(trig 'ae', name '...addEventListener(..)'),
    [[{}.addEventListener("{}", (ev) => {{
  {}
  }})]],
    { 1, 2, 0 }
  ),
}
