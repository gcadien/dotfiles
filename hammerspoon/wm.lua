require "hs.application"
--require "hs.window.filter"
--spaces = require("hs.spaces")


local logger = hs.logger.new('wm','debug')

local function focus(direction)
  local fn = "focusWindow" .. (direction:gsub("^%l", string.upper))

  return function()
    local win = hs.window:focusedWindow()
    if not win then 
      return 
    end
    win[fn]()
  end
end



-- move current window to the space sp
--function moveCurrentWindowToSpace(sp)
--    local log = hs.logger.new('mymodule','debug')
--    local win = hs.window.focusedWindow()      -- current window
--    --local uuid = win:screen():spacesUUID()     -- uuid for current screen
--    --local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
--    --log.i(string.format('UUID: %s', uuid))
--    --log.i(string.format('spaceID: %s',spaceID))
--    --spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
----    spaces.changeToSpace(spaceID)              -- follow window to new space
--    moveWindowToSpace(win, sp)
--end
--
---- move current window to the space sp
--function MoveWindowToSpace(sp)
--   local win = hs.window.focusedWindow()      -- current window
--   --local uuid = win:screen():spacesUUID()     -- uuid for current screen
--   local uuid = spaces.focusedSpace()     -- uuid for current screen
--   local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
--   spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
--   spaces.changeToSpace(spaceID)              -- follow window to new space
--end
--
--function moveWindowToSpace(win, space)
--   -- local uuid = win:screen():spacesUUID()     -- uuid for current screen
--   local uuid = spaces.focusedSpace()     -- uuid for current screen
--    logger.i("UUID: " .. uuid)
--    --logger.i("Number of Spaces: " .. #spaces.layout()[uuid])
--    --local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
--    local spaceId = spaces.spacesForScreen()[space]
--    logger.i(spaceId)
--    spaces.moveWindowToSpace(win:id(), spaceId) -- move window to new space
--end
--
--hs.hotkey.bind({"cmd", "alt"}, "1", function() moveCurrentWindowToSpace(1) end)
--hs.hotkey.bind({"cmd", "alt"}, "2", function() moveCurrentWindowToSpace(2) end)
--hs.hotkey.bind({"cmd", "alt"}, "3", function() moveCurrentWindowToSpace(6) end)
--hs.hotkey.bind({"cmd", "alt"}, "4", function() moveCurrentWindowToSpace(2) end)
--hs.hotkey.bind({"cmd", "alt"}, "5", function() moveCurrentWindowToSpace(6) end)
--hs.hotkey.bind({"cmd", "alt"}, "6", function() moveCurrentWindowToSpace(6) end)
--hs.hotkey.bind({"cmd", "alt"}, "7", function() moveCurrentWindowToSpace(6) end)

hs.hotkey.bind({"cmd", "alt"}, "right", focus("east"))
hs.hotkey.bind({"cmd", "alt"}, "left", focus("west"))
hs.hotkey.bind({"cmd", "alt"}, "up", focus("north"))
hs.hotkey.bind({"cmd", "alt"}, "down", focus("south"))
hs.hotkey.bind({"cmd", "alt"}, "h", function()
  if hs.window.focusedWindow() then
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2 - 1
    f.h = max.h
    win:setFrame(f)
    else
      hs.alert.show("No active window")
    end
  end)

hs.hotkey.bind({"cmd", "alt"}, "l", function()
  if hs.window.focusedWindow() then
    local log = hs.logger.new('mymodule','debug')
    log.i(hs.screen.primaryScreen():frame())
    log.i(hs.screen.allScreens()[3])
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + (max.w / 2) + 1
    f.y = max.y
    f.w = max.w / 2 + 1
    f.h = max.h

    log:i(max.x)
    win:setFrame(f)
    else
      hs.alert.show("No active window")
    end
  end)

hs.hotkey.bind({"cmd", "alt"}, "u", function()
  if hs.window.focusedWindow() then
    local log = hs.logger.new('mymodule','debug')
    log.i(hs.screen.primaryScreen():frame())
    log.i(hs.screen.allScreens()[3])
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2 + 1
    f.h = max.h / 2 + 1

    log:i(max.x)
    win:setFrame(f)
    else
      hs.alert.show("No active window")
    end
end)

hs.hotkey.bind({"cmd", "alt"}, "o", function()
  if hs.window.focusedWindow() then
    local log = hs.logger.new('mymodule','debug')
    log.i(hs.screen.primaryScreen():frame())
    log.i(hs.screen.allScreens()[3])
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + (max.w /2) + 1
    f.y = max.y
    f.w = max.w / 2 + 1
    f.h = max.h / 2 + 1

    log:i(max.x)
    win:setFrame(f)
    else
      hs.alert.show("No active window")
    end
end)

hs.hotkey.bind({"cmd", "alt"}, ".", function()
  if hs.window.focusedWindow() then
    local log = hs.logger.new('mymodule','debug')
    log.i(hs.screen.primaryScreen():frame())
    log.i(hs.screen.allScreens()[3])
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x + (max.w /2) + 1
    f.y = max.y + (max.h / 2) + 1
    f.w = max.w / 2 + 1
    f.h = max.h / 2 + 1

    log:i(max.x)
    win:setFrame(f)
    else
      hs.alert.show("No active window")
    end
end)
hs.hotkey.bind({"cmd", "alt"}, "n", function()
  if hs.window.focusedWindow() then
    local log = hs.logger.new('mymodule','debug')
    log.i(hs.screen.primaryScreen():frame())
    log.i(hs.screen.allScreens()[3])
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y + (max.h / 2) + 1
    f.w = max.w / 2 + 1
    f.h = max.h / 2 + 1

    log:i(max.x)
    win:setFrame(f)
    else
      hs.alert.show("No active window")
    end
end)
hs.hotkey.bind({"cmd", "alt"}, "i", function()
  if hs.window.focusedWindow() then
    local log = hs.logger.new('mymodule','debug')
    log.i(hs.screen.primaryScreen():frame())
    log.i(hs.screen.allScreens()[3])
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h

    log:i(max.x)
    win:setFrame(f)
    else
      hs.alert.show("No active window")
    end
end)
