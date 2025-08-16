local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup("lpc")

local opt = vim.opt
-- --------------------------------------------------------------------------
-- Appearance
-- --------------------------------------------------------------------------
opt.number = true -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers
opt.termguicolors = true -- Enable true color support
opt.cursorline = true -- Highlight the current line
opt.cursorcolumn = true -- Highlight the current column
opt.showmode = false -- Don't show mode (handled by statusline)
opt.signcolumn = "yes" -- Always show the sign column
-- --------------------------------------------------------------------------
-- Indentation
-- --------------------------------------------------------------------------
opt.tabstop = 2 -- Number of spaces per tab
opt.shiftwidth = 2 -- Number of spaces for each indentation
opt.softtabstop = 2 -- Number of spaces for <Tab> in insert mode
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Smart autoindenting
opt.autoindent = true -- Copy indent from current line when starting new one
-- --------------------------------------------------------------------------
-- Text Wrapping
-- --------------------------------------------------------------------------
opt.wrap = true -- Enable line wrapping
opt.linebreak = true -- Wrap lines at convenient points
opt.showbreak = "↪" -- Show this symbol at wrapped lines
opt.sidescroll = 1 -- Minimal number of columns to scroll horizontally
-- --------------------------------------------------------------------------
-- Search
-- --------------------------------------------------------------------------
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search contains uppercase
-- --------------------------------------------------------------------------
-- Performance
-- --------------------------------------------------------------------------
opt.updatetime = 300 -- Faster completion
opt.timeout = true
opt.timeoutlen = 500 -- Shorter timeout for mapped sequences
-- --------------------------------------------------------------------------
-- Splits
-- --------------------------------------------------------------------------
opt.splitbelow = true -- Horizontal splits below
opt.splitright = true -- Vertical splits to the right
-- --------------------------------------------------------------------------
-- Undo and Backup
-- --------------------------------------------------------------------------
opt.swapfile = false -- Don't use swapfile
opt.backup = false -- Don't create backup files
local undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.fn.mkdir(undodir, "p") -- Create undodir if it doesn't exist
opt.undodir = undodir -- Set undo directory
opt.undofile = true -- Enable persistent undo
-- --------------------------------------------------------------------------
-- Search Highlighting
-- --------------------------------------------------------------------------
opt.hlsearch = true -- Don't highlight all search matches
opt.incsearch = true -- Show matches as you type
-- --------------------------------------------------------------------------
-- Scroll Offset
-- --------------------------------------------------------------------------
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.isfname:append("@-@") -- Allow @ in file names
-- --------------------------------------------------------------------------
-- Keymaps
-- --------------------------------------------------------------------------
local map = vim.keymap.set
map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
map("n", "<leader>so", ":update source<CR>", { desc = "Quit" })
map("n", "<leader>ter", ":terminal<CR>", { desc = "Opens a terminal" })
map({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Move to left split" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Move to below split" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Move to above split" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Move to right split" })
map("n", "<leader>git", ":LazyGit<CR>", { desc = "Open LazyGit" })
map("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open oil file explorer" })
