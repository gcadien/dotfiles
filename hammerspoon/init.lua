require "hs.application"
--require "hs.window.filter"
require "key-mapping"
require "bitwarden"
require "wm"
require "hs.spaces"
--spaces = require("hs._asm.undocumented.spaces")
hs.window.animationDuration = 0

Container = {
  orientation = "horizontal",
  left = nil,
  right = nil
}

--
-- Code related to spaces
--

local logger = hs.logger.new('hammerspoon','debug')
logger.i("Hello, world")
logger.i(hs.spaces.allSpaces())
hs.spaces.gotoSpace(12)
hs.hotkey.bind({"cmd", "shift"}, "l", bitwarden)

-- This allows switching hdmi inputs.  Mac is on HDMI2
-- so this switches to HDMI1
hs.hotkey.bind({"ctrl", "cmd"}, "m", function()
  hs.execute("/usr/local/bin/ddcctl -d 1 -i 17")
end)

hs.hotkey.bind({"cmd", "alt"}, "v", function()
  hs.caffeinate.set("displayIdle", true, true)
  hs.caffeinate.set("systemIdle", true, true)
  hs.caffeinate.set("system", true, true)
  hs.alert.show("Preventing Sleep")
end)
hs.hotkey.bind({"cmd", "alt"}, "c", function()
  hs.caffeinate.set("displayIdle", false, true)
  hs.caffeinate.set("systemIdle", false, true)
  hs.caffeinate.set("system", false, true)
  hs.alert.show("Allowing Sleep")
end)

hs.hotkey.bind({}, "F12", function()
  local app = hs.application.get("kitty")

  if app then
    if not app:mainWindow() then
      hs.alert.show("Not Main window") 
    else
      hs.alert.show("main kitty window")
      local win = app:findWindow("Notes")
      logger.i(#(app:allWindows()))
      for _,w in ipairs(app:allWindows()) do
        logger.i(w)
      end 
      if win then
        logger.i("Found Notes window")
      else
        logger.i("Could not find Notes window.  Opening.")
        --logger.i(app:selectMenuItem({"Shell", "New OS Window"}))
        --logger.i(app:focusedWindow().id)
        --local stdout, status, typ, rc = hs.execute("/usr/local/bin/kitty @ set-window-title --match state:focused Notes", true)
        os.execute("/Applications/kitty.app/Contents/MacOS/kitty --title Notes nvim &", true)
        --os.execute("/usr/local/bin/kitty --title Notes &", true)
        logger.i("Done!!")
      end
    end
  end
  --        app:selectMenuItem({"kitty", "New OS window"})
  --    elseif app:isFrontmost() then
  --        app:hide()
  --    else
  --        app:activate()
  --    end
  --else
  --    hs.application.launchOrFocus("kitty")
  --    app = hs.application.get("kitty")
  --end

  --app:mainWindow():moveToUnit'[100,50,0,0]'
  --app:mainWindow().setShadows(false)
end)
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
--function moveWindowToSpace(win, space)
--    local uuid = win:screen():spacesUUID()     -- uuid for current screen
--    logger.i("UUID: " .. uuid)
--    logger.i("Number of Spaces: " .. #spaces.layout()[uuid])
--    local spaceID = spaces.layout()[uuid][7]  -- internal index for sp
----    local spaceID = spaces.layout()[uuid]  -- internal index for sp
--    logger.i(spaceID)
--    spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
--end



--
-- Scratchpad Code
--

--local notesFilter = hs.window.filter.new(function(w) 
--  logger.i(w:title() .. " " .. #w:application():allWindows())
--  return w:title() == 'Notes'
--end)
----local notesFilter = hs.window.filter.default:setAppFilter('MacVim', {allowTitles='Notes'})
--logger.i("Notes Window " .. #notesFilter:getWindows())
----logger.i(notesFilter:getWindows()[1]:title())
--logger.i(notesFilter:getWindows()[1])
--logger.i("ScratchPad")
--moveWindowToSpace(notesFilter:getWindows()[1], 2)

local modal = hs.hotkey.modal.new({"ctrl"}, "space")
modal:bind("", "escape", nil, function() modal:exit() end)

function modal:entered() 
--  hs.alert("Entered Normal Mode")
end

function modal:exited() 
 -- hs.alert("Exited Normal Mode")
end


--hs.hotkey.bind({"cmd", "alt"}, "right", function() 
--  if hs.window:focusedWindow() then
--    logger.i(hs.window:focusedWindow())
--    hs.window:focusedWindow():focusWindowEast()
--  end
--end)

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

--hs.urlevent.bind("idpException", function(eventName, params) 
--  hs.notify.new({title="Phoenix Alert", informativeText=string.format("IDP Exception - %s", params["region"])}):send()
--end)
--
--
--hs.hotkey.bind({"cmd", "alt"}, "1", function() 
--  hs.alert("Moving to space 1")
--  moveCurrentWindowToSpace(1)
--end)
--
--hs.hotkey.bind({"cmd", "alt"}, "2", function() moveCurrentWindowToSpace(2) end)
--hs.hotkey.bind({"cmd", "alt"}, "6", function() moveCurrentWindowToSpace(6) end)
--hs.hotkey.bind({"cmd", "alt"}, "right", focus("east"))
--hs.hotkey.bind({"cmd", "alt"}, "left", focus("west"))
--hs.hotkey.bind({"cmd", "alt"}, "up", focus("north"))
--hs.hotkey.bind({"cmd", "alt"}, "down", focus("south"))
--hs.hotkey.bind({"cmd", "alt"}, "h", function()
--  if hs.window.focusedWindow() then
--    local win = hs.window.focusedWindow()
--    local f = win:frame()
--    local screen = win:screen()
--    local max = screen:frame()
--
--    f.x = max.x
--    f.y = max.y
--    f.w = max.w / 2 - 1
--    f.h = max.h
--    win:setFrame(f)
--    else
--      hs.alert.show("No active window")
--    end
--  end)
--
--hs.hotkey.bind({"cmd", "alt"}, "l", function()
--  if hs.window.focusedWindow() then
--    local log = hs.logger.new('mymodule','debug')
--    log.i(hs.screen.primaryScreen():frame())
--    log.i(hs.screen.allScreens()[3])
--    local win = hs.window.focusedWindow()
--    local f = win:frame()
--    local screen = win:screen()
--    local max = screen:frame()
--    f.x = max.x + (max.w / 2) + 1
--    f.y = max.y
--    f.w = max.w / 2 + 1
--    f.h = max.h
--
--    log:i(max.x)
--    win:setFrame(f)
--    else
--      hs.alert.show("No active window")
--    end
--  end)
--
--hs.hotkey.bind({"cmd", "alt"}, "u", function()
--  if hs.window.focusedWindow() then
--    local log = hs.logger.new('mymodule','debug')
--    log.i(hs.screen.primaryScreen():frame())
--    log.i(hs.screen.allScreens()[3])
--    local win = hs.window.focusedWindow()
--    local f = win:frame()
--    local screen = win:screen()
--    local max = screen:frame()
--    f.x = max.x
--    f.y = max.y
--    f.w = max.w / 2 + 1
--    f.h = max.h / 2 + 1
--
--    log:i(max.x)
--    win:setFrame(f)
--    else
--      hs.alert.show("No active window")
--    end
--end)
--
--hs.hotkey.bind({"cmd", "alt"}, "o", function()
--  if hs.window.focusedWindow() then
--    local log = hs.logger.new('mymodule','debug')
--    log.i(hs.screen.primaryScreen():frame())
--    log.i(hs.screen.allScreens()[3])
--    local win = hs.window.focusedWindow()
--    local f = win:frame()
--    local screen = win:screen()
--    local max = screen:frame()
--    f.x = max.x + (max.w /2) + 1
--    f.y = max.y
--    f.w = max.w / 2 + 1
--    f.h = max.h / 2 + 1
--
--    log:i(max.x)
--    win:setFrame(f)
--    else
--      hs.alert.show("No active window")
--    end
--end)
--
--hs.hotkey.bind({"cmd", "alt"}, ".", function()
--  if hs.window.focusedWindow() then
--    local log = hs.logger.new('mymodule','debug')
--    log.i(hs.screen.primaryScreen():frame())
--    log.i(hs.screen.allScreens()[3])
--    local win = hs.window.focusedWindow()
--    local f = win:frame()
--    local screen = win:screen()
--    local max = screen:frame()
--    f.x = max.x + (max.w /2) + 1
--    f.y = max.y + (max.h / 2) + 1
--    f.w = max.w / 2 + 1
--    f.h = max.h / 2 + 1
--
--    log:i(max.x)
--    win:setFrame(f)
--    else
--      hs.alert.show("No active window")
--    end
--end)
--hs.hotkey.bind({"cmd", "alt"}, "n", function()
--  if hs.window.focusedWindow() then
--    local log = hs.logger.new('mymodule','debug')
--    log.i(hs.screen.primaryScreen():frame())
--    log.i(hs.screen.allScreens()[3])
--    local win = hs.window.focusedWindow()
--    local f = win:frame()
--    local screen = win:screen()
--    local max = screen:frame()
--    f.x = max.x
--    f.y = max.y + (max.h / 2) + 1
--    f.w = max.w / 2 + 1
--    f.h = max.h / 2 + 1
--
--    log:i(max.x)
--    win:setFrame(f)
--    else
--      hs.alert.show("No active window")
--    end
--end)
--hs.hotkey.bind({"cmd", "alt"}, "i", function()
--  if hs.window.focusedWindow() then
--    local log = hs.logger.new('mymodule','debug')
--    log.i(hs.screen.primaryScreen():frame())
--    log.i(hs.screen.allScreens()[3])
--    local win = hs.window.focusedWindow()
--    local f = win:frame()
--    local screen = win:screen()
--    local max = screen:frame()
--    f.x = max.x
--    f.y = max.y
--    f.w = max.w
--    f.h = max.h
--
--    log:i(max.x)
--    win:setFrame(f)
--    else
--      hs.alert.show("No active window")
--    end
--end)

--hs.hotkey.bind({"ctrl", "alt"}, 'h', function()
--  local win = hs.window.focusedWindow()
--  logger.i(win)
--  win:focusWindowWest()
--end)

-- Hints
hs.hotkey.bind({"ctrl", "alt"}, 'h', function() 
  --hs.hints.windowHints(hs.window.allWindows()) 
  hs.grid.show()
end)

function reload_config(files)
  hs.reload()
end

--log = hs.logger.new('spaces', 'debug')
--log.i(spaces.debug.layout())
--spaces.changeToSpace("A9BB4B9E-EEC5-4C2E-B34E-6F261A528D70")
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.launched) then
    hs.alert.show(appName)
  end
end

--local wf = hs.window.filter
--wf_iterm = wf.new{'iTerm2'}
--hs.alert(wf_iterm)
--wf_iterm:subscribe(wf.windowCreated, function() hs.alert("Created") end)


--local contextMenuMode = hs.hotkey.modal.new()
--local contextMenuModeActive = false
--tap = hs.eventtap.new({hs.eventtap.event.types.rightMouseUp}, function(evt) 
--  if contextMenuModeActive then
--    contextMenuMode:exit()
--    contextMenuModeActive = false;
--    hs.alert("Leaving Context Menu Mode")
--  else
--    contextMenuMode:enter()
--    contextMenuModeActive = true;
--    hs.alert("Entering Context Menu Mode")
--  end
--end)

--enterTap = hs.eventtap.new({hs.eventtap.event.types.keyUp}, function(evt) 
--   --hs.alert(evt:getKeyCode())
--  if evt:getKeyCode() == 36 or evt:getKeyCode() == 53 then
--    contextMenuMode:exit()
--    contextMenuModeActive = false;
----  hs.alert("Return")
--  end 
--end)
--enterTap:start()

--control_key_handler = function(evt) 
--  logger.i(hs.inspect(evt:getFlags()))
--  logger.i(evt:getKeyCode())
--  local flags = evt:getFlags()
--  local keyCode = evt:getKeyCode()
--  if flags.cmd and keyCode == 54 and not (flags.alt or flags.shift or flags.ctrl or flags.fn) then
--    logger.i("Right Command Key")
--    right_click()
--  end
--end
--
--control_key_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, control_key_handler)
--control_key_tap:start()
--function down() hs.eventtap.keyStroke({}, "Down") end
--function up() hs.eventtap.keyStroke({}, "Up") end
--function right() hs.eventtap.keyStroke({}, "Right") end
--function left() hs.eventtap.keyStroke({}, "Left") end
--function right_click() hs.eventtap.rightClick(hs.mouse.getAbsolutePosition()) end

--contextMenuMode:bind({}, 'j', down, nil, down)
--contextMenuMode:bind({}, 'k', up, nil, up)
--contextMenuMode:bind({}, 'l', right, nil, up)
--contextMenuMode:bind({}, 'h', left, nil, up)
--tap:start()

hs.window.animationDuration = 0
hs.window.setShadows(true)
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

