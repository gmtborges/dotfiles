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
		config = function()
			local fyler = require("fyler")
			fyler.setup({
				integrations = {
					icon = "nvim_web_devicons",
				},
				views = {
					finder = {
						win = {
							kind = "split_right_most",
						},
					},
				},
			})
			vim.keymap.set("n", "<leader>e", function()
				fyler.toggle()
			end)
		end,
	},
}
