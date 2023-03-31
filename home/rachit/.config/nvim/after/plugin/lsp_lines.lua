require("lsp_lines").setup()

vim.keymap.set("", "<Leader>lst", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
