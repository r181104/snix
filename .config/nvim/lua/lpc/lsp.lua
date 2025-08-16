return {
    'neovim/nvim-lspconfig',
    config = function()
      require 'lspconfig'.setup()
    end
},
vim.lsp.config ( "lua_ls", {
  cmd = { '$HOME/.config/nvim/lsp/lua_ls' },
})
