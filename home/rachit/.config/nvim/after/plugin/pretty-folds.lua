-- " toggle folds
vim.keymap.del({ "n", "v" }, "<Space>")
-- " <2-LeftMouse>     Open fold, or select word or % match.
vim.keymap.del("n", "<2-LeftMouse>", { expr = true })

-- "fold paragraph
vim.keymap.del("n", "<leader>fp")
vim.keymap.set("n", "<leader>zp", "V}kzf")
-- "fold same indentation
vim.keymap.del("n", "<leader>fi")
vim.keymap.set("n", "<leader>zi", "<Cmd>call SelectIndent()<CR>zf")
-- fold tags
vim.keymap.del("n", "<leader>ft")
vim.keymap.set("n", "<leader>zt", "Vatzf")
-- "fold brackets
vim.keymap.del("n", "<leader>fb")
vim.keymap.set("n", "<leader>zb", "V%zf")
vim.keymap.del("n", "<leader>ff")
vim.keymap.set("n", "<leader>zf", "[{V%zf")
