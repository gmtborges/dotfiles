return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local home = vim.fn.expand("$HOME")
      require("chatgpt").setup({
        api_key_cmd = "gpg --decrypt " .. home .. "/openai-api-key.txt.gpg",
        openai_params = {
          model = "gpt-4o",
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>ate", "<cmd>ChatGPTRun translate<CR>")
      vim.keymap.set({ "n", "v" }, "<leader>atp", "<cmd>ChatGPTRun translate Brazilian Portuguese<CR>")
      vim.keymap.set({ "n", "v" }, "<leader>age", "<cmd>ChatGPTRun grammar_correction<CR>")
      vim.keymap.set({ "n", "v" }, "<leader>agp", "<cmd>ChatGPTRun grammar_correction Brazilian Portuguese<CR>")
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    version = "*",
    opts = {
      provider = "claude",
      claude = {
        model = "claude-3-5-sonnet-20241022",
      },
      hints = {
        enabled = false,
      },
    },
    -- if you want to download pre-built binary, then pass source=false. Make sure to follow instruction above.
    -- Also note that downloading prebuilt binary is a lot faster comparing to compiling from source.
    build = "make",
    dependencies = {
      {
        "stevearc/dressing.nvim",
        opts = {
          input = {
            enabled = true,
          },
        },
      },
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- Make sure to setup it properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "Avante" },
        },
        ft = { "Avante" },
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = {
          auto_trigger = false,
          keymap = {
            accept = '<M-TAB>',
            next = '<M-]>',
            prev = '<M-[>',
          },
        },
        filetypes = {
          markdown = false,
          yaml = true,
        }
      })
    end,
  },
}
