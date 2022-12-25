-- require('calvera').set()
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    styles = {
	    strings = { "italic" }
    }
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
