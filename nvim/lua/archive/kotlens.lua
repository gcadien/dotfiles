
-- lazy.nvim style
return {
  dir = "/home/geoff/projects/kotlens/kotlens.nvim",
  name = "kotlens",
  config = function()
  require("kotlens").setup({
      dev_mode = {
          enabled = true,
          agent_dir = "~/projects/kotlens/kotlens-agent",
      },
      keymaps = {
          explain = "<leader>ke",
      }
  })
  end
}
