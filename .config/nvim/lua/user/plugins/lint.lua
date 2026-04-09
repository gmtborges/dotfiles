return {
	{
		"mfussenegger/nvim-lint",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "eslint" },
				typescript = { "eslint" },
				javascriptreact = { "eslint" },
				typescriptreact = { "eslint" },
				astro = { "eslint" },
				terraform = { "tflint" },
			}
			vim.keymap.set("n", "<leader>cl", function()
				lint.try_lint()
			end)
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
