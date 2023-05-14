local ls = require("luasnip")

ls.config.set_config({
	updateevents = "TextChanged,TextChangedI",
})

ls.filetype_extend("javascript", { "javascriptreact" })
ls.filetype_extend("typescript", { "javascriptreact" })

require("luasnip.loaders.from_vscode").lazy_load({
	paths = "~/.local/share/nvim/site/pack/packer/start/friendly-snippets/snippets/javascript/jsdoc.json",
	include = { "javascript" },
})
