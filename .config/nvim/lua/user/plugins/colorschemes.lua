return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        style = "storm",
        styles = {
          commments = { italic = false },
          keywords = { italic = false },
          sidebars = "transparent",
          floats = "transparent",
        },
        on_colors = function(colors)
          colors.comment = "#7f87af"
        end,
        on_highlights = function(hl, c)
          hl.CopilotSuggestion = { fg = c.comment }
          hl["@module"] = { fg = c.orange }
        end
      })
    end,
  },
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({
        transparent = true,
        colors = {
          bg3 = "#474F5F"
        },
        code_style = {
          comments = "none"
        }
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
        transparent_background = true,
        no_italic = true,
        integrations = {
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        },
      })
    end
  }
}
