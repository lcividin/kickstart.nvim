return {
  'taigrr/neocrush.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'taigrr/glaze.nvim' },
  event = 'VeryLazy',
  opts = {
    terminal_width = 80,
    terminal_cmd = '~/.local/bin/crush-wrapper.sh',
    keys = {
      toggle = '<leader>cc',
      focus = '<leader>cf',
    },
  },
}
