local exports = {}

exports.on_attach = function(_, bufnr)
  -- require('twoslash-queries').attach(client, bufnr)
  vim.keymap.set('n', '<leader>co', function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = { 'source.organizeImports' },
        diagnostics = {},
      },
    }
  end, { desc = 'organize imports' })

  vim.keymap.set('n', '<leader>cM', function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = { 'source.addMissingImports.ts' },
        diagnostics = {},
      },
    }
  end, { desc = 'add missing imports' })

  vim.keymap.set('n', '<leader>cu', function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = { 'source.removeUnused.ts' },
        diagnostics = {},
      },
    }
  end, { desc = 'remove unused imports' })

  vim.keymap.set('n', '<leader>cD', function()
    vim.lsp.buf.code_action {
      apply = true,
      context = {
        only = { 'source.fixAll.ts' },
        diagnostics = {},
      },
    }
  end, { desc = 'fix all diagnostics' })

  require('util.langs.typescript').renameFile(bufnr)
  vim.keymap.set('n', '<leader>rf', function()
    vim.cmd 'TypescriptRenameFile'
  end, { desc = 'Rename File' })
end

return exports
