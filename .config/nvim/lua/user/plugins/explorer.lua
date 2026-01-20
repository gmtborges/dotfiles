return {
	{
		"echasnovski/mini.nvim",
		enabled = false,
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
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		branch = "stable",
		config = function()
			local fyler = require("fyler")
			fyler.setup({
				integrations = {
					icon = "nvim_web_devicons",
				},
				views = {
					finder = {
						files = {
							enabled = false,
						},
						win = {
							kind = "split_left_most",
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
