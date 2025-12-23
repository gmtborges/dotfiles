return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"andymass/vim-matchup",
		},
		lazy = false,
		build = ":TSUpdate",
		config = function()
			vim.g.matchup_matchparen_enabled = 0
			local treesitter = require("nvim-treesitter")
			treesitter.install({
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"astro",
					"vimdoc",
					"query",
					"javascript",
					"typescript",
					"html",
					"css",
					"json",
					"markdown",
					"svelte",
					"templ",
					"go",
					"gotmpl",
					"helm",
					"dockerfile",
					"swift",
					"terraform",
				},
				matchup = {
					enable = true, -- mandatory, false will disable the whole extension
					disable = {}, -- optional, list of language that will be disabled
				},
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "<filetype>" },
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				-- max_lines = 3,
				-- zindex = 1,
			})
		end,
	},
}
