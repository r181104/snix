return {
	"navarasu/onedark.nvim",
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "warmer",
			transparent = true,
			term_colors = true,
			code_style = {
				comments = "italic",
				keywords = "bold",
				functions = "italic,bold",
				strings = "italic",
				variables = "bold",
			},
			colors = {},
			highlights = {},
			diagnostics = {
				darker = true,
				undercurl = true,
				background = true,
			},
		})
		require("onedark").load()
	end,
}
