require 'global'

require 'config.options'
require 'config.autocmds'
require 'config.keymaps'
require 'config.lazy'

vim.keymap.set('n', '<leader>bo', function()
  Snacks.bufdelete.other()
end, { desc = 'Delete Other Buffers', silent = true })

require('M3Y.root').setup()
require('M3Y.put_empty_line').setup()
require('M3Y.buffer_cleanup').setup()

require('M3Y.colorscheme').overrides_colorscheme()
