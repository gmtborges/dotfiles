return {
  {
    "echasnovski/mini.nvim",
    enabled = false,
    version = "*",
    config = function()
      local files = require("mini.files")
      files.setup({
        mappings = {
          synchronize = "<C-s>",
        },
      })

      vim.keymap.set("n", "<leader>e", function()
        if not files.close() then
          files.open(vim.api.nvim_buf_get_name(0))
          files.reveal_cwd()
        end
      end)
    end,
  },
  {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "echasnovski/mini.icons" },
    branch = "stable",
    opts = {},
    config = function()
      require("fyler").setup({
        views = {
          explorer = {
            width = 0.3,
            kind = "split:rightmost",
          }
        }

      })
      vim.keymap.set("n", "<leader>e", ":Fyler<CR>")
    end
  }
}
