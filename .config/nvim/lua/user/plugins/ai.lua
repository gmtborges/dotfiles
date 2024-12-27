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
      -- vim.keymap.set({ "n", "v" }, "<leader>at", "<cmd>ChatGPTRun translate<CR>")
      vim.keymap.set({ "n", "v" }, "<leader>at", "<cmd>ChatGPTRun translate Brazilian Portuguese<CR>")
      -- vim.keymap.set({ "n", "v" }, "<leader>ag", "<cmd>ChatGPTRun grammar_correction<CR>")
      vim.keymap.set({ "n", "v" }, "<leader>ag", "<cmd>ChatGPTRun grammar_correction Brazilian Portuguese<CR>")
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = "*",
    opts = {
      provider = "claude",
      claude = {
        model = "claude-3-5-sonnet-20241022",
      },
      openai = {
        model = "gpt-4o"
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
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
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
          markdown = true,
          yaml = true,
          typescriptreact = true
        }
      })
    end,
  },
}
