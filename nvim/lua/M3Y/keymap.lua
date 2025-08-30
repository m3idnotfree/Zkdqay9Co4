local keymap = vim.keymap.set

local default_opts = {
  silent = true,
  noremap = true,
}

local merge_opts = function(...)
  local argc = select('#', ...)

  if argc == 0 then
    return default_opts
  end

  if argc == 1 and type((...)) == 'string' then
    return vim.tbl_extend('force', default_opts, { desc = (...) })
  end

  local acc = {}
  for _, opt in ipairs { ... } do
    if type(opt) == 'string' then
      acc.desc = opt
    elseif type(opt) == 'table' then
      for k, v in pairs(opt) do
        acc[k] = v
      end
    end
  end

  return vim.tbl_extend('force', default_opts, acc)
end

local create_keymap = function(modes, lhs, rhs, opts)
  return { modes = modes, lhs = lhs, rhs = rhs, opts = opts }
end

local execute_keymap = function(km)
  keymap(km.modes, km.lhs, km.rhs, km.opts)
end

local mode_keymap = function(modes)
  return function(lhs, rhs, ...)
    local opts = merge_opts(...)
    return create_keymap(modes, lhs, rhs, opts)
  end
end

local keymaps = function(...)
  return M3id.forEach(execute_keymap) { ... }
end

local create_ctrl_keymap = function(modes, lhs, rhs, opts)
  return { modes = modes, lhs = '<C-' .. lhs .. '>', rhs = rhs, opts = opts }
end

local create_leader_keymap = function(modes, lhs, rhs, opts)
  return { modes = modes, lhs = '<leader>' .. lhs, rhs = rhs, opts = opts }
end

local prefix_builder = {
  leader = {
    n = function(lhs, rhs, ...)
      local opts = merge_opts(...)
      return create_leader_keymap('n', lhs, rhs, opts)
    end,
    nv = function(lhs, rhs, ...)
      local opts = merge_opts(...)
      return create_leader_keymap({ 'n', 'v' }, lhs, rhs, opts)
    end,
  },

  ctrl = {
    n = function(lhs, rhs, ...)
      local opts = merge_opts(...)
      return create_ctrl_keymap('n', lhs, rhs, opts)
    end,
    i = function(lhs, rhs, ...)
      local opts = merge_opts(...)
      return create_ctrl_keymap('i', lhs, rhs, opts)
    end,
  },
}

local K = {
  n = mode_keymap 'n',
  v = mode_keymap 'v',
  i = mode_keymap 'i',
  x = mode_keymap 'x',
  o = mode_keymap 'o',
  t = mode_keymap 't',

  nv = mode_keymap { 'n', 'v' },
  nx = mode_keymap { 'n', 'x' },
  ni = mode_keymap { 'n', 'i' },
  nvo = mode_keymap { 'n', 'v', 'o' },

  silent = { silent = true },
  expr = { expr = true },
  remap = { remap = true },
  noremap = { noremap = true },
  nowait = { nowait = true },
  desc = function(description)
    return { desc = description }
  end,
  buffer = function(bufnr)
    return { buffer = bufnr or 0 }
  end,

  execute = execute_keymap,
}

K.leader = prefix_builder.leader
K.ctrl = prefix_builder.ctrl

return {
  K = K,
  keymaps = keymaps,
  all = function()
    return K.n, K.i, K.v, K.x, K.o, K.nx, K.leader, K.ctrl, K.remap, K.expr, keymaps
  end,
}
