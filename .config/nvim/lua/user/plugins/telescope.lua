return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        file_ignore_patterns = { ".git/", "node_modules" },
        -- layout_config = {
        --   horizontal = {
        --     width = { padding = 0 }
        --   },
        --   vertical = {
        --     width = { padding = 0 }
        --   }
        -- }
      },
      extensions = {
        fzf = true,
      },
      pickers = {
        -- find_files = {
        --   theme = "dropdown",
        -- },
        -- buffers = {
        --   theme = "dropdown",
        -- },
        oldfiles = {
          cwd_only = true,
        },
        -- lsp_document_symbols = {
        --   theme = "dropdown",
        --   symbol_width = 50,
        --   symbol_type_width = 10,
        -- },
        -- lsp_definitions = {
        --   theme = "dropdown",
        --   symbol_width = 50,
        --   symbol_type_width = 10,
        -- },
        -- lsp_references = {
        --   theme = "dropdown",
        --   symbol_width = 50,
        --   symbol_type_width = 10,
        -- },
        -- lsp_implementations = {
        --   theme = "dropdown",
        --   symbol_width = 50,
        --   symbol_type_width = 10,
        -- }
      },
    })
    vim.keymap.set("n", "<C-p>", function()
      builtin.find_files({ previewer = false, hidden = true })
    end)
    vim.keymap.set("n", "<leader>p", function()
      builtin.find_files({ previewer = false, hidden = true })
    end)

    vim.keymap.set("n", "<leader>o", function()
      builtin.buffers({
        sort_mru = true,
        ignore_current_buffer = true,
        previewer = false,
      })
    end)
    vim.keymap.set("n", "<leader>fr", function()
      builtin.oldfiles({ previewer = false })
    end)
    vim.keymap.set("n", "<leader>ff", function()
      builtin.find_files({ previewer = false, hidden = true, no_ignore = true })
    end)
    vim.keymap.set("n", "<leader>fg", function()
      builtin.live_grep({ layout_strategy = 'vertical' })
    end)
    vim.keymap.set("n", "<leader>fw", function()
      builtin.live_grep({ layout_strategy = 'vertical' })
    end)

    -- LSP
    vim.keymap.set("n", "<leader>j", function()
      builtin.lsp_document_symbols({ symbols = { "method", "function" } })
    end)
    vim.keymap.set("n", "<leader>fd", function()
      builtin.lsp_definitions()
    end)
    vim.keymap.set("n", "<leader>fm", function()
      builtin.lsp_references()
    end)

    -- GIT
    vim.keymap.set("n", "<leader>gs", function()
      require("telescope.builtin").git_status()
    end)
    vim.keymap.set("n", "<leader>gc", function()
      require("telescope.builtin").git_commits()
    end)
    vim.keymap.set("n", "<leader>gh", function()
      require("telescope.builtin").git_bcommits()
    end)
  end,
}
