return {
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			local files = require("mini.files")
			files.setup({
				mappings = {
					synchronize = "<C-s>",
				},
			})

			vim.keymap.set("n", "<leader>e", function()
				if not files.close() then
					files.open(vim.api.nvim_buf_get_name(0))
					files.reveal_cwd()
				end
			end)
		end,
	},
}
