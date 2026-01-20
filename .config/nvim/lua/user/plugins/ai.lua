return {
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},
	{
		"Exafunction/windsurf.nvim",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			require("codeium").setup({
				enable_cmp_source = false,
				virtual_text = {
					enabled = true,
				},
				workspace_root = {
					use_lsp = true,
				},
			})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		version = "^18.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/mcphub.nvim",
		},
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "ollama",
					},
					inline = {
						adapter = "ollama",
					},
				},
				adapters = {
					-- http = {
					-- 	["deepseek-r1"] = function()
					-- 		return require("codecompanion.adapters").extend("ollama", {
					-- 			name = "deepseek-r1",
					-- 			schema = {
					-- 				model = {
					-- 					default = "deepseek-r1:latest",
					-- 				},
					-- 			},
					-- 		})
					-- 	end,
					-- 	["glm-4.6"] = function()
					-- 		return require("codecompanion.adapters").extend("ollama", {
					-- 			name = "glm-4.6",
					-- 			schema = {
					-- 				model = {
					-- 					default = "glm-4.6:cloud",
					-- 				},
					-- 			},
					-- 		})
					-- 	end,
					-- },
				},
				extensions = {
					mcphub = {
						callback = "mcphub.extensions.codecompanion",
						opts = {
							-- MCP Tools
							make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
							show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
							add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
							show_result_in_chat = true, -- Show tool results directly in chat buffer
							format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
							-- MCP Resources
							make_vars = true, -- Convert MCP resources to #variables for prompts
							-- MCP Prompts
							make_slash_commands = true, -- Add MCP prompts as /slash commands
						},
					},
				},
			})
			vim.keymap.set(
				{ "n", "v" },
				"<leader>aa",
				"<cmd>CodeCompanionChat Toggle<cr>",
				{ noremap = true, silent = true }
			)
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		enabled = false,
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local home = vim.fn.expand("$HOME")
			require("chatgpt").setup({
				api_key_cmd = "gpg --decrypt " .. home .. "/openai-api-key.txt.gpg",
				openai_params = {
					model = "gpt-4o",
				},
			})
			vim.keymap.set({ "n", "v" }, "<leader>ate", "<cmd>ChatGPTRun translate<CR>")
			vim.keymap.set({ "n", "v" }, "<leader>atp", "<cmd>ChatGPTRun translate Brazilian Portuguese<CR>")
			vim.keymap.set({ "n", "v" }, "<leader>age", "<cmd>ChatGPTRun grammar_correction<CR>")
			vim.keymap.set({ "n", "v" }, "<leader>agp", "<cmd>ChatGPTRun grammar_correction Brazilian Portuguese<CR>")
		end,
	},
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
		},
		-- uncomment the following line to load hub lazily
		--cmd = "MCPHub",  -- lazy load
		-- build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
		-- uncomment this if you don't want mcp-hub to be available globally or can't use -g
		build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
		config = function()
			require("mcphub").setup({
				auto_approve = true,
				use_bundled_binary = true,
			})
		end,
	},
}
