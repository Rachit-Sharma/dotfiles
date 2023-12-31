local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	"ahmedkhalf/project.nvim",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"nvim-telescope/telescope-project.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"ahmedkhalf/project.nvim",
		},
	},

	"yashguptaz/calvera-dark.nvim",
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"nvim-treesitter/nvim-treesitter-context",

	"windwp/windline.nvim",

	"mbbill/undotree",

	"tpope/vim-fugitive",

	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			{ "rafamadriz/friendly-snippets" },
		},
	},
	"nvimtools/none-ls.nvim",

	"norcalli/nvim-colorizer.lua",

	{
		"lewis6991/gitsigns.nvim",
		-- tag = 'release'
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},

	-- "windwp/nvim-ts-autotag", -- use emmet effectively and this won't be required

	"numToStr/Comment.nvim",

	"JoosepAlviste/nvim-ts-context-commentstring",

	"mattn/emmet-vim",

	-- 'stevearc/dressing.nvim'

	"junegunn/gv.vim",

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
		},
	},

	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",

	"romgrk/fzy-lua-native",
	"gelguy/wilder.nvim",

	"onsails/lspkind.nvim",

	"lvimuser/lsp-inlayhints.nvim",

	"luisdavim/pretty-folds",

	"ray-x/lsp_signature.nvim",

	"RRethy/vim-illuminate",

	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},

	"folke/which-key.nvim",

	{
		"mawkler/modicator.nvim",
		dependencies = {
			"yashguptaz/calvera-dark.nvim",
			"catppuccin",
		}, -- Add your colorscheme plugin here
	},

	"j-hui/fidget.nvim",

	"vim-scripts/zoom.vim",
}, {
	checker = {
		enabled = false,
	},
})
