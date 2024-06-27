local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

local macro = require('util.luasnip.format').format

return {
  macro(context(trig 'udebug', name 'Debug'), 'Debug'),
  macro(context(trig 'ueq', name 'Eq'), 'Eq'),
  macro(context(trig 'upartialeq', name 'PartialEq'), 'PartialEq'),
  macro(context(trig 'uord', name 'Ord'), 'Ord'),
  macro(context(trig 'uclone', name 'Clone'), 'Clone'),
  macro(context(trig 'ucopy', name 'Copy'), 'Copy'),
  macro(context(trig 'udefault', name 'Default'), 'Default'),
  macro(context(trig 'ustring', name 'String'), 'String'),
  macro(context(trig 'uhashmap', name 'HashMap'), 'HashMap'),

  macro(context(trig 'userd', name 'Serialize'), 'Serialize'),
  macro(context(trig 'udserd', name 'Deserialize'), 'Deserialize'),

  macro(context(trig 'str', name '&str'), '&str'),
  macro(context(trig 'a', name "'a"), "'a"),
  macro(context(trig 'ma', name "&'a"), "&'a"),
  macro(context(trig 'mas', name "&'a str"), "&'a str"),
}
