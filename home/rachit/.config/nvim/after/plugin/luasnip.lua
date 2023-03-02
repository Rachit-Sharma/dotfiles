local ls = require("luasnip")

ls.config.set_config({
	updateevents = "TextChanged,TextChangedI",
})

vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

ls.filetype_extend("javascript", { "javascriptreact" })
ls.filetype_extend("typescript", { "javascriptreact" })

require("luasnip.loaders.from_vscode").lazy_load({
	paths = "~/.local/share/nvim/site/pack/packer/start/friendly-snippets/snippets/javascript/jsdoc.json",
	include = { "javascript" },
})
