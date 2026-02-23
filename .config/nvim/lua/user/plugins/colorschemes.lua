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
				end,
			})
		end,
	},
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({
				transparent = false,
				lualine = {
					transparent = false,
				},
				code_style = {
					-- keywords = "bold",
				},
				highlights = {
					-- ["@boolean"] = { fmt = "bold" },
					-- ["@keyword.function"] = { fmt = "bold" },
					-- Statement = { fmt = "bold" },
					-- Boolean = { fmt = "bold" },
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
				background = {
					dark = "macchiato",
				},
				no_italic = false,
				transparent_background = true,
				styles = {
					keywords = { "bold" },
					conditionals = { "bold" },
					booleans = { "bold" },
				},
				lsp_styles = {
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
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
				end,
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false,
		priority = 1000,
		config = function()
			require("github-theme").setup({
				options = {
					transparent = false,
				},
			})
		end,
	},
	{
		"f-person/auto-dark-mode.nvim",
		enabled = false,
		opts = {
			update_interval = 3000,
			set_dark_mode = function()
				vim.api.nvim_set_option_value("background", "dark", {})
			end,
			set_light_mode = function()
				vim.api.nvim_set_option_value("background", "light", {})
			end,
		},
	},
}
