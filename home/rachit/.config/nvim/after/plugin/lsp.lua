local lsp = require('lsp-zero')
local lspkind = require('lspkind')

lsp.preset('recommended')
lsp.nvim_workspace({
    library = vim.api.nvim_get_runtime_file('', true)
})

lsp.setup_nvim_cmp({
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            --[[ before = function(entry, vim_item)
                -- ...
                return vim_item
            end ]]
        })
    }
})

lsp.setup()

vim.keymap.set("n", "<leader>=", vim.lsp.buf.format, { desc = "LSP Format" })
