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

-- tsserver organize imports
-- https://www.reddit.com/r/neovim/comments/lwz8l7/how_to_use_tsservers_organize_imports_with_nvim/
local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

local lsp_attach = function()
    vim.keymap.set('n', '<leader>lro', organize_imports, { desc = 'Organize Imports' })
    -- More keybindings and commands....
end

require 'lspconfig'.tsserver.setup {
    on_attach = lsp_attach,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
        }
    }
}
