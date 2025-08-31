return {
  'dmtrKovalenko/fff.nvim',
  build = 'cargo build --release',
  cmd = {
    'FFFFind',
    'FFFScan',
    'FFFRefreshGit',
    'FFFClearCache',
    'FFFHealth',
    'FFFDebug',
    'FFFOpenLog',
  },
  keys = {
    -- stylua: ignore start
    { '<leader>ff', function() require('fff').find_files() end, desc = 'Open file picker' },
    { '<leader>fg', function() require('fff').find_in_git_root() end, desc = 'Find Git Files' },
    -- stylua: ignore end
  },
  opts = {
    prompt = ' ',
    title = '',
    layout = {
      prompt_position = 'top',
    },
  },
}
