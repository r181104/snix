return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({})
		lspconfig.gopls.setup({})
		lspconfig.rust_analyzer.setup({})
		lspconfig.pylsp.setup({})
		lspconfig.clangd.setup({})
		lspconfig.html.setup({})
		lspconfig.cssls.setup({})
		lspconfig.jsonls.setup({})
		lspconfig.eslint.setup({})
		lspconfig.nixd.setup({})
		lspconfig.hyprls.setup({})
	end,
}
