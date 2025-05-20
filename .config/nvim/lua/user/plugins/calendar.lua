return {
  {
    "itchyny/calendar.vim",
    config = function()
      vim.g.calendar_week_number = 1
      vim.keymap.set("n", "<leader>sc", ":Calendar -view=year -split=vertical -position=right -width=30<CR>")
      -- vim.api.nvim_set_hl(0, "CalendarSelect", { bg = "#C3D2FF" })
    end
  }
}
