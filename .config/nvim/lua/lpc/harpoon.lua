return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		local map = vim.keymap.set
		map("n", "<leader>ha", function()
			harpoon:list():add()
		end)
		map("n", "<leader>he", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		map("n", "<M-p>", function()
			harpoon:list():select(1)
		end)
		map("n", "<M-n>", function()
			harpoon:list():select(2)
		end)
		map("n", "<M-t>", function()
			harpoon:list():select(3)
		end)
		map("n", "<M-s>", function()
			harpoon:list():select(4)
		end)
		map("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		map("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
}
