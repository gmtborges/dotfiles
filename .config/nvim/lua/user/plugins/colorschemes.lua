return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        -- transparent = true,
        style = "storm",
        styles = {
          keywords = { bold = true, italic = false },
          sidebars = "transparent",
          floats = "transparent"
        },
        on_colors = function(c)
          c.comment = "#7f87af"
          c.bg_statusline = c.none
        end,
        on_highlights = function(hl, c)
          hl.CopilotSuggestion = { fg = c.comment }
          hl["@module"] = { fg = c.orange }
          hl.TabLineFill = { bg = c.none }
          hl.LineNr = { fg = "#565d82" }
          hl.LineNrAbove = { fg = "#565d82" }
          hl.LineNrBelow = { fg = "#565d82" }
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
        -- transparent = true,
        lualine = {
          transparent = true
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
        flavour = "macchiato",
        -- transparent_background = true,
        styles = {
          keywords = { "bold" },
          conditionals = { "bold" }
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
            ["@tag.attribute"] = { style = {} },
          }
        end
      })
    end
  }
}
