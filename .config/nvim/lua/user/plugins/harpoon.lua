return {
	"ThePrimeagen/harpoon",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		vim.keymap.set("n", "<leader>,", mark.add_file)
		vim.keymap.set("n", "<leader>.", ui.toggle_quick_menu)
	end,
}
