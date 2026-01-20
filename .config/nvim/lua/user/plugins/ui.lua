return {
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<leader>so", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			symbols = {
				filter = { "String", "Variable", exclude = true },
			},
			outline_window = {
				position = "right",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local lsp_client = function()
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return ""
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
						{ "mode", separator = { left = "" }, right_padding = 2, color = { gui = "" } },
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
				},
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
			require("ibl").setup({
				indent = {
					char = "▏",
				},
				scope = {
					enabled = false,
				},
				exclude = {
					filetypes = { "dashboard", "sql", "dbout" },
				},
			})
		end,
		vim.keymap.set("n", "<leader>si", ":IBLToggle<CR>", { noremap = true, silent = true }),
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
				exclude_filetypes = { "swift" },
			})
		end,
	},
	{
		"nvimdev/dashboard-nvim",
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
			local fzf = require("fzf-lua")
			local fyler = require("fyler")
			local custom_center = {
				{
					icon = "  ",
					desc = "Find files                     ",
					key = "SPC p",
					action = function()
						fzf.files()
					end,
				},
				{
					icon = "  ",
					desc = "Open explorer                  ",
					key = "SPC e",
					action = function()
						fyler.toggle()
					end,
				},
				{
					icon = "  ",
					desc = "Find word                     ",
					key = "SPC f w",
					action = function()
						fzf.live_grep()
					end,
				},
				{
					icon = "  ",
					desc = "Find recent files             ",
					key = "SPC f r",
					action = function()
						fzf.oldfiles()
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
				hide = {
					tabline = false,
				},
				config = {
					header = custom_header,
					center = custom_center,
					footer = custom_footer,
				},
			})
		end,
	},
}
