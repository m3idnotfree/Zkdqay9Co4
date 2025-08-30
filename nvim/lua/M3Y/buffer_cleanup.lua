local M = {}

M.config = {
  skip_modified = true,
  skip_special = true,
  confirm_modified = true,
  show_summary = true,
  keymaps = {
    delete_others = '<leader>bD',
    wipe_others = '<leader>bW',
  },

  exclude_buffer_types = {
    'help',
    'terminal',
    'quickfix',
    'nofile',
    'prompt',
  },

  exclude_patterns = {
    '^%[.*%]$', -- [No Name], [Scratch], etc.
    'COMMIT_EDITMSG', -- Git commit messages
    '%.git/', -- Git related files
  },
}

local get_opt_value = function(buf, name)
  return vim.api.nvim_get_option_value(name, { buf = buf })
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend('force', M.config, opts or {})

  if M.config.default_keymaps then
    vim.keymap.set('n', M.config.keymaps.delete_others, require('M3Y.buffer_cleanup').delete_others, { desc = 'Delete other buffers', silent = true })
    vim.keymap.set('n', M.config.keymaps.wipe_others, require('M3Y.buffer_cleanup').wipe_others, { desc = 'Wipe other buffers', silent = true })
  end
end

local function should_exclude_buffer(buf, opts)
  opts = opts or {}
  local config = vim.tbl_deep_extend('force', M.config, opts)

  if not vim.api.nvim_buf_is_valid(buf) then
    return true
  end

  if config.skip_special and not get_opt_value(buf, 'buflisted') then
    return true
  end

  local buftype = get_opt_value(buf, 'buftype')
  if config.skip_special and vim.tbl_contains(config.exclude_buffer_types, buftype) then
    return true
  end

  if config.skip_modified and get_opt_value(buf, 'modified') then
    return true
  end

  local bufname = vim.api.nvim_buf_get_name(buf)
  for _, pattern in ipairs(config.exclude_patterns) do
    if string.match(bufname, pattern) then
      return true
    end
  end

  return false
end

local function get_buffer_display_name(buf)
  local name = vim.api.nvim_buf_get_name(buf)
  if name == '' then
    return '[No Name]'
  end
  return vim.fn.fnamemodify(name, ':t')
end

function M.delete_others(opts)
  opts = opts or {}
  local config = vim.tbl_deep_extend('force', M.config, opts)
  local force = opts.force or false

  local current_buf = vim.api.nvim_get_current_buf()
  local all_buffers = vim.api.nvim_list_bufs()

  local deleted = {}
  local skipped = {}
  local errors = {}

  for _, buf in ipairs(all_buffers) do
    if buf ~= current_buf then
      local buf_name = get_buffer_display_name(buf)

      if should_exclude_buffer(buf, config) then
        table.insert(skipped, {
          id = buf,
          name = buf_name,
          reason = 'excluded by config',
        })
      else
        local success, err = pcall(function()
          vim.api.nvim_buf_delete(buf, { force = force })
        end)

        if success then
          table.insert(deleted, {
            id = buf,
            name = buf_name,
          })
        else
          table.insert(errors, {
            id = buf,
            name = buf_name,
            error = err,
          })
        end
      end
    end
  end

  if config.show_summary then
    M._show_summary('delete', deleted, skipped, errors)
  end

  return {
    deleted = deleted,
    skipped = skipped,
    errors = errors,
  }
end

function M.wipe_others(opts)
  opts = opts or {}
  local config = vim.tbl_deep_extend('force', M.config, opts)
  local force = opts.force or false

  local current_buf = vim.api.nvim_get_current_buf()
  local all_buffers = vim.api.nvim_list_bufs()

  local wiped = {}
  local skipped = {}
  local errors = {}

  for _, buf in ipairs(all_buffers) do
    if buf ~= current_buf then
      local buf_name = get_buffer_display_name(buf)

      if should_exclude_buffer(buf, config) then
        table.insert(skipped, {
          id = buf,
          name = buf_name,
          reason = 'excluded by config',
        })
      else
        local success, err = pcall(function()
          vim.cmd((force and 'bwipeout! ' or 'bwipeout ') .. buf)
        end)

        if success then
          table.insert(wiped, {
            id = buf,
            name = buf_name,
          })
        else
          table.insert(errors, {
            id = buf,
            name = buf_name,
            error = err,
          })
        end
      end
    end
  end

  if config.show_summary then
    M._show_summary('wipe', wiped, skipped, errors)
  end

  return {
    wiped = wiped,
    skipped = skipped,
    errors = errors,
  }
end

function M.delete_others_interactive()
  local current_buf = vim.api.nvim_get_current_buf()
  local all_buffers = vim.api.nvim_list_bufs()
  local candidates = {}
  local modified_candidates = {}

  for _, buf in ipairs(all_buffers) do
    if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) then
      if get_opt_value(buf, 'buflisted') then
        local buf_info = {
          id = buf,
          name = get_buffer_display_name(buf),
          modified = get_opt_value(buf, 'modified'),
        }

        table.insert(candidates, buf_info)
        if buf_info.modified then
          table.insert(modified_candidates, buf_info)
        end
      end
    end
  end

  if #candidates == 0 then
    print 'No other buffers to delete'
    return
  end

  print(string.format('Will delete %d buffers:', #candidates))
  for _, buf in ipairs(candidates) do
    local status = buf.modified and ' [MODIFIED]' or ''
    print(string.format('  %d: %s%s', buf.id, buf.name, status))
  end

  if #modified_candidates > 0 then
    print(string.format('\nWarning: %d buffers have unsaved changes!', #modified_candidates))
    for _, buf in ipairs(modified_candidates) do
      print(string.format('  %d: %s', buf.id, buf.name))
    end
  end

  local response = vim.fn.input '\nProceed? (y/N/f=force): '

  if response:lower() == 'y' then
    return M.delete_others { skip_modified = true }
  elseif response:lower() == 'f' then
    return M.delete_others { force = true, skip_modified = false }
  else
    print 'Cancelled'
    return nil
  end
end

function M.delete_others_enhanced(opts)
  opts = opts or {}

  local presets = {
    safe = {
      skip_modified = true,
      skip_special = true,
      force = false,
    },
    aggressive = {
      skip_modified = false,
      skip_special = false,
      force = true,
    },
    normal_only = {
      skip_modified = true,
      skip_special = true,
      force = false,
      exclude_buffer_types = { 'help', 'terminal', 'quickfix', 'nofile', 'prompt' },
    },
  }

  local preset = opts.preset
  if preset and presets[preset] then
    opts = vim.tbl_deep_extend('force', presets[preset], opts)
  end

  return M.delete_others(opts)
end

function M._show_summary(operation, processed, skipped, errors)
  local op_past = operation == 'delete' and 'deleted' or 'wiped'

  print(string.format('\nBuffer %s Summary:', operation:upper()))

  if #processed > 0 then
    print(string.format('%s %d buffers:', op_past:upper(), #processed))
    for _, buf in ipairs(processed) do
      print(string.format('  %d: %s', buf.id, buf.name))
    end
  end

  if #skipped > 0 then
    print(string.format('SKIPPED %d buffers:', #skipped))
    for _, buf in ipairs(skipped) do
      print(string.format('  %d: %s (%s)', buf.id, buf.name, buf.reason))
    end
  end

  if #errors > 0 then
    print(string.format('ERRORS with %d buffers:', #errors))
    for _, buf in ipairs(errors) do
      print(string.format('  %d: %s - %s', buf.id, buf.name, buf.error))
    end
  end

  print(string.format('\nTotal: %d %s, %d skipped, %d errors', #processed, op_past, #skipped, #errors))
end

function M.list_candidates()
  local current_buf = vim.api.nvim_get_current_buf()
  local all_buffers = vim.api.nvim_list_bufs()

  print '=== BUFFER CLEANUP CANDIDATES ===\n'
  print('Current buffer:', current_buf, '-', get_buffer_display_name(current_buf))
  print()

  local candidates = {}
  local excluded = {}

  for _, buf in ipairs(all_buffers) do
    if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) then
      local buf_info = {
        id = buf,
        name = get_buffer_display_name(buf),
        buftype = get_opt_value(buf, 'buftype'),
        modified = get_opt_value(buf, 'modified'),
        listed = get_opt_value(buf, 'buflisted'),
      }

      if should_exclude_buffer(buf) then
        table.insert(excluded, buf_info)
      else
        table.insert(candidates, buf_info)
      end
    end
  end

  if #candidates > 0 then
    print 'WILL BE DELETED:'
    for _, buf in ipairs(candidates) do
      local flags = {}
      if buf.modified then
        table.insert(flags, 'MODIFIED')
      end
      if buf.buftype ~= '' then
        table.insert(flags, buf.buftype)
      end
      if not buf.listed then
        table.insert(flags, 'unlisted')
      end

      local flag_str = #flags > 0 and ' [' .. table.concat(flags, ', ') .. ']' or ''
      print(string.format('  %d: %s%s', buf.id, buf.name, flag_str))
    end
  else
    print 'No buffers will be deleted'
  end

  if #excluded > 0 then
    print '\nWILL BE SKIPPED:'
    for _, buf in ipairs(excluded) do
      local reason = {}
      if buf.modified then
        table.insert(reason, 'modified')
      end
      if buf.buftype ~= '' then
        table.insert(reason, buf.buftype)
      end
      if not buf.listed then
        table.insert(reason, 'unlisted')
      end

      local reason_str = #reason > 0 and table.concat(reason, ', ') or 'config'
      print(string.format('  %d: %s (%s)', buf.id, buf.name, reason_str))
    end
  end

  print(string.format('\nSummary: %d candidates, %d excluded', #candidates, #excluded))
end

return M
