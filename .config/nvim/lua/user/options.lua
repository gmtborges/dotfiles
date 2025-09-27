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
vim.opt.cursorline = true -- Highlight the current line
vim.opt.colorcolumn = "" -- Show column ruler
vim.opt.wrap = false -- Don't wrap lines

-- Custom fold text function to show the first line
local function custom_fold_text()
	local first_line = vim.fn.getline(vim.v.foldstart)
	local line_count = vim.v.foldend - vim.v.foldstart + 1
	return first_line .. " ... [" .. line_count .. " lines]"
end

-- Make the function available in the Lua namespace
_G.custom_fold_text = custom_fold_text

vim.opt.foldlevel = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.custom_fold_text()"

vim.opt.spelllang = { "pt_br", "en_us" }
vim.opt.spell = false

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "markdown", "text" },
--   callback = function()
--     vim.opt_local.spell = true
--   end,
-- })
