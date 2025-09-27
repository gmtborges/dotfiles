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
			local eslint = lint.linters.eslint
			eslint.args = {
				"--no-warn-ignored", -- <-- this is the key argument
				"--format",
				"json",
				"--stdin",
				"--stdin-filename",
				function()
					return vim.api.nvim_buf_get_name(0)
				end,
			}
		end,
	},
}
