return {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = true,
}
--return {
--  "nvim-neorg/neorg",
--  dependencies = { "nvim-lua/plenary.nvim" },
--  build = ":Neorg sync-parsers",
--  -- tag = "*",
--  lazy = true, -- enable lazy load
--  ft = "norg", -- lazy load on file type
--  cmd = "Neorg", -- lazy load on command
--  config = function()
--    require("neorg").setup {
--      load = {
--        ["core.defaults"] = {}, -- Loads default behaviour
--        ["core.concealer"] = {}, -- Adds pretty icons to your documents
--        ["core.dirman"] = { -- Manages Neorg workspaces
--          config = {
--            workspaces = {
--              notes = "~/notes",
--            },
--          },
--        },
--      },
--    }
--  end,
--}
