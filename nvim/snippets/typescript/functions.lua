local functions = require('util.luasnip.format').format
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  functions(
    context(trig 'fn', name 'function ..'),
    [[function {}({}){{
  {}
}}]],
    { 1, 2, 0 }
  ),
  functions(
    context(trig 'afn', name 'async function ..'),
    [[async function {}({}){{
  {} 
}}]],
    { 1, 2, 0 }
  ),
  -- import
  functions(context(trig 'im', name 'import .. from ..'), [[import {{{}}} from "{}"]], { 0, 1 }),
  functions(context(trig 'imn', name 'import built-in node js'), [[import {{{}}} from "node:{}"]], { 0, 1 }),

  -- export
  functions(
    context(trig 'efn', name 'export function ..'),
    [[export function {}({}){{
  {} 
}}]],
    { 1, 2, 0 }
  ),
  functions(
    context(trig 'edfn', name 'export default function ..'),
    [[export default function {} ({}){{
  {} 
}}]],
    { 1, 2, 0 }
  ),
  functions(
    context(trig 'eafn', name 'export async function ..'),
    [[export async function {}({}){{
  {} 
}}]],
    { 1, 2, 0 }
  ),
  functions(context(trig 'ec', name 'export const .. = ..'), [[export const {} = {}]], { 1, 0 }),
  functions(context(trig 'ecf', name 'export const .. = (..) => ..'), [[export const {} = ({}) => {{ {} }} ]], { 1, 2, 0 }),
  functions(context(trig 'ecaf', name 'export const .. = async (..) => ..'), [[export const {} = async ({}) => {{ {} }} ]], { 1, 2, 0 }),
  functions(context(trig 'edcf', name 'export default const .. = (..) => ..'), [[export default const {} = ({}) => {{ {} }} ]], { 1, 2, 0 }),
  -- re export
  functions(context(trig 'ref', name 'export .. from ..'), [[export {{{}}} from "{}"]], { 0, 1 }),
  functions(context(trig 'anfn', name '(..) = > ..'), [[({}) => {{ {} }}]], { 1, 0 }),
  functions(context(trig 'afdo', name '({..}) => ..'), [[({{{}}}) => {{ {} }}]], { 1, 0 }),
  functions(context(trig 'afda', name '([..]) => ..'), [[([{}]) => {{ {} }}]], { 1, 0 }),
  functions(
    context(trig 'gf', name 'function* ..'),
    [[function* {}({}){{
  {}
}}]],
    { 1, 2, 0 }
  ),
}
