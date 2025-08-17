return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				-- Lua
				lua = { "stylua" },
				-- Python
				python = { "isort", "black" },
				-- JavaScript/TypeScript/JSX/TSX
				javascript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				-- JSON
				json = { { "prettierd", "prettier" } },
				-- HTML/CSS/SCSS
				html = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				scss = { { "prettierd", "prettier" } },
				-- Markdown
				markdown = { { "prettierd", "prettier" } },
				-- Go
				go = { "gofumpt", "goimports" },
				-- Rust
				rust = { "rustfmt" },
				-- Nix
				nix = { "nixpkgs-fmt" },
				-- Shell
				sh = { "shfmt" },
				-- YAML
				yaml = { "yamlfmt" },
				-- C/C++
				c = { "clang-format" },
				cpp = { "clang-format" },
				-- Java
				java = { "google-java-format" },
				-- SQL
				sql = { "sqlfmt" },
			},
		})
		vim.keymap.set({ "n", "v" }, "<leader>fm", function()
			require("conform").format({
				async = true,
				lsp_fallback = true,
				timeout_ms = 500,
			})
		end, { desc = "[F]or[m]at buffer" })
		vim.keymap.set("v", "<leader>f", function()
			require("conform").format({
				async = true,
				lsp_fallback = true,
				range = {
					["start"] = vim.api.nvim_buf_get_mark(0, "<"),
					["end"] = vim.api.nvim_buf_get_mark(0, ">"),
				},
			})
		end, { desc = "[F]ormat selection" })
	end,
}
