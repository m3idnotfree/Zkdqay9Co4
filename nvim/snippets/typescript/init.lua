local format = require 'util.luasnip.format'
-- local nformat = format.format
local fformat = format.fn
local contexts = require 'util.luasnip.context'
local context = contexts.context
local name = contexts.name
local trig = contexts.trig

return {
  -- format(context(trig 'eslintdiableline', name 'eslint disable next line'), '// eslint-disable-next-line'),
  -- format(context(trig 'denolintignore', name 'deno lint ignore'), '// deno-lint-ignore'),
  -- format(context(trig 'tsignore', name 'ts-ignore'), '// @ts-ignore'),

  -- fformat(context(trig 'names'), function()
  -- local Job = require 'plenary.job'
  --
  -- local j = Job:new({
  --   command = 'names',
  -- }):sync() -- or start()
  --
  -- local array = {}
  -- for w in j[1]:gmatch '([^-]+)' do
  --   table.insert(array, w)
  -- end
  -- -- local result = string.gmatch(j[1], '[^%s]+')
  -- -- print(result)
  -- -- print(vim.inspect(array))
  -- return array[1]
  -- end),
}
