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
          keywords = { bold = true },
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
          keywords = "bold"
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
        flavour = "frappe",
        transparent_background = true,
        no_italic = true,
        styles = {
          keywords = { "bold" },
        },
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
        custom_highlights = function(colors)
          return {
            ["@markup.heading.1.markdown"] = { fg = colors.red, style = { "bold" } },
            ["@markup.heading.2.markdown"] = { fg = colors.peach, style = { "bold" } },
            ["@markup.heading.3.markdown"] = { fg = colors.yellow, style = { "bold" } },
            ["@markup.heading.4.markdown"] = { fg = colors.green, style = { "bold" } },
            ["@markup.heading.5.markdown"] = { fg = colors.sapphire, style = { "bold" } },
            ["@markup.heading.6.markdown"] = { fg = colors.lavander, style = { "bold" } },
          }
        end
      })
    end
  }
}
