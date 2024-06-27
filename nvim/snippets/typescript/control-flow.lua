local control_flow = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  control_flow(context(trig 'r', name 'return'), [[return {}]], { 0 }),
  control_flow(context(trig 'ro', name 'return'), [[{{ return {} }}]], { 0 }),
  --   control_flow(
  --     context(trig 'if', name 'if ..'),
  --     [[if ({}) {{
  --   {}
  -- }}]],
  --     { 1, 0 }
  --   ),
  control_flow(
    context(trig 'if', name 'if ..'),
    [[if ({}) {{
  {} 
}}]],
    { 1, 0 }
  ),
  control_flow(
    context(trig 'ifelse', name 'if .. else'),
    [[if ({}) {{
  {} 
}} else {{
{}
}}
]],
    { 1, 2, 0 }
  ),

  control_flow(
    context(trig 'else', name 'else ..'),
    [[else {{
  {} 
}}]],
    { 0 }
  ),
  control_flow(
    context(trig 'elseif', name 'else if ..'),
    [[else if({}) {{
  {} 
}}]],
    { 1, 0 }
  ),
  control_flow(
    context(trig 'tc', name 'try/catch'),
    [[try {{
  {} 
}} catch (error){{
  console.error(error) 
}}]],
    { 0 }
  ),
  control_flow(
    context(trig 'switch', name 'switch ..'),
    [[switch ({}) {{
  case {}: {{
  {}
  }},
  default:{}
}}]],
    { 1, 2, 3, 0 }
  ),
}
