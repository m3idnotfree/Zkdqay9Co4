local M = {}

local function shorten_path(full_path, components)
  components = components or 2
  local parts = vim.split(full_path, '/', { plain = true })

  local clean_parts = {}
  for _, part in ipairs(parts) do
    if part ~= '' then
      table.insert(clean_parts, part)
    end
  end

  local len = #clean_parts
  if len <= components then
    return table.concat(clean_parts, '/')
  end

  local result = {}
  for i = len - components + 1, len do
    table.insert(result, clean_parts[i])
  end

  return table.concat(result, '/')
end

M.cd = function(path)
  local ok, err = pcall(vim.uv.chdir, path)
  if ok then
    vim.notify('Change root to: ' .. shorten_path(path, 1), vim.log.levels.INFO)
    return
  else
    vim.notify('Failed to change directory: ' .. err, vim.log.levels.ERROR)
    return
  end
end

M.get_lsp_root = function(name)
  local lsp_clients = vim.lsp.get_clients { bufnr = 0 }
  for _, client in ipairs(lsp_clients) do
    if client.name == name then
      return client.config.root_dir
    end
  end
end

M.get_path = function(opts)
  local default_project = {
    'Cargo.toml',
    'package.json',
    'tsconfig.json',
    'pnpm-workspace.yaml',
    '.git',
  }

  local file_path = vim.fn.expand '%:p'
  if file_path == '' then
    vim.notify('No file in current buffer', vim.log.levels.WARN)
    return
  end

  local lsp_clients = vim.lsp.get_clients { bufnr = 0 }
  for _, client in ipairs(lsp_clients) do
    if client.config.root_dir then
      return 'lsp', client.config.root_dir, client.name
    end
  end

  local project_root = vim.fs.root(0, vim.tbl_deep_extend('force', default_project, opts or {}))

  if project_root then
    return 'project', project_root
  else
    local file_dir = vim.fn.expand '%:p:h'
    return 'file', file_dir
  end
end

M.sync_directory = function(opts)
  local target, path, client = M.get_path(opts)

  local message
  if target == 'lsp' then
    message = 'Changed to LSP root (' .. client .. '): ' .. shorten_path(path, 1)
  elseif target == 'project' then
    message = 'Changed to project root: ' .. shorten_path(path, 1)
  else
    message = 'Changed to file directory: ' .. shorten_path(path, 1)
  end

  local ok, err = pcall(vim.uv.chdir, path)
  if ok then
    vim.notify(message, vim.log.levels.INFO)
    return
  else
    vim.notify('Failed to change directory: ' .. err, vim.log.levels.ERROR)
    return
  end
end

M.setup = function()
  local commands = {
    rust = function(_)
      local client = M.get_lsp_root 'rust-analyzer' or 'Cargo.toml'
      M.cd(client)
    end,
    lua = function(_)
      local client = M.get_lsp_root 'lua_ls'
      M.cd(client)
    end,
    git = function(_)
      local root = vim.fs.root(0, '.git')
      M.cd(root)
    end,
  }
  vim.api.nvim_create_user_command('P', function(opts)
    local args = vim.split(opts.args, '%s+', { trimempty = true })
    local subcommand = table.remove(args, 1)

    if commands[subcommand] then
      commands[subcommand](args)
    else
      vim.notify('Available subcommands: ' .. table.concat(vim.tbl_keys(commands), ', '), vim.log.levels.INFO)
    end
  end, {
    nargs = '*',
    complete = function(ArgLead, CmdLine, _)
      local args = vim.split(CmdLine, '%s+', { trimempty = true })

      if #args <= 2 then
        return vim.tbl_filter(function(cmd)
          return cmd:find(ArgLead, 1, true) == 1
        end, vim.tbl_keys(commands))
      end

      return {}
    end,
    desc = 'Project navigation commands',
  })
end

return M
