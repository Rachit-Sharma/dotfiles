local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.nvim_workspace({
  library = vim.api.nvim_get_runtime_file('', true)
})
lsp.setup()

vim.keymap.set("n", "<leader>=", vim.lsp.buf.format)
