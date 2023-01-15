vim.g.mapleader = " "

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
vim.keymap.set({ "n", "v" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
vim.keymap.set({ "n", "v" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without writing to register" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy rest of line to system clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>V", [["+p]], { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Find and replace word under cursor" })
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file runnable" })
