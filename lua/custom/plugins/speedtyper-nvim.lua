return {
  'NStefan002/speedtyper.nvim',
  branch = 'v2',
  lazy = false,
  opts = {},
  config = function()
    local map = vim.keymap.set
    -- Example keymaps for speedtyper
    map('n', '<leader>sp', '<cmd>Speedtyper<CR>', { desc = 'Start typing test' })
    map('n', '<leader>spl', '<cmd>SpeedtyperLeaderboard<CR>', { desc = 'Show leaderboard' })
    map('n', '<leader>spf', '<cmd>SpeedtyperFloat<CR>', { desc = 'Start typing test in float window' })
  end,
}
