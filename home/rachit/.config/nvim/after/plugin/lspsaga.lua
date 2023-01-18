local saga = require("lspsaga")

saga.setup({
    -- your configuration
})

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

-- Code action
vim.keymap.set({"n","v"}, "<leader>lca", "<cmd>Lspsaga code_action<CR>")

-- Rename
vim.keymap.set("n", "<leader>lgr", "<cmd>Lspsaga rename<CR>")

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
vim.keymap.set("n", "<leader>lgd", "<cmd>Lspsaga peek_definition<CR>")

-- Show line diagnostics you can pass argument ++unfocus to make
-- show_line_diagnostics float window unfocus
vim.keymap.set("n", "<leader>lsl", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- Show cursor diagnostic
-- also like show_line_diagnostics  support pass ++unfocus
vim.keymap.set("n", "<leader>lsc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

-- Show buffer diagnostic
vim.keymap.set("n", "<leader>lsb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

-- Diagnostic jump can use `<c-o>` to jump back
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Diagnostic jump with filter like Only jump to error
vim.keymap.set("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

-- Toggle Outline
vim.keymap.set("n","<leader>lo", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
-- if there has no hover will have a notify no information available
-- to disable it just Lspsaga hover_doc ++quiet
vim.keymap.set("n", "<leader>lK", "<cmd>Lspsaga hover_doc<CR>")

-- Callhierarchy
vim.keymap.set("n", "<Leader>lci", "<cmd>Lspsaga incoming_calls<CR>")
vim.keymap.set("n", "<Leader>lco", "<cmd>Lspsaga outgoing_calls<CR>")

-- Float terminal
vim.keymap.set({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
