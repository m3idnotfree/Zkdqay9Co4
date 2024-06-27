local macro = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  macro(context(trig 'println', name 'println!'), [[println!("{}",{});]], { 1, 0 }),
  macro(context(trig 'format', name 'format!'), [[format!("{}",{});]], { 1, 0 }),
  macro(context(trig 'panic', name 'panic!'), [[panic!("{}",{});]], { 1, 0 }),
  macro(context(trig 'fms', name '{:#?}'), '{:#?}'),
  macro(context(trig 'fmd', name '{:?}'), '{:?}'),
  macro(context(trig 'unimplemented', name 'unimplemented!'), 'unimplemented!();'),
  macro(context(trig 'vec', name 'vec!'), 'vec![{}];', { 0 }),
  macro(context(trig 'asserteq', name 'assert_eq'), 'assert_eq!({}, {});', { 1, 0 }),
  macro(context(trig 'derive', name 'derive'), '#[derive({})]', { 0 }),
  macro(context(trig 'test', name 'test'), '#[test]\nfn {}() {{\n    {}\n}}', { 1, 2 }),
}
