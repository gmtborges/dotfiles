return {
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
				api_key_cmd = "gpg --decrypt " .. home .. "/chatgpt-secret.txt.gpg",
				openai_params = {
					model = "gpt-4o",
				},
			})
			vim.keymap.set({ "n", "v" }, "<leader>at", "<cmd>ChatGPTRun translate<CR>")
			vim.keymap.set({ "n", "v" }, "<leader>ag", "<cmd>ChatGPTRun grammar_correction<CR>")
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		opts = {
			provider = "openai",
			hints = {
				enabled = false,
			},
		},
		-- if you want to download pre-built binary, then pass source=false. Make sure to follow instruction above.
		-- Also note that downloading prebuilt binary is a lot faster comparing to compiling from source.
		build = ":AvanteBuild",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to setup it properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	{
		"github/copilot.vim",
		enabled = true,
		config = function()
			vim.keymap.set(
				"i",
				"<C-TAB>",
				"copilot#Accept('<CR>')",
				{ noremap = true, silent = true, expr = true, replace_keycodes = false }
			)
			vim.keymap.set("i", "<C-S-TAB>", "copilot#Next()", { noremap = true, silent = true, expr = true })
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_enabled = 1
		end,
	},
	{
		"Exafunction/codeium.nvim",
		enabled = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
}
