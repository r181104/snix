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
          "rust_analyzer",
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
      lspconfig.rnix.setup({
        capabilities = capabilities
      })
      lspconfig.gopls.setup({
        capabilities = capabilities
      })
      lspconfig.pyright.setup({
        capabilities = capabilities
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities
      })
      local map = vim.keymap.set
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      map('n', 'gD', vim.lsp.buf.declaration, bufopts)
      map('n', 'gd', vim.lsp.buf.definition, bufopts)
      map('n', 'K', vim.lsp.buf.hover, bufopts)
      map('n', 'gi', vim.lsp.buf.implementation, bufopts)
      map('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      map('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
      map('n', '<space>rn', vim.lsp.buf.rename, bufopts)
      map('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
      map('n', 'gr', vim.lsp.buf.references, bufopts)
      map('n', '<space>fr', function() vim.lsp.buf.format { async = true } end, bufopts)
    end
  }
}
