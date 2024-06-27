local declaration = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  declaration(context(trig 'cd', name 'const'), [[const {} = {}]], { 1, 0 }),
  -- const statement
  declaration(context(trig 'cf', name 'const .. = (..) => {..}'), [[const {} = ({})=>{{ {} }}]], { 1, 2, 0 }),
  declaration(context(trig 'co', name 'const .. = {..}'), [[const {} = {{ {} }}]], { 1, 0 }),
  declaration(context(trig 'car', name 'const .. = [..]'), [[const {} = [{}] ]], { 1, 0 }),
  declaration(context(trig 'cdo', name 'const {..} = ..'), [[const {{{}}} = {} ]], { 0, 1 }),
  declaration(
    context(trig 'cda', name 'const [..] = ..'),
    [[const [{}] = {}
]],
    { 0, 1 }
  ),

  declaration(context(trig 'cda', name 'const {..} = await ..'), [[const {} = await {} ]], { 0, 1 }),

  declaration(context(trig 'l', name 'let'), [[let {}]], { 0 }),
  declaration(context(trig 'ld', name 'let declaration'), [[let {} = {}]], { 1, 0 }),
  declaration(
    context(trig 'class', name 'class ..'),
    [[class {} {{
    {}
    constructor(){{}}
}}]],
    { 1, 0 }
  ),
  -- class
  declaration(
    context(trig 'constructor', name 'constructor'),
    [[constructor ({}) {{
  {}
}}]],
    { 1, 0 }
  ),

  declaration(
    context(trig 'm', name 'method'),
    [[{}(){{
  {}
  }}]],
    { 1, 0 }
  ),
}
