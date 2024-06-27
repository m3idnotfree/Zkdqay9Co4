local macro = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  macro(context(trig 'fn', name 'fn ..'), 'fn {}({}) {}{{\n    {}\n}}', { 1, 2, 3, 0 }),
  macro(context(trig 'pfn', name 'pub fn ..'), 'pub fn {}({}) {}{{\n    {}\n}}', { 1, 2, 3, { 0, 'unimplemented!();' } }),
  macro(context(trig 'afn', name 'async fn ..'), 'async fn {}({}) {}{{\n    {}\n}}', { 1, 2, 3, 0 }),
  macro(context(trig 'pafn', name 'pub async fn ..'), 'pub async fn {}({}) {}{{\n    {}\n}}', { 1, 2, 3, 0 }),
  macro(context(trig 'cl', name '|..|{..}'), '|{}|{{{}}}', { 1, 0 }),
  macro(context(trig 'mcl', name 'move |..|{..}'), 'move |{}|{{{}}}', { 1, 0 }),
  macro(context(trig 'amcl', name 'async move |..|{..}'), 'async move |{}|{{{}}}', { 1, 0 }),
  macro(context(trig 'pr', name 'parameter'), '{}: {}', { 1, 0 }),
}
