-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()
-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_file = '~/Documents/grdrive/org',
  org_default_notes_file = '~/Documents/grdrive/org/refile.org'
})

local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local util = require('util')
local config = require('orgmode.config')
print("OrgMode test: " .. config.opts.org_agenda_files[1])
print('NotesFile: ' .. config.opts.org_default_notes_file)
--print('agenda files ' .. orgmode.org_agenda_files[1])
--util.map('n', '<leader>oi',':e '.. config.opts.org_agenda_files[1] .. '/index.org<CR>', {silent = true})
util.map('n', '<leader>jj',':e ~/gdrive/org/index.org<CR>', {silent = true})

