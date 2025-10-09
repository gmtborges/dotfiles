return {
	{
		"echasnovski/mini.nvim",
		enabled = true,
		version = "*",
		config = function()
			local files = require("mini.files")
			files.setup({
				mappings = {
					synchronize = "<C-s>",
				},
			})

			vim.keymap.set("n", "<leader>fe", function()
				if not files.close() then
					files.open(vim.api.nvim_buf_get_name(0))
					files.reveal_cwd()
				end
			end)
		end,
	},
	{
		"A7Lavinraj/fyler.nvim",
		enabled = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		config = function()
			local fyler = require("fyler")
			fyler.setup({
				icon_provider = "nvim_web_devicons",
				win = {
					kind = "split_right_most",
				},
			})
			vim.keymap.set("n", "<leader>e", function()
				fyler.toggle({ kind = "split_right_most" })
			end)
		end,
	},
}
