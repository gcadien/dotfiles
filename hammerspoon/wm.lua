require "hs.application"
require "hs.window.filter"

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



hs.hotkey.bind({"cmd", "alt"}, "1", function() 
  hs.alert("Moving to space 1")
  moveCurrentWindowToSpace(1)
end)

hs.hotkey.bind({"cmd", "alt"}, "2", function() moveCurrentWindowToSpace(2) end)
hs.hotkey.bind({"cmd", "alt"}, "6", function() moveCurrentWindowToSpace(6) end)
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
