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
        -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
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
    use 'nvim-treesitter/nvim-treesitter-context'

    use 'windwp/windline.nvim'

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
    use 'jose-elias-alvarez/null-ls.nvim'

    use 'norcalli/nvim-colorizer.lua'

    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release'
    }

    use "windwp/nvim-autopairs"

    use 'windwp/nvim-ts-autotag'

    use 'numToStr/Comment.nvim'

    use 'JoosepAlviste/nvim-ts-context-commentstring'

    use 'mattn/emmet-vim'

    -- use 'stevearc/dressing.nvim'

    use 'junegunn/gv.vim'

    use "lukas-reineke/indent-blankline.nvim"

    use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"

    use 'romgrk/fzy-lua-native'
    use 'gelguy/wilder.nvim'

    use 'onsails/lspkind.nvim'

    use 'lvimuser/lsp-inlayhints.nvim'

    use 'luisdavim/pretty-folds'

    use "ray-x/lsp_signature.nvim"

    use "RRethy/vim-illuminate"

    use({
        "glepnir/lspsaga.nvim",
        branch = "main"
    })

    use "folke/which-key.nvim"

    use { 'melkster/modicator.nvim',
        after = 'catppuccin', -- Add your colorscheme plugin here
    }

    use 'j-hui/fidget.nvim'

end)
