return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup({
        options = {
          gitsigns = { enabled = true }, -- disables git signs
        },
      })
      vim.keymap.set("n", "<leader>tz", ":ZenMode<CR>")
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {},
    config = function()
      require("lsp_signature").setup({
        hint_prefix = "→ ",
      })
    end,
  },
  {
    "github/copilot.vim",
    enabled = true,
    config = function()
      vim.keymap.set(
        "i",
        "<C-TAB>",
        "copilot#Accept('<CR>')",
        { noremap = true, silent = true, expr = true, replace_keycodes = false }
      )
      vim.keymap.set("i", "<C-S-TAB>", "copilot#Next()", { noremap = true, silent = true, expr = true })
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_enabled = 0
    end,
  },
  {
    "Exafunction/codeium.nvim",
    enabled = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({})
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },
}
