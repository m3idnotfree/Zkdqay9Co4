return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  specs = {
    {
      'folke/snacks.nvim',
      opts = {
        picker = {
          win = {
            input = {
              keys = {
                ['<a-s>'] = { 'flash', mode = { 'n', 'i' } },
                ['s'] = { 'flash' },
              },
            },
          },
          actions = {
            flash = function(picker)
              require('flash').jump {
                pattern = '^',
                label = { after = { 0, 0 } },
                search = {
                  mode = 'search',
                  exclude = {
                    function(win)
                      return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'snacks_picker_list'
                    end,
                  },
                },
                action = function(match)
                  local idx = picker.list:row2idx(match.pos[1])
                  picker.list:_move(idx, true, true)
                end,
              }
            end,
          },
        },
      },
    },
  },
  opts = {},
  -- stylua: ignore start
    keys = {
      { 's',     function() require('flash').jump() end,              mode = { 'n', 'x', 'o' }, desc = 'Flash' },
      { 'S',     function() require('flash').treesitter() end,        mode = { 'n', 'o', 'x' }, desc = 'Flash Treesitter' },
      { 'r',     function() require('flash').remote() end,            mode = 'o',               desc = 'Remote Flash' },
      { 'R',     function() require('flash').treesitter_search() end, mode = { 'o', 'x' },      desc = 'Treesitter Search' },
      { '<c-s>', function() require('flash').toggle() end,            mode = { 'c' },           desc = 'Toggle Flash Search' },
    },
}
