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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { noremap = true, buffer = args.buf, silent = true }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>gr", vim.lsp.buf.references, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "[d", vim.diagnostic.goto_prev, opts)
    map("n", "]d", vim.diagnostic.goto_next, opts)
    map("n", "<leader>fd", vim.diagnostic.open_float, opts)
    map({"n", "v"}, "<leader>for", vim.lsp.buf.format, opts)
    end
})
map("n", "<leader>fe", vim.diagnostic.open_float, { desc = "Show diagnostics" })
map("n", "<leader>ce", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })
