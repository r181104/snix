return {
'navarasu/onedark.nvim',
  priority = 1000,
  config = function()
  require('onedark').setup {
  style = 'warmer',
  transparent = true,
  term_colors = true,
  code_style = {
    comments = 'italic',
    keywords = 'bold',
    functions = 'bold,italic',
    strings = 'italic',
    variables = 'bold'
	},
    }
require('onedark').load()
  end
}
