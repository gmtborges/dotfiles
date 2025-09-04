return {
  {
    "echasnovski/mini.nvim",
    enabled = true,
    version = "*",
    config = function()
      local files = require("mini.files")
      files.setup({
        mappings = {
          synchronize = "<C-s>",
        },
      })

      vim.keymap.set("n", "<leader>fe", function()
        if not files.close() then
          files.open(vim.api.nvim_buf_get_name(0))
          files.reveal_cwd()
        end
      end)
    end,
  },
  {
    "A7Lavinraj/fyler.nvim",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- branch = "stable",
    opts = {
      icon_provider = "nvim_web_devicons"
    },
    config = function()
      require("fyler").setup({
        views = {
          explorer = {
            -- width = 0.3,
            -- kind = "split:rightmost"
            win = {
              kind = "split_right_most",
            }
          }
        }

      })
      vim.keymap.set("n", "<leader>e", ":Fyler kind=split_right_most<CR>")
    end
  }
}
