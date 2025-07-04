return {
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          inline = {
            adapter = "anthropic",
          },
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>",
        { noremap = true, silent = true })
    end
  },
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
    enabled = false,
    event = "VeryLazy",
    lazy = true,
    version = "*",
    opts = {
      provider = "claude",
      providers = {
        claude = {
          model = "claude-4-sonnet-20250514",
          disable_tools = true
        },
      },
      hints = {
        enabled = false,
      },
      windows = {
        width = 38
      }
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
    },
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = {
          auto_trigger = true,
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
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- uncomment the following line to load hub lazily
    --cmd = "MCPHub",  -- lazy load
    -- build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
    build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
    config = function()
      require("mcphub").setup({
        auto_aprove = true,
        use_bundled_binary = true,
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_vars = true,
              make_slash_commands = true,
              show_result_in_chat = true
            }
          },
          avante = {
            make_slash_commands = true,
          }
        }
      })
    end,
  }
}
