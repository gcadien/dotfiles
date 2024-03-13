--
-- Experimental - Galaxyline
--

local condition = require("galaxyline.condition")
local vcs = require('galaxyline.provider_vcs')

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
        condition = condition.buffer_not_empty and vcs.check_git_workspace,
        --    require('galaxyline.provider_vcs').check_git_workspace,
--        condition = function()
--          if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
--            return true
--          end
--          return false
--        end,

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
