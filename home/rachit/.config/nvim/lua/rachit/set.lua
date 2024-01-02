-- modicator also wants this setting
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- nvim-tree also wants this setting
-- so does modicator
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
-- modicator wants this setting
vim.opt.cursorline = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- nvim-tree wants these
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- for neovide
vim.opt.guifont = { "VictorMono Nerd Font,FantasqueSansM Nerd Font Mono:h15" }
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_no_idle = true
vim.g.neovide_confirm_quit = true
vim.g.neovide_remember_window_size = true
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_vfx_particle_lifetime = 0.7
vim.g.neovide_cursor_vfx_particle_speed = 15
vim.g.neovide_cursor_vfx_particle_phase = 2
vim.g.neovide_cursor_vfx_particle_curl = 0.3
vim.g.neovide_cursor_antialiasing = true
