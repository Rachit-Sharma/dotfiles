-- require('calvera').set()
require("catppuccin").setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	styles = {
		keywords = { "italic" },
		loops = { "italic" },
	},
})

-- setup must be called before loading
vim.cmd.colorscheme("catppuccin")
