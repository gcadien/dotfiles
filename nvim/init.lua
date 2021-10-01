require("plugins")
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

--vim.g.airline_powerline_fonts = 1

vim.cmd("autocmd BufEnter *.lua lua require'completion'.on_attach()")
vim.cmd("autocmd BufEnter *.py lua require'completion'.on_attach()")
vim.cmd("autocmd BufEnter *.jl lua require'completion'.on_attach()")

map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true, silent = true})
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true, silent = true})

vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}

-- Causes error
--vim.opt.shortmess:append({ 'c' })

--
-- Notes related vars and functions.
--
-- When this section gets large consider moving to separate notes.lua file and require here
--
local note_dir = "/home/geoff/NOTES"

vim.cmd('command! -nargs=? NoteNew :execute ":e" note_dir . "/<args>.md"')
vim.cmd('command! NoteEdit :Telescope find_files cwd=' .. note_dir)
vim.cmd('command! NoteQuick :e ' .. note_dir .. '/unfiled.md')
vim.cmd('command! NoteSearch :Telescope live_grep cwd=' .. note_dir)

map('n', '<leader>ni', ':e ~/NOTES/index.md<CR>')
map('n', '<leader>ne', ':NoteEdit<CR>')

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
    [110] = colors.gray,
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
    highlight = {colors.bg, colors.gray},
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

        highlight = {colors.gray, colors.bg2}
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
        highlight = {colors.gray, colors.bg2},
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
    provider = function() return vim.bo.filetype end,
    separator = ' '
  }
}

gls.right[2] = {
  LineColumn = {
    provider = function()
      vim.api.nvim_command('hi GalaxyLineColumn guibg='..mode_color())
      local line = vim.fn.line('.')
      local column = vim.fn.col('.')
      return string.format(" %d:%d ", line, column)
    end,

    separator = ' ',
    highlight = {colors.bg, mode_color()},
  }
}


--gls.left[2] = {
--  ViMode = {
--    provider = function()
--      -- auto change color according the vim mode
--      local alias = {
--          n = 'NORMAL',
--          i = 'INSERT',
--          c= 'COMMAND',
--          V= 'VISUAL',
--          [''] = 'VISUAL',
--          v ='VISUAL',
--          c  = 'COMMAND-LINE',
--          ['r?'] = ':CONFIRM',
--          rm = '--MORE',
--          R  = 'REPLACE',
--          Rv = 'VIRTUAL',
--          s  = 'SELECT',
--          S  = 'SELECT',
--          ['r']  = 'HIT-ENTER',
--          [''] = 'SELECT',
--          t  = 'TERMINAL',
--          ['!']  = 'SHELL',
--      }
--      local mode_color = {
--          n = colors.green,
--          i = colors.blue,v=colors.magenta,[''] = colors.blue,V=colors.blue,
--          c = colors.red,no = colors.magenta,s = colors.orange,S=colors.orange,
--          [''] = colors.orange,ic = colors.yellow,R = colors.purple,Rv = colors.purple,
--          cv = colors.red,ce=colors.red, r = colors.cyan,rm = colors.cyan, ['r?'] = colors.cyan,
--          ['!']  = colors.green,t = colors.green,
--          c  = colors.purple,
--          ['r?'] = colors.red,
--          ['r']  = colors.red,
--          rm = colors.red,
--          R  = colors.yellow,
--          Rv = colors.magenta,
--      }
--      local vim_mode = vim.fn.mode()
--      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim_mode])
--      return alias[vim_mode] .. '   '
--    end,
--    highlight = {colors.red,colors.line_bg,'bold'},
--  },
--}

--require('galaxyline').section.left[1]= {
--  FileSize = {
--    provider = 'FileSize',
--    condition = function()
--      if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
--        return true
--      end
--      return false
--      end,
--    icon = '   ',
--    highlight = {colors.green,colors.purple},
--    separator = '',
--    separator_highlight = {colors.purple,colors.darkblue},
--  }
--}
