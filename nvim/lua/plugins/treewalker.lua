return {
  'aaronik/treewalker.nvim',
  cmd = 'Treewalker',
  keys = {
    { '<M-S-k>', '<cmd>Treewalker Up<cr>', silent = true, mode = { 'n', 'v' } },
    { '<M-S-j>', '<cmd>Treewalker Down<cr>', silent = true, mode = { 'n', 'v' } },
    { '<M-S-h>', '<cmd>Treewalker Left<cr>', silent = true, mode = { 'n', 'v' } },
    { '<M-S-l>', '<cmd>Treewalker Right<cr>', silent = true, mode = { 'n', 'v' } },

    { '<M-S-Up>', '<cmd>Treewalker SwapUp<cr>', silent = true },
    { '<M-S-Down>', '<cmd>Treewalker SwapDown<cr>', silent = true },
    { '<M-S-Left>', '<cmd>Treewalker SwapLeft<cr>', silent = true },
    { '<M-S-Right>', '<cmd>Treewalker SwapRight<cr>', silent = true },
  },

  -- The following options are the defaults.
  -- Treewalker aims for sane defaults, so these are each individually optional,
  -- and setup() does not need to be called, so the whole opts block is optional as well.
  opts = {
    -- Whether to briefly highlight the node after jumping to it
    tighlight = true,

    -- How long should above highlight last (in ms)
    highlight_duration = 250,

    -- The color of the above highlight. Must be a valid vim highlight group.
    -- (see :h highlight-group for options)
    highlight_group = 'CursorLine',

    -- Whether to create a visual selection after a movement to a node.
    -- If true, highlight is disabled and a visual selection is made in
    -- its place.
    select = false,

    -- Whether the plugin adds movements to the jumplist -- true | false | 'left'
    --  true: All movements more than 1 line are added to the jumplist. This is the default,
    --        and is meant to cover most use cases. It's modeled on how { and } natively add
    --        to the jumplist.
    --  false: Treewalker does not add to the jumplist at all
    --  "left": Treewalker only adds :Treewalker Left to the jumplist. This is usually the most
    --          likely one to be confusing, so it has its own mode.
    jumplist = true,
  },
}
