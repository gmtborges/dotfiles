return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_win_position = "right"
    vim.g.db_ui_execute_on_save = 0
    vim.g.db_ui_save_location = "~/Dropbox/db_ui"
    vim.g.db_ui_disable_mappings_sql = 1
  end,
  config = function()
    vim.keymap.set("n", "<leader>sd", ":DBUIToggle<CR>")

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "sql",
      callback = function()
        vim.keymap.set({ "n", "v" }, "<F5>", "<Plug>(DBUI_ExecuteQuery)")
        -- F17 is <S-F5>
        vim.keymap.set("n", "<F17>", "<Plug>(DBUI_SaveQuery)")
      end,
    })
  end,
}
