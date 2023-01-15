local telescope = require("telescope")
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find File" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set('n', '<leader>fd', telescope.extensions.file_browser.file_browser, { desc = "File Browser" })
vim.keymap.set('n', '<leader>fp', telescope.extensions.project.project, { desc = "Project" })

local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup {
    defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
        mappings = {
            n = {
                ['d'] = require('telescope.actions').delete_buffer
            },
            i = {
                ['<C-d>'] = require('telescope.actions').delete_buffer
            }
        }
    },
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
    extensions = {
        project = {
            hidden_files = true
        }
    }
}
telescope.load_extension("file_browser")
telescope.load_extension("project")
