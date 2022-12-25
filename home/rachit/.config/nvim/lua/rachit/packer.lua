-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- Lua
    use "ahmedkhalf/project.nvim"

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        "nvim-telescope/telescope-file-browser.nvim",
        after = "telescope.nvim"
    }
    use {
        "nvim-telescope/telescope-project.nvim",
        after = {
            "telescope.nvim",
            "project.nvim"
        }
    }

    use 'yashguptaz/calvera-dark.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'windwp/windline.nvim'

    use({
        "utilyre/barbecue.nvim",
        branch = "dev", -- omit this if you only want stable updates
        requires = {
            "neovim/nvim-lspconfig",
            "smiteshp/nvim-navic",
            "kyazdani42/nvim-web-devicons", -- optional dependency
        },
        after = "nvim-web-devicons" -- keep this if you're using NvChad
    })

    use 'mbbill/undotree'

    use 'tpope/vim-fugitive'


    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

end)
