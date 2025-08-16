return {
  'otavioschwanck/arrow.nvim',
  config = function()
    require('arrow').setup({
  show_icons = true,
  leader_key = '<leader>h',        -- Recommended to be a single key
  buffer_leader_key = 'm', -- Per Buffer Mappings
})
end
}
