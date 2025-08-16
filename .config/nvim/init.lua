local jim = vim
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

require("lazy").setup(
  "lpc",
  {
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})

local opt = vim.opt
opt.number = true 
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true 
opt.cursorcolumn = true
opt.showmode = false 
opt.signcolumn = "yes" 
opt.tabstop = 2 
opt.shiftwidth = 2 
opt.softtabstop = 2 
opt.expandtab = true 
opt.smartindent = true
opt.autoindent = true 
opt.wrap = true 
opt.linebreak = true
opt.showbreak = "↪" 
opt.sidescroll = 1 
opt.ignorecase = true 
opt.smartcase = true 
opt.updatetime = 300
opt.timeout = true
opt.timeoutlen = 500 
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false 
opt.backup = false 
local undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.fn.mkdir(undodir, "p") 
opt.undodir = undodir 
opt.undofile = true 
opt.hlsearch = false
opt.incsearch = true
opt.scrolloff = 8 
opt.isfname:append("@-@")

local augroup = vim.api.nvim_create_augroup
local LpcGroup = augroup('lpc', {})
local autocmd = vim.api.nvim_create_autocmd

local map = vim.keymap.set
map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
map("n", "<leader>so", ":source ~/.config/nvim/init.lua <CR>", { desc = "Quit" })
map("n", "<leader>ter", ":terminal<CR>", { desc = "Opens a terminal" })
map({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Move to left split" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Move to below split" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Move to above split" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Move to right split" })
map("n", "<leader>git", ":LazyGit<CR>", { desc = "Open LazyGit" })

-- Prime's remaps
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

autocmd('LspAttach', {
    group = LpcGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        map("n", "gd", function() vim.lsp.buf.definition() end, opts)
        map("n", "K", function() vim.lsp.buf.hover() end, opts)
        map("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)
        map("n", "<leader>fd", function() vim.diagnostic.open_float() end, opts)
        map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        map("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
        map("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
        map("i", "<C-s>", function() vim.lsp.buf.signature_help() end, opts)
    end
})
map("n", "<leader>fe", vim.diagnostic.open_float, { desc = "Show diagnostics" })
map("n", "<leader>ce", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })
