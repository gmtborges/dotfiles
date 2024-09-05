return {
	{
		"maxmx03/solarized.nvim",
		lazy = false,
		version = "*",
		priority = 1000,
		config = function()
			require("solarized").setup({
				transparent = {
					enabled = true, -- Master switch to enable transparency
					pmenu = true, -- Popup menu (e.g., autocomplete suggestions)
					normal = true, -- Main editor window background
					normalfloat = true, -- Floating windows
					neotree = true, -- Neo-tree file explorer
					nvimtree = true, -- Nvim-tree file explorer
					whichkey = true, -- Which-key popup
					telescope = true, -- Telescope fuzzy finder
					lazy = true, -- Lazy plugin manager UI
				},
				styles = {
					keywords = { bold = true },
					parameters = { italic = false },
					comments = { italic = true },
					functions = { bold = false },
				},
				on_highlights = function(colors, _)
					local groups = {
						["@operator"] = { fg = colors.base00 },
						["@variable"] = { fg = colors.base1, italic = false },
						["@variable.parameter"] = { fg = colors.base1, italic = false },
						["@property"] = { fg = colors.base1 },
						["@keyword"] = { fg = colors.green, bold = true },
						["@keyword.conditional"] = { bold = true },
						["@keyword.return"] = { bold = true },
						["@keyword.repeat"] = { bold = true },
						["@keyword.function"] = { fg = colors.green, bold = true },
						["@function.method.call"] = { fg = colors.blue, bold = false },
						["@type"] = { fg = colors.base1, bold = false },
						["@type.builtin"] = { fg = colors.yellow, bold = false },
						["@attribute"] = { bold = false },
						["@number"] = { fg = colors.magenta },
						["@string.escape"] = { fg = colors.orange },
						TelescopeSelection = { bg = colors.base02 },
						DiagnosticUnderlineError = { fg = "NONE", undercurl = true, sp = colors.diag_error },
						DiagnosticUnderlineWarn = { fg = "NONE", undercurl = true, sp = colors.diag_warn },
						DiagnosticUnderlineInfo = { fg = "NONE", undercurl = true, sp = colors.diag_info },
						DiagnosticUnderlineHint = { fg = "NONE", undercurl = true, sp = colors.blue },
						DiagnosticUnderlineOk = { fg = "NONE", undercurl = true, sp = colors.diag_ok },
						SpellBad = { fg = "NONE", undercurl = true, strikethrough = false, sp = colors.diag_error },
						SpellCap = { fg = "NONE", undercurl = true, sp = colors.blue },
						BufferLineBufferSelected = { bold = true },
					}
					return groups
				end,
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				groups = {
					all = {
						["@type"] = { fg = "palette.fg.default" },
						["@type.definition"] = { fg = "palette.fg.default" },
						["@module"] = { fg = "palette.fg.on_emphasis" },
						["@module.go"] = { fg = "palette.fg.on_emphasis" },
						["@tag.delimiter"] = { fg = "palette.fg.on_emphasis" },
						["@string.special"] = { fg = "palette.fg.on_emphasis" },
						["@string.special.url"] = { style = "NONE" },
						["@operator"] = { fg = "palette.fg.on_emphasis" },
						["@keyword.templ"] = { fg = "syntax.tag" },
						["@variable.member.lua"] = { fg = "palette.fg.default" },
						["@constructor"] = { fg = "syntax.func" },
					},
					github_light = {
						["@string"] = { fg = "#494B56" },
						["@string.special"] = { fg = "#494B56" },
					},
				},
				options = {
					transparent = true,
					darken = {
						floats = false,
					},
					styles = {
						comments = "italic",
						keywords = "bold",
						constants = "NONE",
					},
				},
			})
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		config = function()
			local c = require("vscode.colors").get_colors()
			require("vscode").setup({
				transparent = true,
				group_overrides = {
					["@keyword"] = { fg = c.vscBlue, bold = false },
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = true,
				style = "storm",
				styles = {
					comments = { italic = true },
					keywords = { bold = true, italic = false },
					sidebars = "transparent",
					floats = "transparent",
				},
				on_highlights = function(hl, c)
					hl["@module"] = {
						fg = c.orange,
					}
					hl["@keyword.import"] = {
						fg = c.purple,
					}
					hl["@keyword.directive"] = {
						fg = c.purple,
					}
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
				transparent = true,
				code_style = {
					comments = "italic",
					keywords = "bold",
					functions = "NONE",
				},
			})
		end,
	},
}
