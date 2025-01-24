return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
      "nanotee/sqls.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "gopls",
          "templ",
          "html",
          "tailwindcss",
          "ts_ls",
          "jsonls",
          "yamlls",
          "terraformls",
          "astro",
          "ansiblels",
          "marksman",
          "helm_ls"
        },
      })
      local lspconfig = require("lspconfig")
      local capabilities =
          require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            diagnostics = { globals = "vim" },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              },
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            },
          },
        },
      })

      lspconfig.cssls.setup({
        settings = {
          scss = {
            lint = {
              idSelector = "warning",
              zeroUnits = "warning",
              duplicateProperties = "warning",
            },
            completion = {
              completePropertyWithSemicolon = true,
              triggerPropertyValueCompletion = true,
            },
          },
        },
        capabilities = capabilities,
      })

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.html.setup({
        capabilities = capabilities,
      })

      lspconfig.jsonls.setup({
        filetypes = { "json", "jsonc" },
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
        capabilities = capabilities,
      })

      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
      })

      -- lspconfig.yamlls.setup({
      -- 	settings = {
      -- 		yaml = {
      -- 			schemaStore = {
      -- 				enable = true,
      -- 				url = "https://www.schemastore.org/api/json/catalog.json",
      -- 			},
      -- 			schemas = {
      -- 				kubernetes = "manifests/**/*.yaml",
      -- 				["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
      -- 				["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
      -- 			},
      -- 		},
      -- 	},
      -- })

      -- lspconfig.yamlls.setup({
      --   settings = {
      --     yaml = {
      --       schemaStore = {
      --         enable = false,
      --         url = "",
      --       },
      --       schemas = require("schemastore").yaml.schemas(),
      --     },
      --   },
      -- })

      lspconfig.astro.setup({
        capabilities = capabilities,
      })

      lspconfig.marksman.setup({
        filetypes = { "markdown", "mdx" },
        capabilities = capabilities,
      })

      lspconfig.ansiblels.setup({
        capabilities = capabilities,
      })

      lspconfig.terraformls.setup({
        capabilities = capabilities,
      })

      lspconfig.gopls.setup({
        capabilities = capabilities,
      })

      lspconfig.templ.setup({
        capabilities = capabilities,
      })
      vim.filetype.add({ extension = { templ = "templ" } })

      lspconfig.sqls.setup({
        on_attach = function(client, bufnr)
          require("sqls").on_attach(client, bufnr) -- require sqls.nvim
        end,
      })

      lspconfig.helm_ls.setup({
        capabilities = capabilities,
      })

      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>h", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>cf", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })

      local _border = "rounded"

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = _border,
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = _border,
      })

      vim.diagnostic.config({
        float = { border = _border },
      })
    end,
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
      local cfg = require("yaml-companion").setup()
      require("lspconfig")["yamlls"].setup(cfg)


      vim.keymap.set("n", "<leader>ft", ":Telescope yaml_schema<CR>")
    end,
  }
}
