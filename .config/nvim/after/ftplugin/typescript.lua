local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function(args)
    if require("lspconfig.util").root_pattern("eslint.config.js")(args.buf) then
      require("lint").try_lint({ "eslint" })
    end
  end,
})
