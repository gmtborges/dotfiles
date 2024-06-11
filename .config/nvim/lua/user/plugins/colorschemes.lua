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
          keywords = { bold = true, italic = false },
          sidebars = "transparent",
          floats = "transparent",
        },
        on_colors = function(colors)
          colors.comment = "#7f87af"
        end,
        on_highlights = function(hl, c)
          hl.CopilotSuggestion = { fg = c.comment }
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
        code_style = {
          keywords = "bold",
        },
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
        styles = {
          keywords = { "bold" },
          conditionals = { "bold" },
        },
        color_overrides = {
          macchiato = {
            text = "#c3c6e2"
          }
        },
        custom_highlights = function(colors)
          return {
            ["@module"] = { style = { "bold" } },
            ["@markup.heading.1.markdown"] = { fg = colors.mauve, style = { "bold" } },
            ["@markup.heading.1.telekasten"] = { fg = colors.mauve, style = { "bold" } },
            ["@markup.heading.2.markdown"] = { fg = colors.peach, style = { "bold" } },
            ["@markup.heading.2.telekasten"] = { fg = colors.peach, style = { "bold" } },
            ["@markup.heading.3.markdown"] = { fg = colors.yellow, style = { "bold" } },
            ["@markup.heading.3.telekasten"] = { fg = colors.yellow, style = { "bold" } },
            ["@markup.heading.4.markdown"] = { fg = colors.green, style = { "bold" } },
            ["@markup.heading.4.telekasten"] = { fg = colors.green, style = { "bold" } },
          }
        end
      })
    end
  }
}
