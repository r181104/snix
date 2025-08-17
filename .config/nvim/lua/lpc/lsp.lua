local vim = vim
local root_files = {
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
	".git",
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		require("conform").setup({
			formatters_by_ft = {},
		})

		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local lspconfig = require("lspconfig")
		local lspconfig_util = require("lspconfig.util")

		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		-- Improved root directory detection with fallback
		local function get_project_root(fname)
			return lspconfig_util.root_pattern(unpack(root_files))(fname)
				or lspconfig_util.find_git_ancestor(fname)
				or vim.fn.getcwd()
		end

		-- Notification function for LSP attachment
		local notify_lsp_attach = function(client, bufnr)
			local msg = string.format("LSP: %s attached", client.name)
			vim.notify(msg, vim.log.levels.INFO, {
				title = "LSP Status",
				timeout = 1500,
				on_open = function(win)
					local buf = vim.api.nvim_win_get_buf(win)
					vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
				end,
			})
		end

		-- Common on_attach function
		local on_attach = function(client, bufnr)
			notify_lsp_attach(client, bufnr) -- Show attachment notification

			-- Enable formatting with conform.nvim
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
					buffer = bufnr,
					callback = function()
						require("conform").format({ bufnr = bufnr, async = false })
					end,
				})
			end

			-- Optional diagnostic helper
			if client.supports_method("textDocument/publishDiagnostics") then
				vim.api.nvim_create_autocmd("CursorHold", {
					buffer = bufnr,
					callback = function()
						vim.diagnostic.open_float(nil, {
							focusable = false,
							close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
							source = "always",
							prefix = " ",
							scope = "cursor",
						})
					end,
				})
			end
		end

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				-- "lua_ls",  --It don't work for someway when i install it through mason so i recommend to install thorugh your package manager
				"pyright",
				"rnix",
				"gopls",
				"tailwindcss",
				"html",
				"cssls",
				"jsonls",
				"yamlls",
				"bashls",
				"clangd",
				"jdtls",
				"sqlls",
			},
			handlers = {
				-- Default handler for all servers
				function(server_name)
					local config = {
						capabilities = capabilities,
						on_attach = on_attach,
						root_dir = function(fname)
							return get_project_root(fname)
						end,
					}

					-- Merge with server-specific config
					if server_specific[server_name] then
						config = vim.tbl_deep_extend("force", config, server_specific[server_name])
					end

					lspconfig[server_name].setup(config)
				end,
			},
		})

		-- Server-specific configurations
		local server_specific = {
			lua_ls = {
				settings = {
					Lua = {
						format = {
							enable = true,
							defaultConfig = {
								indent_style = "space",
								indent_size = "2",
							},
						},
						workspace = {
							checkThirdParty = false,
						},
					},
				},
			},

			pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				settings = {
					pyright = {
						disableOrganizeImports = false,
						analysis = {
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
						},
					},
				},
			},

			rnix = {
				settings = {
					nix = {
						formatCommand = "nixpkgs-fmt",
					},
				},
			},

			tailwindcss = {
				filetypes = {
					"html",
					"css",
					"scss",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
				},
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								"tw`([^`]*)",
								'tw="([^"]*)',
								'tw={"([^"}]*)',
								"tw\\.\\w+`([^`]*)",
								"tw\\(.*?\\)`([^`]*)",
							},
						},
					},
				},
			},

			jsonls = {
				cmd = { "vscode-json-language-server", "--stdio" },
			},
		}

		-- Setup rust-analyzer separately
		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = lspconfig_util.root_pattern("Cargo.toml", "rust-project.json", unpack(root_files)),
			settings = {
				["rust-analyzer"] = {
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- Diagnostic configuration
		vim.diagnostic.config({
			virtual_text = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
			-- Add this to show diagnostics on hover
			severity_sort = true,
			update_in_insert = false,
		})

		-- Show line diagnostics automatically in hover window
		vim.o.updatetime = 250
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				vim.diagnostic.open_float(nil, {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = "rounded",
					source = "always",
					prefix = " ",
				})
			end,
		})
	end,
}
