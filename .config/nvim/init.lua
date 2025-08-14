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

vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/catppuccin/nvim" },
  { src = 'https://github.com/NvChad/showkeys',                cmd = "ShowkeysToggle" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/catgoose/nvim-colorizer.lua" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/rcarriga/nvim-notify" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/folke/noice.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/otavioschwanck/arrow.nvim" },
})

require "which-key".setup()
require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,
  float = {
    transparent = false,
    solid = false,
  },
  show_end_of_buffer = false,
  term_colors = true,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false,
  no_bold = false,
  no_underline = false,
  styles = {
    comments = { "italic" },
    conditionals = { "bold" },
    loops = {},
    functions = { "italic" },
    keywords = { "bold" },
    strings = { "bold" },
    variables = {},
    numbers = { "italic" },
    booleans = { "italic" },
    properties = {},
    types = {},
    operators = { "bold" },
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  auto_integrations = false,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
  },
})
vim.cmd.colorscheme "catppuccin-macchiato"

require("lualine").setup({
  options = {
    theme = "catppuccin-mocha",
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
  },
})

require('arrow').setup({
  show_icons = true,
  leader_key = ';',        -- Recommended to be a single key
  buffer_leader_key = 'm', -- Per Buffer Mappings
})

local fzf = require("fzf-lua")
fzf.setup({
  winopts = {
    height = 0.9,
    width = 0.9,
    preview = {
      hidden = "hidden",
    },
  },
  keymap = {
    fzf = {
      ["tab"] = "down",
      ["shift-tab"] = "up",
      ["ctrl-p"] = "toggle-preview",
    },
  },
})
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Search text" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Find buffers" })

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
  },
})

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
  },
})
vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "Git blame" })

require("notify").setup({
  background_colour = "#000000",
})

require "showkeys".setup({ position = "top-right" })
require('nvim-treesitter.configs').setup({
  auto_install = true,
  highlight = {
    enable = true,
  },
})
require "mason".setup()

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "bspwmrc", "sxhkdrc" },
  command = "set filetype=sh",
})

require("colorizer").setup({
  filetypes = {
    "*",
  },
  user_default_options = {
    RGB = true,
    RRGGBB = true,
    RRGGBBAA = true,
    AARRGGBB = true,
    rgb_fn = true,
    rgba_fn = true,
    hsl_fn = true,
    hsla_fn = true,
    css = true,
    css_fn = true,
    names = true,
    tailwind = true,
    sass = { enable = true, parsers = { "css" } },
    mode = "background",
    virtualtext = "■",
    always_update = true,
  },
})
vim.keymap.set("n", "<leader>tc", "<cmd>ColorizerToggle<CR>", { desc = "Toggle Colorizer" })

require("oil").setup({
  default_file_explorer = true,
  columns = { "icon" },
  view_options = { show_hidden = true },
  keymaps = {
    ["h"] = { "actions.parent", mode = "n", desc = "Go to parent directory" },
    ["l"] = { "actions.select", mode = "n", desc = "Open file/directory" },
    ["-"] = { "actions.parent", mode = "n", desc = "Go to parent directory (alt)" },
    ["_"] = { "actions.open_cwd", mode = "n", desc = "Set cwd to current directory" },
    ["<C-v>"] = { "actions.select", opts = { vertical = true }, mode = "n", desc = "Open in vertical split" },
    ["<C-x>"] = { "actions.select", opts = { horizontal = true }, mode = "n", desc = "Open in horizontal split" },
    ["<C-t>"] = { "actions.select", opts = { tab = true }, mode = "n", desc = "Open in new tab" },
    ["<C-p>"] = { "actions.preview", mode = "n", desc = "Preview file" },
    ["<C-r>"] = { "actions.refresh", mode = "n", desc = "Refresh directory" },
    ["g."] = { "actions.toggle_hidden", mode = "n", desc = "Toggle hidden files" },
    ["gx"] = { "actions.open_external", mode = "n", desc = "Open in external program" },
    ["q"] = { "actions.close", mode = "n", desc = "Close oil buffer" },
    ["<Esc>"] = {
      callback = function()
        if vim.fn.mode() == "n" then
          require("oil.actions").close.callback()
        end
      end,
      mode = "n",
      desc = "Close oil buffer in normal mode",
    },
    ["g?"] = { "actions.show_help", mode = "n", desc = "Show help" },
    ["gs"] = { "actions.change_sort", mode = "n", desc = "Change sort order" },
  },
  use_default_keymaps = false,
})

vim.cmd(":hi statusline guibg=NONE")

vim.lsp.enable({ "lua_ls", "svelte-language-server", "tinymist", "emmetls", "pylsp" })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end
})
vim.cmd("set completeopt+=noselect")

local map = vim.keymap.set
vim.g.mapleader = " "
map('n', '<leader>so', ':update<CR> :source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map({ "n", "v", "x" }, "<Leader>y", '"+y', { noremap = true, silent = true })
map({ "n", "v", "x" }, "<Leader>d", '"+d', { noremap = true, silent = true })
map({ "n", "v", "x" }, "<Leader>s", ":e #<CR>")
map({ "n", "v", "x" }, "<Leader>sf", ":sf #<CR>")
map({ "i", "v", "x", "t", "c" }, "a;", "<ESC>")
map('n', '<leader>for', vim.lsp.buf.format)
map('n', '<leader>e', ':Oil<CR>')
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")
map("n", "<leader>git", ":LazyGit<CR>")
map("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open oil file explorer" })
