local macro = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  macro(context(trig 'json', name 'json!'), 'json!({})', { 0 }),
  macro(context(trig 'sdfs', name 'serde from str'), 'serde_json::from_str({})', { 0 }),
  macro(context(trig 'sdts', name 'serde to string'), 'serde_json::to_string({})', { 0 }),
  macro(context(trig 'sdtsp', name 'serde to string pretty'), 'serde_json::to_string_pretty({})', { 0 }),
}
