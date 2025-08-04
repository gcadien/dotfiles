return {
  dir = "~/projects/europa.nvim",  -- Adjust to your actual local path
  name = "europa",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    print("europa config")
    require("europa").setup()
  end,
  lazy = false,
}

