local macro = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  macro(context(trig 'l', name 'let .. = ..'), 'let {} = {};', { 1, 0 }),
  macro(context(trig 'lm', name 'let mut .. = ..'), 'let mut {} = {};', { 1, 0 }),
  macro(context(trig 'new', name 'fn new ..'), 'pub fn new ()-> Self {{\n    {}\n}}', { { 0, 'unimplemented!();' } }),
  macro(context(trig 'stru', name 'struct'), 'struct {} {{\n    {}\n}}', { 1, 2 }),
  macro(context(trig 'pstru', name 'pub struct'), 'pub struct {} {{\n    {}\n}}', { 1, 2 }),
  macro(context(trig 'enum', name 'enum'), 'enum {}{{\n    {}}}', { 1, 0 }),
  macro(context(trig 'fl', name 'struct field'), '{}: {}', { 1, 0 }),
  macro(context(trig 'pfl', name 'struct pub field'), 'pub {}: {}', { 1, 0 }),
}
