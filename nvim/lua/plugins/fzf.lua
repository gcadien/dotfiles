return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  keys = {
    -- FILES -----------------------------------------------------------------
    {
	    "<leader>ff",
			function() require("fzf-lua").files() end,
      desc = "Files (cwd)"
    },
    {
      "<leader>fb",
      function() require("fzf-lua").buffers() end,
      desc = "Open buffers"
    }
  },
  opts = {}
}
