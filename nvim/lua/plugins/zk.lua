return {
  'zk-org/zk-nvim',
  main = 'zk',
  event = 'VeryLazy',
  ft = 'markdown',
  cmd = { 'ZkNew', 'ZkNotes', 'ZkTags', 'ZkMatch' },
  opts = {
    picker_options = {
      snacks_picker = {
        layout = {
          preset = 'ivy',
        },
      },
    },
  },
}
