vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle)

-- empty setup using defaults
require("nvim-tree").setup()
