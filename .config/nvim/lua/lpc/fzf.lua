return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function()
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
end
}
