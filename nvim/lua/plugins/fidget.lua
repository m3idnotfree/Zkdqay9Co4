return {
  'j-hui/fidget.nvim',
  event = 'LspAttach',
  opts = {
    progress = {
      poll_rate = 1,
      ignore_done_already = true,
      ignore_empty_message = true,
      display = {
        render_limit = 3,
      },
    },
  },
}
