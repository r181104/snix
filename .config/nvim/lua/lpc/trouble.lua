return {
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup({
      icons = true,
    })
    local map = vim.keymap.set
    map("n", "<leader>tt", function()
      require("trouble").toggle()
    end)

    map("n", "[d", function()
      require("trouble").next({ skip_groups = true, jump = true });
    end)

    map("n", "]d", function()
      require("trouble").previous({ skip_groups = true, jump = true });
    end)
  end
}
