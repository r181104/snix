local vim = vim
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.cursorcolumn = true
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
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
vim.g.maplocalleader = "\\"

vim.pack.add({
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/rcarriga/nvim-notify" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/folke/noice.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/navarasu/onedark.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/kdheepak/lazygit.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/cmp-path" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" }
})

-- Color Scheme
require "onedark".setup({
    style = "warmer",
    transparent = true,
    term_colors = true,
    code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'bold,italic',
        strings = 'italic',
        variables = 'bold'
    },
    colors = {},
    highlights = {},
    diagnostics = {
        darker = true,
        undercurl = true,
        background = true,
    }
})
require('onedark').load()

-- LuaLine
require("lualine").setup({
    options = {
        theme = "onedark",
        style = "warmer",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    }
})

-- For Commandline
require("noice").setup({
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
    }
})

-- Git Signs
require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
    }
})
vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git blame" })

-- Notifications
require("notify").setup({
    background_colour = "#000000",
})

-- For syntax highlighting
require 'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}

local cmp = require('cmp')
local luasnip = require('luasnip')
local lspconfig = require('lspconfig')
local servers = { 'lua_ls', 'rustfmt' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = require('cmp_nvim_lsp').default_capabilities()
    }
end

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer' },
    })
}

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    })
})

-- Key mappings
local map = vim.keymap.set
map('n', '<leader>so', ':update<CR> :source<CR>')
map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
map("n", "<leader>ter", ":vsplit | terminal<CR>", { desc = "Opens a terminal in vertical split" })
map({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard" })
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Move to left split" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Move to below split" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Move to above split" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Move to right split" })
map("n", "<leader>git", ":LazyGit<CR>", { desc = "Open LazyGit" })

local bufopts = { noremap = true, silent = true, buffer = bufnr }
map('n', 'gD', vim.lsp.buf.declaration, bufopts)
map('n', 'gd', vim.lsp.buf.definition, bufopts)
map('n', 'K', vim.lsp.buf.hover, bufopts)
map('n', 'gi', vim.lsp.buf.implementation, bufopts)
map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
map('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
map('n', '<space>rn', vim.lsp.buf.rename, bufopts)
map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
map('n', 'gr', vim.lsp.buf.references, bufopts)
map('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

vim.cmd(":hi statusline guibg=NONE")
