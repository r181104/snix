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
          "ts_ls",
          "gopls",
          "pyright",
          "starlark_rust",
          "rnix",
          -- "lua_ls"
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities
      })
      lspconfig.rnix.setup({
        capabilities = capabilities
      })
      lspconfig.gopls.setup({
        capabilities = capabilities
      })
      lspconfig.pyright.setup({
        capabilities = capabilities
      })
      lspconfig.starlark_rust.setup({
        capabilities = capabilities
      })
      local vim = vim
      local map = vim.keymap.set
      local bufopts = { noremap = true, silent = true, buffer = buffer }
      map('n', 'gD', vim.lsp.buf.declaration, bufopts)
      map('n', 'gd', vim.lsp.buf.definition, bufopts)
      map('n', 'K', vim.lsp.buf.hover, bufopts)
      map('n', 'gi', vim.lsp.buf.implementation, bufopts)
      map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
      map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
      map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
      map('n', 'gr', vim.lsp.buf.references, bufopts)
    end
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
        },
      })
      local bufopts = { noremap = true, silent = true, buffer = buffer }
      vim.keymap.set('n', '<leader>fr', function() vim.lsp.buf.format { async = true } end, bufopts)
    end
  }
}
