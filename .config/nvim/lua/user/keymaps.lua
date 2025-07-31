vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "Q", "<nop>")

-- Save with Ctrl-s
vim.keymap.set({ "n" }, "<C-s>", ":update<CR>")

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')


-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- utils

-- Preserve cursor at the beginning
vim.keymap.set("n", "J", "mzJ`z")
-- Preserve cursor at the center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Preserve paste
vim.keymap.set("x", "<M-p>", '"_dP')
vim.keymap.set({ "n", "v" }, "<M-d>", '"_d')

-- Buffers
vim.keymap.set("n", "<C-n>", ":bprev<CR>")
vim.keymap.set("n", "<C-t>", ":bnext<CR>")
vim.keymap.set("n", "<leader>w", ":bd<CR>")
vim.keymap.set("n", "<leader>bk", ":bd!<CR>")
vim.keymap.set("n", "<leader>bK", ":%bd!<CR>")

-- Tabs
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>")
vim.keymap.set("n", "]t", ":tabnext<CR>")
vim.keymap.set("n", "]t", ":tabnext<CR>")
vim.keymap.set("n", "<leader>tk", ":tabclose<CR>")

-- Spilts
vim.keymap.set("n", "<M-h>", "<C-w><C-h>")
vim.keymap.set("n", "<M-l>", "<C-w><C-l>")
vim.keymap.set("n", "<M-j>", "<C-w><C-j>")
vim.keymap.set("n", "<M-k>", "<C-w><C-k>")

-- Spilts resize
vim.keymap.set("n", "<M-S-left>", "<C-w>>")
vim.keymap.set("n", "<M-S-right>", "<C-w><")
vim.keymap.set("n", "<M-S-down>", "<C-w>-")
vim.keymap.set("n", "<M-S-up>", "<C-w>+")

vim.keymap.set("n", "<leader>q", ":q<CR>")

-- Toggles
vim.keymap.set("n", "<leader>ss", ":set spell!<CR>")
vim.keymap.set("n", "<leader>sw", ":set wrap!<CR>")
vim.keymap.set("n", "<leader>sh", ":set hlsearch!<CR>")

-- Jumplist
vim.keymap.set(
  'n',
  'j',
  [[v:count ? (v:count >= 4 ? "m'" . v:count : '') . 'j' : 'gj']],
  { noremap = true, expr = true }
)

vim.keymap.set(
  'n',
  'k',
  [[v:count ? (v:count >= 4 ? "m'" . v:count : '') . 'k' : 'gk']],
  { noremap = true, expr = true }
)

local function filter_jumplist()
  local jumplist = vim.fn.getjumplist()
  local current_dir = vim.fn.getcwd()

  for i, jump in ipairs(jumplist[1]) do
    local bufnr = jump.bufnr
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    if not string.match(filepath, "^" .. vim.pesc(current_dir)) then
      vim.cmd("clearjumps " .. i)
    end
  end
end

vim.api.nvim_create_user_command("FilterJumplist", filter_jumplist, {})
vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = ":jumps",
  callback = filter_jumplist
})
