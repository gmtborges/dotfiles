return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
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
          "emmet_ls",
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
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
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

      vim.lsp.config('cssls', {
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

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })

      vim.lsp.config("html", {
        capabilities = capabilities,
      })

      vim.lsp.config("emmet_ls", {
        capabilities = capabilities,
      })


      vim.lsp.config('jsonls', {
        filetypes = { "json", "jsonc" },
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
        capabilities = capabilities,
      })

      vim.lsp.config('tailwindcss', {
        capabilities = capabilities,
      })

      vim.lsp.config('yamlls', {
        settings = {
          yaml = {
            schemas = {
              kubernetes = { "manifests/*.yaml", "**/manifests/**/*.yaml" },
              ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
            },
            format = {
              enable = true
            },
            validate = true,
            hover = true,
            completion = true
          },
        },
      })

      vim.lsp.config('astro', {
        capabilities = capabilities,
      })

      vim.lsp.config('marksman', {
        filetypes = { "markdown", "mdx" },
        capabilities = capabilities,
      })

      vim.lsp.config('ansiblels', {
        capabilities = capabilities,
      })

      vim.lsp.config('terraformls', {
        capabilities = capabilities,
      })
      vim.filetype.add({ extension = { tf = "terraform" } })

      vim.lsp.config('gopls', {
        capabilities = capabilities,
      })

      vim.lsp.config('templ', {
        capabilities = capabilities,
      })
      vim.filetype.add({ extension = { templ = "templ" } })

      vim.lsp.config('sqls', {
        capabilities = capabilities,
      })

      vim.lsp.config('helm_ls', {
        capabilities = capabilities,
      })

      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>h", vim.lsp.buf.code_action, opts)
          -- vim.keymap.set("n", "<leader>cf", function()
          --   vim.lsp.buf.format({ async = true })
          -- end, opts)
        end,
      })

      local signs = {
        ERROR = "",
        WARN = "",
        HINT = "",
        INFO = " ",
      }

      vim.diagnostic.config({
        virtual_text = true,
        underline = {
          severity = { min = vim.diagnostic.severity.WARN },
        },
        float = { border = "rounded" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = signs.ERROR,
            [vim.diagnostic.severity.WARN] = signs.WARN,
            [vim.diagnostic.severity.HINT] = signs.HINT,
            [vim.diagnostic.severity.INFO] = signs.INFO,
          }
        }
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "stylua",
          "prettierd",
          "yamlfmt",
          "gofumpt",
          "goimports-reviser",
          "sql_formatter",
          "tflint"
        },
        automatic_installation = true
      })
    end,
  }
}
