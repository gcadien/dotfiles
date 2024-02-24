local M = {
  'akinsho/org-bullets.nvim',
  event = 'VeryLazy',
  config = function()
    require('org-bullets').setup()
  end
}

return M

