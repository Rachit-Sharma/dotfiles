vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle, { desc = "Toggle Nvim Tree" })

-- empty setup using defaults
require("nvim-tree").setup()
