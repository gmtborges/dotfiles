return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters = {
        prettierd = {
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/.prettierrc"),
          },
        },
        sql_formatter = {
          args = "-l postgresql",
        },
      },
      formatters_by_ft = {
        go = { "goimports-reviser", "gofumpt", stop_after_first = false },
        templ = { "templ" },
        sql = { "sql_formatter" },
        html = { "prettier", "prettierd", stop_after_first = true },
        javascript = { "prettier", "prettierd", stop_after_first = true },
        typescript = { "prettier", "prettierd", stop_after_first = true },
        typescriptreact = { "prettier", "prettierd", stop_after_first = true },
        javascriptreact = { "prettier", "prettierd", stop_after_first = true },
        css = { "prettier", "prettierd", stop_after_first = true },
        json = { "prettier", "prettierd", stop_after_first = true },
        markdown = { "prettier", "prettierd", stop_after_first = true },
        yaml = { "prettier", "prettierd", stop_after_first = true },
        terraform = { "terraform_fmt" },
        swift = { "swiftformat" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 1200,
        lsp_format = "fallback",
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>l", function()
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
