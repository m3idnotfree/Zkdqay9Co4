local Context = {}
function Context:new(instance)
  instance = instance or {
    context = {
      trig = '',
      -- name = '',
      -- dscr = '',
    },
  }
  setmetatable(instance, self)
  self.__index = self
  return instance
end

Context.trig = function(trig)
  return function(opt)
    opt.trig = trig
  end
end

Context.name = function(name)
  return function(opt)
    opt.name = name
  end
end

Context.dscr = function(dscr)
  return function(opt)
    opt.dscr = dscr
  end
end

Context.context = function(...)
  local args = { ... }
  local o = Context:new()
  if #args == 0 then
    return o.context
  end
  for _, arg in pairs(args) do
    -- if type(arg) == 'string' then
    --   o.context.trig = arg
    -- else
    arg(o.context)
    -- end
  end
  return o.context
end

return Context
