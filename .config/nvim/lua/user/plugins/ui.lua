return {
  {
    "nvim-lualine/lualine.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lsp_client = function()
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return ''
        end

        local c = {}
        local function contains(tbl, val)
          for _, v in pairs(tbl) do
            if v == val then
              return true
            end
          end
          return false
        end

        for _, client in pairs(clients) do
          if client.name == "terraformls" or client.name == "tflint" then
            if not contains(c, client.name) then
              table.insert(c, client.name)
            end
          else
            table.insert(c, client.name)
          end
        end
        return "[" .. table.concat(c, ", ") .. "]"
      end

      require("lualine").setup({
        options = {
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            { "mode", separator = { left = "" }, right_padding = 2 },
          },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = {
            {
              "filename",
              path = 1,
            },
          },
          lualine_x = {
            { lsp_client, color = { fg = "#999", gui = "bold" } },
            "encoding",
            "filetype",
          },
          lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
          },
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
        options = {

          style_preset = {
            bufferline.style_preset.no_italic,
          },

        }
      })
      vim.keymap.set("n", "<leader>bn", ":BufferLineMoveNext<CR>")
      vim.keymap.set("n", "<leader>bp", ":BufferLineMovePrev<CR>")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    main = "ibl",
    config = function()
      -- local github_dark_dimmed = {
      -- 	"github_dark_dimmed",
      -- }
      local solarized_dark = {
        "solarized_dark",
      }
      -- local tokyonight_day = {
      -- 	"tokyonight_day",
      -- }
      local solarized_light = {
        "solarized_light",
      }
      -- local github_light = {
      -- 	"github_light",
      -- }
      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "github_dark_dimmed", { fg = "#31363B" })
        vim.api.nvim_set_hl(0, "github_light", { fg = "#E1E2E4" })
        vim.api.nvim_set_hl(0, "tokyonight_day", { fg = "#D1D3E6" })
        vim.api.nvim_set_hl(0, "solarized_light", { fg = "#EEE8D5" })
        vim.api.nvim_set_hl(0, "solarized_dark", { fg = "#073642" })
      end)
      require("ibl").setup({
        scope = {
          enabled = false,
        },
        -- indent = {
        --   highlight = solarized_light,
        -- },
        exclude = {
          filetypes = { "dashboard", "sql", "dbout" },
        },
      })
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    enabled = true,
    cmd = "HighlightColors",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local hc = require("nvim-highlight-colors")
      hc.setup({
        render = "background",
        enable_tailwind = true,
        exclude_filetypes = { "swift" }
      })
    end,
  },
  {
    "glepnir/dashboard-nvim",
    enabled = false,
    config = function()
      local custom_header = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[  ██████   █████                   █████   █████  ███                  ]],
        [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
        [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
        [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
        [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
        [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
        [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
        [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }
      local custom_center = {
        {
          icon = "  ",
          desc = "Find files                     ",
          key = "SPC p",
          action = function()
            require("telescope.builtin").find_files({ previewer = false })
          end,
        },
        {
          icon = "  ",
          desc = "Open explorer                  ",
          key = "SPC e",
          action = ":NvimTreeToggle<CR>",
        },
        {
          icon = "  ",
          desc = "Find word                     ",
          key = "SPC f w",
          action = function()
            require("telescope.builtin").live_grep()
          end,
        },
        {
          icon = "  ",
          desc = "Find recent files             ",
          key = "SPC f r",
          action = function()
            require("telescope.builtin").oldfiles()
          end,
        },
      }
      local custom_footer = {
        [[ ]],
        [[ ]],
        "One day at a time  ",
      }
      require("dashboard").setup({
        theme = "doom",
        config = {
          header = custom_header,
          center = custom_center,
          footer = custom_footer,
        },
      })
    end,
  },
}
