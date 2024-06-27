local macro = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  macro(context(trig 'if', name 'if ..'), 'if {} {{\n    {}\n}}', { 1, { 0, 'unimplemented!();' } }),
  macro(context(trig 'ls', name 'let Some ..'), 'let Some({}) = {}', { 0, 1 }),
  macro(context(trig 'lo', name 'let Ok ..'), 'let Ok({}) = {}', { 0, 1 }),
  macro(context(trig 'le', name 'let Err ..'), 'let Err({}) = {}', { 0, 1 }),
  macro(context(trig 'loop', name 'loop ..'), 'loop {{\n    {}\n}}', { { 0, 'unimplemented!();' } }),
  macro(context(trig 'for', name 'for .. in'), 'for {} in {} {{\n    {}\n}}', { 1, 2, { 0, 'unimplemented!();' } }),
  macro(
    context(trig 'match', name 'match'),
    [[match {} {{
    {} => {{ {} }},
    {} => {{ {} }},
  }}]],
    { 1, 2, { 3, 'unimplemented!();' }, { 4, '_' }, { 0, 'unimplemented!();' } }
  ),
  macro(
    context(trig 'matchr', name 'match result'),
    [[match {} {{
    Ok({}) => {{ {} }},
    Err({}) => {{ {} }},
  }}]],
    { 1, { 2, 'result' }, { 3, 'unimplemented!();' }, { 4, 'err' }, { 0, 'unimplemented!();' } }
  ),
  macro(
    context(trig 'matcho', name 'match option'),
    [[match {} {{
    Some({}) => {{ {} }},
    None => {{ {} }},
  }}]],
    { 1, { 2, 'result' }, { 3, 'unimplemented!();' }, { 0, 'unimplemented!();' } }
  ),
}
