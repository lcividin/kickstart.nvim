return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then return vim.o.lines * 0.4 end
    end,
    open_mapping = [[<C-\>]],
    direction = 'horizontal',
    shade_terminals = true,
    start_insert = true,
  },
}
