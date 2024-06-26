local M = {}

local stylelint = {
  filetypes = {
    'css',
    'scss',
    'sass',
  },
}

local tailwindcss = {
  filetypes = {
    'html',
    'css',
    'scss',
    'sass',
  },
}

-- M.typescript = require 'core.lsp.langs.typescript'
M.lua = require 'core.lsp.langs.lua'
M.json = require 'core.lsp.langs.json'
M.yaml = require 'core.lsp.langs.yaml'
M.tailwindcss = tailwindcss
M.stylelint = stylelint

return M
