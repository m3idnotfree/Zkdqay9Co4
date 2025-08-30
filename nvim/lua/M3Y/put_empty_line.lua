local M = {
  cache_empty_line = { put_above = true },
  config = {
    keymaps = {
      put_above = 'gO',
      put_below = 'go',
    },
    enable_keymaps = true,
  },
}

M.put_empty_line = function(put_above)
  if type(put_above) == 'boolean' then
    vim.o.operatorfunc = 'v:lua.M3Y.put_empty_line'
    M.cache_empty_line = { put_above = put_above }
    return 'g@l'
  end

  vim.schedule(function()
    local target_line = vim.fn.line '.' - (M.cache_empty_line.put_above and 1 or 0)
    vim.fn.append(target_line, vim.fn['repeat']({ '' }, vim.v.count1))
  end)
end

M.above = function()
  return M.put_empty_line(true)
end

M.below = function()
  return M.put_empty_line(false)
end

M.setup = function(opts)
  opts = opts or {}

  M.config = vim.tbl_deep_extend('force', M.config, opts)

  _G.M3Y = _G.M3Y or {}
  _G.M3Y.put_empty_line = M.put_empty_line

  if M.config.enable_keymaps then
    local keymap_opts = { desc = 'Put empty line above', expr = true, silent = true }
    vim.keymap.set('n', M.config.keymaps.put_above, require('M3Y.put_empty_line').above, keymap_opts)

    keymap_opts.desc = 'Put empty line below'
    vim.keymap.set('n', M.config.keymaps.put_below, require('M3Y.put_empty_line').below, keymap_opts)
  end

  return M
end

return M
