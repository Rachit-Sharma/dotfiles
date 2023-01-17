local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.diagnostics.commitlint,
		null_ls.builtins.diagnostics.write_good,
		null_ls.builtins.formatting.sql_formatter,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.beautysh,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.yamlfmt,
	},
})
