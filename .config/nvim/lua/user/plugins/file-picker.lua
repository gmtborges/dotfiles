return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local fzf = require("fzf-lua")

			fzf.setup({
				-- winopts = {
				-- 	preview = {
				-- 		layout = "horizontal",
				-- 	},
				-- },
				buffers = {
					cwd_only = true,
				},
				oldfiles = {
					cwd_only = true,
				},
			})

			vim.keymap.set("n", "<C-p>", function()
				fzf.files({ winopts = { preview = { hidden = true } } })
			end)
			vim.keymap.set("n", "<leader>p", function()
				fzf.files({ winopts = { preview = { hidden = true } } })
			end)

			vim.keymap.set("n", "<leader>o", function()
				fzf.buffers({ winopts = { preview = { hidden = true } }, sort_mru = true, ignore_current_buffer = true })
			end)
			vim.keymap.set("n", "<leader>fr", function()
				fzf.oldfiles({ winopts = { preview = { hidden = true } } })
			end)
			vim.keymap.set("n", "<leader>ff", function()
				fzf.files({ winopts = { preview = { hidden = true } }, no_ignore = true })
			end)
			vim.keymap.set("n", "<leader>fw", function()
				fzf.live_grep()
			end)

			-- LSP
			vim.keymap.set("n", "<leader>j", function()
				fzf.lsp_document_symbols()
			end)
			vim.keymap.set("n", "<leader>fd", function()
				fzf.lsp_definitions()
			end)
			vim.keymap.set("n", "<leader>fu", function()
				fzf.lsp_references()
			end)

			-- Builtin picker
			vim.keymap.set("n", "<leader>fz", function()
				fzf.builtin()
			end)

			-- GIT
			vim.keymap.set("n", "<leader>gs", function()
				fzf.git_status()
			end)
			vim.keymap.set("n", "<leader>gc", function()
				fzf.git_commits()
			end)
			vim.keymap.set("n", "<leader>gh", function()
				fzf.git_bcommits()
			end)
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		enabled = false,
		tag = "v0.1.9",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					-- file_ignore_patterns = { ".git/", "node_modules" },
					path_display = { "truncate" },
					-- layout_config = {
					--   horizontal = {
					--     width = { padding = 0 }
					--   },
					--   vertical = {
					--     width = { padding = 0 }
					--   }
					-- }
				},
				extensions = {
					fzf = true,
				},
				pickers = {
					-- find_files = {
					-- 	theme = "dropdown",
					-- },
					-- buffers = {
					-- 	theme = "dropdown",
					-- },
					oldfiles = {
						cwd_only = true,
					},
					-- lsp_document_symbols = {
					--   theme = "dropdown",
					--   symbol_width = 50,
					--   symbol_type_width = 10,
					-- },
					-- lsp_definitions = {
					--   theme = "dropdown",
					--   symbol_width = 50,
					--   symbol_type_width = 10,
					-- },
					-- lsp_references = {
					--   theme = "dropdown",
					--   symbol_width = 50,
					--   symbol_type_width = 10,
					-- },
					-- lsp_implementations = {
					--   theme = "dropdown",
					--   symbol_width = 50,
					--   symbol_type_width = 10,
					-- }
				},
			})
			-- vim.keymap.set("n", "<C-p>", function()
			-- 	builtin.find_files({ previewer = false, hidden = true })
			-- end)
			-- vim.keymap.set("n", "<leader>p", function()
			-- 	builtin.find_files({ previewer = false, hidden = true })
			-- end)
			--
			-- vim.keymap.set("n", "<leader>o", function()
			-- 	builtin.buffers({
			-- 		sort_mru = true,
			-- 		ignore_current_buffer = true,
			-- 		previewer = false,
			-- 	})
			-- end)
			-- vim.keymap.set("n", "<leader>fr", function()
			-- 	builtin.oldfiles({ previewer = false })
			-- end)
			-- vim.keymap.set("n", "<leader>ff", function()
			-- 	builtin.find_files({ previewer = false, hidden = true, no_ignore = true })
			-- end)
			-- vim.keymap.set("n", "<leader>fg", function()
			-- 	builtin.live_grep({ layout_strategy = "vertical" })
			-- end)
			-- vim.keymap.set("n", "<leader>fw", function()
			-- 	builtin.live_grep({ layout_strategy = "vertical" })
			-- end)
			--
			-- -- LSP
			-- vim.keymap.set("n", "<leader>j", function()
			-- 	builtin.lsp_document_symbols()
			-- end)
			-- vim.keymap.set("n", "<leader>fd", function()
			-- 	builtin.lsp_definitions()
			-- end)
			-- vim.keymap.set("n", "<leader>fu", function()
			-- 	builtin.lsp_references()
			-- end)
			--
			-- -- Builtin picker
			-- vim.keymap.set("n", "<leader>fz", function()
			-- 	builtin.builtin()
			-- end)
			--
			-- -- GIT
			-- vim.keymap.set("n", "<leader>gs", function()
			-- 	require("telescope.builtin").git_status()
			-- end)
			-- vim.keymap.set("n", "<leader>gc", function()
			-- 	require("telescope.builtin").git_commits()
			-- end)
			-- vim.keymap.set("n", "<leader>gh", function()
			-- 	require("telescope.builtin").git_bcommits()
			-- end)
		end,
	},
}
