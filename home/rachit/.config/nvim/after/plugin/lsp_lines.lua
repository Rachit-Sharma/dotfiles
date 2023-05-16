local lsp_lines = require("lsp_lines")
lsp_lines.setup()
lsp_lines.toggle()

local isVimDiagnosticVirtualTextEnabled = true
local toggleLspLinesAndVimDiagnosticVirtualText = function()
	isVimDiagnosticVirtualTextEnabled = not isVimDiagnosticVirtualTextEnabled
	lsp_lines.toggle()
	vim.diagnostic.config({
		virtual_text = isVimDiagnosticVirtualTextEnabled,
	})
end

vim.keymap.set("", "<Leader>lst", toggleLspLinesAndVimDiagnosticVirtualText, { desc = "Toggle lsp_lines" })
