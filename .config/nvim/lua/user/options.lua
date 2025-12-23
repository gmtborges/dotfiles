vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.hidden = true -- Enable background buffers
vim.opt.inccommand = "split" -- Show command preview
vim.opt.shiftwidth = 2 -- Number of spaces inserted for each identation
vim.opt.tabstop = 2 -- Insert 4 spaces for a tab
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.incsearch = true -- Search strings as you type
vim.opt.hlsearch = true -- Highlight search strings
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Do not ignore case with Cvim.apitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.updatetime = 300 -- Quicker update
vim.opt.termguicolors = true -- True color support
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.mouse = "a" -- allow the mouse to be used
vim.opt.number = true -- Show number lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.showmode = false -- No need to show -- INSERT -- anymore
vim.opt.scrolloff = 8 -- Lines of context after EOL
vim.opt.listchars = { tab = "→ ", trail = "∙", eol = "¬" }
vim.opt.list = false
vim.opt.signcolumn = "yes"
vim.opt.exrc = true
vim.opt.winborder = "rounded"
-- Avante.nvim recommended
vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"

-- vim.opt.clipboard = "unnamedplus" -- Copy and paste with OS clipboard
vim.opt.cursorline = false -- Highlight the current line
vim.opt.colorcolumn = "" -- Show column ruler
vim.opt.wrap = false -- Don't wrap lines

vim.opt.foldlevel = 5
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.opt.spelllang = { "pt_br", "en_us" }
vim.opt.spell = false

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "markdown", "text" },
--   callback = function()
--     vim.opt_local.spell = true
--   end,
-- })
