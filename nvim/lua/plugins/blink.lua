-- lua/plugins/blink.lua
return {
  "Saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },   -- lazy-load on first need
  version = '1.*',
  opts  = {
    -- you can tune sources & keymaps later; these are the defaults
    sources = { default = { "lsp", "buffer", "snippets", "path" } },
    keymap  = { 
      preset = "default", 
      ["<cr>"] = { "select_and_accept", "fallback" },
      ["<tab>"] = { "select_next", "fallback"},
      ["<s-tab>"] = { "select_prev", "fallback"},
    },
  },
}

