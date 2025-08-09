vim = vim
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = "↪"
vim.o.sidescroll = 1
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 300
vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.swapfile = false
vim.o.backup = false
local undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.fn.mkdir(undodir, "p")
vim.o.undodir = undodir
vim.o.undofile = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.scrolloff = 8
vim.o.winborder = "rounded"

vim.g.mapleader = " "

vim.pack.add({
  { src = "https://github.com/ful1e5/onedark.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end
})
vim.cmd("set completeopt+=noselect")

vim.lsp.enable({ "lua_ls", "svelte-language-server", "tinymist" })

vim.keymap.set('n', '<leader>so', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set({ "n", "v", "x" }, "<Leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "x" }, "<Leader>d", '"+d', { noremap = true, silent = true })
vim.keymap.set({ "i", "v", "x" }, "jk", "<C-c>")

vim.keymap.set('n', '<leader>for', vim.lsp.buf.format)

vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>fh', ':Pick help<CR>')

vim.keymap.set('n', '<leader>e', ':Oil<CR>')

vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")

vim.keymap.set("n", "<leader>git", ":LazyGit<CR>")

require "mini.pick".setup()
require "oil".setup()
require("onedark").setup({
  function_style = "italic",
  transparent = true,
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  colors = { hint = "orange0", error = "#ff0000" },
  overrides = function(c)
    return {
      htmlTag = { fg = c.red0, bg = "#282c34", sp = c.hint, style = "underline" },
      DiagnosticHint = { link = "LspDiagnosticsDefaultHint" },
      TSField = {},
    }
  end
})

vim.cmd(":hi statusline guibg=NONE")
