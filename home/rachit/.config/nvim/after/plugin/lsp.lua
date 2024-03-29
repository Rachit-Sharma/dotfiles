local lsp = require("lsp-zero").preset({
	manage_nvim_cmp = {
		set_basic_mappings = false,
	},
})
local lspkind = require("lspkind")

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr, preserve_mappings = false })
end)

lsp.set_sign_icons({
	error = "✘",
	warn = "▲",
	hint = "⚑",
	info = "»",
})

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {},
	handlers = {
		lsp.default_setup,
	},
})

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
		{ name = "buffer" },
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			--[[ before = function(entry, vim_item)
                -- ...
                return vim_item
            end ]]
		}),
	},
	mapping = {
		["<Tab>"] = cmp_action.luasnip_supertab(),
		["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-e>"] = cmp_action.toggle_completion(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
	},
})

vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, { desc = "LSP Format" })

-- tsserver organize imports
-- https://www.reddit.com/r/neovim/comments/lwz8l7/how_to_use_tsservers_organize_imports_with_nvim/
local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = "",
	}
	vim.lsp.buf.execute_command(params)
end

local tsserver_attach = function(client, bufnr)
	vim.keymap.set("n", "<leader>lro", organize_imports, { desc = "Organize Imports" })
	-- require("lsp-inlayhints").on_attach(client, bufnr)
	vim.lsp.inlay_hint.enable(bufnr, true)
	-- More keybindings and commands....
end

require("lspconfig").tsserver.setup({
	on_attach = tsserver_attach,
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
})

local gopls_attach = function(client, bufnr)
	-- require("lsp-inlayhints").on_attach(client, bufnr)
	vim.lsp.inlay_hint.enable(bufnr, true)
	-- More keybindings and commands....
end

require("lspconfig").gopls.setup({
	on_attach = gopls_attach,
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})

-- Java
vim.env.JAVA_HOME = "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/"
