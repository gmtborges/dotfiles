return {
  {
    "itchyny/calendar.vim",
    config = function()
      vim.g.calendar_week_number = 1
      vim.keymap.set("n", "<leader>tc", ":Calendar -view=year -split=vertical -position=right -width=30<CR>")
    end
  }
}