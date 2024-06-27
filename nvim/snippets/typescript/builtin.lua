-- local format = require 'util.luasnip.format'
-- local s = format.format

local format = require('util.luasnip').format
local s = format.format

-- local contexts = require 'util.luasnip.context'
local contexts = require('util.luasnip').context
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

local fformat = format.fn
return {
  s(context(trig 'tsignore', name 'ts-ignore'), '// @ts-ignore'),
  s(context(trig 'eslintdiableline', name 'eslint disable next line'), '// eslint-disable-next-line'),
  s(context(trig 'denolintignore', name 'deno lint ignore'), '// deno-lint-ignore'),

  fformat(context(trig 'names'), function()
    local Job = require 'plenary.job'

    local j = Job:new({
      command = 'names',
    }):sync() -- or start()

    local array = {}
    for w in j[1]:gmatch '([^-]+)' do
      table.insert(array, w)
    end
    -- local result = string.gmatch(j[1], '[^%s]+')
    -- print(result)
    -- print(vim.inspect(array))
    return array[1]
  end),

  -- JSON
  s(context(trig 'js', name 'JSON.stringify(..)'), [[JSON.stringify({})]], { 0 }),
  s(context(trig 'jp', name 'JSON.parse(..))'), [[JSON.parse({})]], { 0 }),
  s(context(trig 'te', name '.. ? .. : ..'), [[{} ? {} : {}]], { 1, 2, 0 }),
  -- Object context
  s(context(trig 'ok', name 'Object.keys(..)'), [[Object.keys({})]], { 0 }),
  s(context(trig 'ov', name 'Object.values(..)'), [[Object.values({})]], { 0 }),
  s(context(trig 'oe', name 'Object.entries(..)'), [[Object.entries({})]], { 0 }),
  s(context(trig 'ofe', name 'Object.fromEntries(..)'), [[Object.fromEntries({})]], { 0 }),
  s(context(trig 'nm', name 'new Map()'), 'new Map()'),
  s(context(trig 'ns', name 'new Set()'), 'new Set()'),
  -- Console contextetrig
  s(context(trig 'cl', name 'console.log(..)'), [[console.log({})]], { 0 }),
  s(context(trig 'ce', name 'console.error(..)'), [[console.error({})]], { 0 }),
  -- built_in(
  --   context(trig 'foreanamech', name '..forEach(..)'),
  --   [[{}.forEach(({})=>{{
  -- {}
  -- }})]],
  --   { 1, 2, 0 }
  -- ),
  s(
    context(trig 'fe', name '..forEach'),
    [[{}.forEach(({})=>{{
  {}
  }})]],
    { 1, 2, 0 }
  ),
  s(
    context(trig 'map', name '..map'),
    [[{}.map(({})=>{{
  {}
  }})]],
    { 1, 2, 0 }
  ),
  s(
    context(trig 'reduce', name '..reduce'),
    [[{}.reduce(({})=>{{
  {}
  }})]],
    { 1, 2, 0 }
  ),
  s(
    context(trig 'filter', name '..filter'),
    [[{}.filter(({})=>{{
  {}
  }})]],
    { 1, 2, 0 }
  ),
  s(
    context(trig 'find', name '..find'),
    [[{}.find(({})=>{{
  {}
  }})]],
    { 1, 2, 0 }
  ),
  s(
    context(trig 'every', name '..every'),
    [[{}.every(({})=>{{
  {}
  }})]],
    { 1, 2, 0 }
  ),
  s(
    context(trig 'some', name '..some'),
    [[{}.some(({})=>{{
  {}
  }})]],
    { 1, 2, 0 }
  ),
  -- Promise
  s(context(trig 'p', name 'Promise'), [[Promise]], {}),
  s(context(trig 'prs', name 'Promise.resolve(..)'), [[Promise.resolve({})]], { 0 }),
  s(context(trig 'prj', name 'Promise.reject(..)'), [[Promise.reject({})]], { 0 }),
  s(context(trig 'ay'), 'async'),
  s(context(trig 'aw'), 'await'),
  s(context(trig 'y'), 'yield'),
  -- Template literal
  s(context(trig 'tl', name '${..}'), [[${{{}}}]], { 0 }),
  -- Error
  s(context(trig 'tne', name 'throw new Error(..)'), [[throw new Error({})]], { 0 }),
}
