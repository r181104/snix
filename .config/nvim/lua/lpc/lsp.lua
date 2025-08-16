return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				opts = {
					ensure_installed = { "lua_ls", "pyright", "ts_ls" },
					automatic_installation = true,
					automatic_enable = true,
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				-- Add more filetypes/formatters
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)
			-- Manual format keymap
			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				require("conform").format({ lsp_fallback = true, timeout_ms = 500 })
			end, { desc = "Format file or range" })
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				python = { "pylint" },
				-- Add more
			}
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
			vim.keymap.set("n", "<leader>l", lint.try_lint, { desc = "Trigger linting" })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				opts = {
					ensure_installed = { "stylua", "black", "isort", "prettier", "eslint_d", "pylint" },
				},
			})
		end,
	},
}
