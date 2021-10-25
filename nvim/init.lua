require("plugins")
--require('options')

local function map(mode, combo, mapping, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

-- Source old init.vim until converted to lua
vim.cmd('source ~/.config/nvim/old_init.vim')
vim.cmd("set termguicolors")
vim.cmd('syntax enable')
vim.opt.background = 'dark'
vim.cmd('colorscheme gruvbox')

vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true

vim.g.mapleader = " "
vim.g.maplocalleader = ","
--vim.g.airline_theme = "gruvbox"

-- File related mappings
map('n', '<leader>fs', ':write<CR>', {silent = true})

-- Window related mappings
map('n', '<leader>wq', '<c-w>q')
map('n', '<leader>wv', '<c-w>v')
map('n', '<leader>ws', '<c-w>s')
map('n', '<leader>wh', '<c-w>h')
map('n', '<leader>wl', '<c-w>l')
map('n', '<leader>wk', '<c-w>k')
map('n', '<leader>wj', '<c-w>j')


-- Buffer related mappings
map('n', '<leader>bb', ':Telescope buffers<CR>', {silent = true})
map('n', '<leader>q', ':quit<CR>', {silent = true})

vim.g.markdown_fenced_languages = {'lua', 'java', 'python'}
vim.opt.conceallevel = 2

-- Python
require('lspconfig').pyright.setup {}

-- Lua
require('lspconfig').sumneko_lua.setup {
  cmd = {"/usr/bin/lua-language-server"};
  settings = {
    Lua = {
      runtime = {
        version = 'Lua 5.4',
        path = {
          '?.lua',
          '?/init.lua',
          vim.fn.expand'~/.luarocks/share/lua/5.4/?.lua',
          vim.fn.expand'~/.luarocks/share/lua/5.4/?/init.lua',
          '/usr/share/5.4/?.lua',
          '/usr/share/lua/5.4/?/init.lua'
        }
      },
      diagnostics = {
        globals = {'vim', 'use_rocks'},
      },
      workspace = {
        library = {
          [vim.fn.expand'~/.luarocks/share/lua/5.4'] = true,
          ['/usr/share/lua/5.4'] = true,
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        }
      }
    }
  }
}

-- Julia
require('lspconfig').julials.setup {}

require'lspconfig'.jdtls.setup{
cmd = {
      '/usr/bin/java',
	    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
	    '-Dosgi.bundles.defaultStartLevel=4',
	    '-Declipse.product=org.eclipse.jdt.ls.core.product',
	    '-Dlog.level=ALL',
	    '-Xmx1G',
      --'-jar /home/geoff/Applications/jdtls/plugins/org.eclipse.equinox.launcher_*.jar',
      '-jar', '/home/geoff/Applications/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210908-1257.jar',
	    '-configuration', '/home/geoff/Applications/jdtls/config_linux',
	    '-data', '/home/geoff/.local/share/eclipse',
	    '--add-modules=ALL-SYSTEM',
	    '--add-opens java.base/java.util=ALL-UNNAMED',
	    '--add-opens java.base/java.lang=ALL-UNNAMED'
    }
}
--vim.g.airline_powerline_fonts = 1

--vim.cmd("autocmd BufEnter *.lua lua require'completion'.on_attach()")
--vim.cmd("autocmd BufEnter *.py lua require'completion'.on_attach()")
--vim.cmd("autocmd BufEnter *.jl lua require'completion'.on_attach()")
--vim.cmd("autocmd BufEnter *.java lua require'completion'.on_attach()")
--vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")
--map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true, silent = true})
--map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true, silent = true})

--vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}

-- Causes error
--vim.opt.shortmess:append({ c = true })

local actions = require('telescope.actions')
local action_state = require "telescope.actions.state"
local note_link = function()
  require('telescope.builtin').find_files()
end

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      }
    }
  },
  pickers = {
    find_files = {
      mappings = {
        i = {
          ["<C-l>"] = function(prompt)
            local inspect = require('inspect')
            actions.close(prompt)
            print("prompt "..prompt)
            local selection = action_state.get_selected_entry()
            print(inspect(selection))
            print(selection.value)
            print(selection.cwd)

            local buf = vim.api.nvim_get_current_buf()
            print("Buff: "..buf)
            print("Name: "..vim.api.nvim_buf_get_name(0))
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            print("Row: " .. row .. " Col: " .. col)
            print(vim.fn.expand(selection.value))
            vim.api.nvim_buf_set_text(buf, row-1,col,row-1,col, {"[".. selection.value .. "](" .. selection.cwd .. '/' ..selection.value..")"})
          end
        }
      }
    }
  }
}
--
-- Notes related vars and functions.
--
-- When this section gets large consider moving to separate notes.lua file and require here
--
local note_dir = "/home/geoff/NOTES"
--vim.opt.pandoc.syntax.conceal.urls = 1
vim.cmd('command! -nargs=? NoteNew :execute ":e" note_dir . "/<args>.md"')
vim.cmd('command! NoteEdit :Telescope find_files cwd=' .. note_dir)
vim.cmd('command! NoteQuick :e ' .. note_dir .. '/unfiled.md')
vim.cmd('command! NoteSearch :Telescope live_grep cwd=' .. note_dir)

map('n', '<leader>ni', ':e ~/NOTES/index.md<CR>')
map('n', '<leader>ne', ':NoteEdit<CR>')
--map('n', '<leader>nl', "<cmd>lua require('notes').note_link()<CR>")
-- Binding for reloading init.lua.
map('n', '<leader>rl', ':source ~/dotfiles/nvim/init.lua<CR>', {silent = true})



--
-- Experimental - Galaxyline
--

local colors = {
  lightbg = "#504945",
  black = '#272727',
  red = "#cc231c",
  green = "#989719",
  yellow = "#d79920",
  blue = "#458588",
  purple = "#b16185",
  cyan = "#689d69",
  white = "#ebdbb2",
  orange = '#d65d0e',
  fg = '#ebdbb2',
  fg0 = 'fbf1c7',
  fg4 = '#a89984',
  bg = '#282828',
  bg1 = '#3c3836',
  bg2 = '#504945',
  bg3 = '#665c54',
  gray = '#928374'
}

local arrow = {
      left = "",
      right = "",
      main_icon = "  ",
      vi_mode_icon = " ",
      position_icon = " ",
   }

local mode_color = function()
  local mode_colors = {
    [110] = colors.fg4,
    [105] = colors.blue,
    [99] = colors.orange,
    [86] = colors.orange,
    [118] = colors.orange,
    [22] = colors.orange,
  }
  return mode_colors[vim.fn.mode():byte()]
end

local function file_readonly()
    if vim.bo.filetype == 'help' then return '' end
    if vim.bo.readonly == true then return '  ' end
    return ''
end

local function get_current_file_name()
    local file = vim.fn.expand('%:t')
    if vim.fn.empty(file) == 1 then return '' end
    if string.len(file_readonly()) ~= 0 then return file .. file_readonly() end
    if vim.bo.modifiable then
        if vim.bo.modified then return file .. '  ' end
    end
    return file .. ' '
end

local gls = require('galaxyline').section
--local colors = require('galaxyline.theme').default
local buffer = require('galaxyline.provider_buffer')
--gls.left[2] = {
--  BufferNumber = {
--    provider = buffer.get_buffer_number
--  }
--}
--
--gls.left[2] = {
--  BufferNumber = {
--    provider = buffer.get_buffer_number,
--    highlight = {colors.red, colors.blue},
--  }
--}

--gls.left[1] = {
--  FirstElement = {
--    provider = function() return ' ' end,
--    highlight = {colors.fg, colors.gray},
--  }
--}
gls.left[1] = {
  ViMode = {
    provider = function()
      local mode_alias = {
        [110] = ' NORMAL',
        [105] = ' INSERT',
        [99] = ' COMMAND',
        [86] = ' V-LINE',
        [118] = ' VISUAL',
        [22] = ' V-BLOCK',

      }
      vim.api.nvim_command('hi GalaxyViMode gui=bold guibg='..mode_color())

      local mode = vim.fn.mode():byte()
      return ' ' .. mode_alias[mode] .. ' '
    end,
    highlight = {colors.bg, colors.gray, 'bold'},
    --separator = ' ',
    --separator_highlight ={colors.gray, colors.gray}
    --separator = '',
    --separator_highlight = function() return {colors.blue, colors.bg2} end,
  }
}
gls.left[2] = {
    GitIcon = {
        provider = function() return '   ' end,
        --condition = buffer_not_empty and
        --    require('galaxyline.provider_vcs').check_git_workspace,
        condition = function()
          if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
            return true
          end
          return false
        end,

        highlight = {colors.fg1, colors.bg2}
    }
}
gls.left[3] = {
    GitBranch = {
        provider = 'GitBranch',
        condition = function()
          if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
            return true
          end
          return false
        end,

        separator = '',
        highlight = {colors.fg1, colors.bg2},
        separator_highlight = {colors.bg2, colors.bg1}
    }
}

gls.left[4] = {
  FileName = {
    provider = get_current_file_name,
    separator = ' ',
    highlight= {colors.gray, colors.bg1}

  }
}
gls.right[1] = {
  BufferType = {
    provider = function() return vim.bo.filetype .. ' ' end,
    separator = '',
    highlight= {colors.gray, colors.bg1},
    separator_highlight = {colors.bg1, colors.bg}
  }
}

gls.right[2] = {
  LineColumn = {
    provider = function()
      vim.api.nvim_command('hi GalaxyLineColumn guibg='..mode_color())
      local line = vim.fn.line('.')
      local column = vim.fn.col('.')
      return string.format("  %d:%d ", line, column)
    end,

    --separator = ' ',
    highlight = {colors.bg, mode_color()},
    separator_highlight = {colors.bg, mode_color()},
    --separator_highlight = {colors.bg, colors.gray}
   -- separator_highlight = function()
   --   print("Separator Highlight".. mode_color())
   --   return {mode_color(), colors.bg1}
   -- end
  }
}


