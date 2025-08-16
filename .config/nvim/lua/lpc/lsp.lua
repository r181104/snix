return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",                   -- Python
          "gopls",                     -- Go
          "ts_ls",                  -- TypeScript/JavaScript 
          "cssls",                     -- CSS
          "rust_analyzer",             -- Rust
          "clangd",                    -- C/C++
          "jdtls",                     -- Java
          "rnix",                      -- Nix
          -- "lua_ls",                    -- Lua
          "bashls",                    -- Shell (ADDED)
        },
        automatic_installation = true, -- ADDED: Auto-install missing servers
      })
    end
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Formatters
          "black",              -- Python
          "stylua",             -- Lua
          "prettierd",          -- JS/TS/CSS (BETTER: faster than prettier)
          "gofumpt",            -- Go (BETTER: stricter than gofmt)
          "rustfmt",            -- Rust
          "clang-format",       -- C/C++
          "google-java-format", -- Java
          "shfmt",              -- Shell (ADDED)
          "nixpkgs-fmt",        -- Nix (ADDED)

          -- Linters
          "eslint_d",        -- JS/TS
          "shellcheck",      -- Shell
          "stylelint",       -- CSS (ADDED)
        },
        auto_update = true,  -- ADDED
        run_on_start = true, -- ADDED
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")

      -- Common on_attach handler
      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        local map = vim.keymap.set

        map('n', 'gD', vim.lsp.buf.declaration, bufopts)
        map('n', 'gd', vim.lsp.buf.definition, bufopts)
        map('n', 'K', vim.lsp.buf.hover, bufopts)
        map('n', 'gi', vim.lsp.buf.implementation, bufopts)
        map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
        map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        map('n', 'gr', vim.lsp.buf.references, bufopts)
        map('n', '<leader>fr', function() vim.lsp.buf.format { async = true } end, bufopts)
      end

      -- Use mason-lspconfig's handlers for automatic setup
      require("mason-lspconfig").setup({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,

        -- Special configurations for specific servers
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              }
            }
          })
        end,

        ["jdtls"] = function()
          -- Java requires special handling
          -- Consider using nvim-jdtls plugin instead
        end,

        ["ts_ls"] = function()
          lspconfig.ts_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            init_options = {
              preferences = {
                importModuleSpecifierPreference = "relative"
              }
            }
          })
        end,
      })
    end
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Python
          null_ls.builtins.formatting.black,
          null_ls.builtins.diagnostics.mypy,

          -- Lua
          null_ls.builtins.formatting.stylua,

          -- Go
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports,

          -- JS/TS/CSS
          null_ls.builtins.formatting.prettierd.with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "scss" },
          }),
          -- null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.diagnostics.stylelint,

          -- C/C++
          null_ls.builtins.formatting.clang_format,

          -- Java
          null_ls.builtins.formatting.google_java_format,

          -- Shell
          null_ls.builtins.formatting.shfmt,

          -- Nix
          null_ls.builtins.formatting.nixpkgs_fmt,
        },
      })
    end
  }
}
