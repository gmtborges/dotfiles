return {
  {
    "iamcco/markdown-preview.nvim",
    enabled = true,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npx --yes yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    config = function()
      vim.keymap.set("n", "<leader>sm", ":MarkdownPreviewToggle<CR>")
    end,
  },
}
