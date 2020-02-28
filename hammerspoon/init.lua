require "hs.application"
require "hs.window.filter"
require "key-mapping"
require "bitwarden"

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

hs.hotkey.bind({"cmd", "shift"}, "l", bitwarden)
--function bwLoggedIn() 
--  logger.i("Checking bw login state")
--  stdout, status,typ,rc = hs.execute("/usr/local/bin/bw login --check", true)
--  logger.i(stdout)
--  logger.i(rc)
--  return rc == 0
--end
--
--local bwSesseionId = ""
--local itemId = "4ea387e5-a1f8-40e2-aa28-ab5201271dfe"
--hs.hotkey.bind({"cmd", "shift"}, "l", function()
--  if not bwLoggedIn() then
--    hs.focus()
--    button, text = hs.dialog.textPrompt("Bitwarden Login.", "Please enter master password:", "", "OK", "Cancel", true)
--    logger.i("Button: " .. button)
--    if button == "OK" then
--      logger.i("Logging into Bitwarden")
--      stdout, status,typ,rc  = hs.execute("/usr/local/bin/bw login gcadien@gmail.com " .. text .. " --raw", true)
--      if rc == 0 then
--        bwSesseionId = stdout
--        logger.i(bwSesseionId)
--      end
--      logger.i(rc)
--    end
--  end
--  logger.i("/usr/local/bin/bw get password " .. itemId .. " --session " .. "'" .. bwSesseionId .. "'", true)
--  stdout, status,typ,rc = hs.execute("~/bin/bw-password " .. itemId .. " " .. bwSesseionId, true)
--  --stdout, status,typ,rc = hs.execute("/usr/local/bin/bw get password " .. itemId .. " --session " .. "'" .. bwSesseionId .. "'")
--  --stdout, status,typ,rc  = hs.execute("/usr/local/bin/bw get password 4ea387e5-a1f8-40e2-aa28-ab5201271dfe --session '7I+kvPVI1aPfHniPY4xNL7pvgiUxNN8mbT7qvG+z99xgslJAt7IQUyEQBfZNndUn+h7zEPj47hK4zSnD5744nw=='")
--  --stdout, status,typ,rc = hs.execute("/usr/local/bin/bw get password " .. itemId .. " --session " .. bwSesseionId, true)
--  logger.i("Password Retrieved")
--  if (rc == 0) then
--    hs.pasteboard.writeObjects(stdout)
--    hs.alert("Password copied.")
--  else
--    hs.alert("Error retrieving password.")
--  end
--  logger.i(rc)
--
--end)

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

hs.urlevent.bind("idpException", function(eventName, params) 
  hs.notify.new({title="Phoenix Alert", informativeText=string.format("IDP Exception - %s", params["region"])}):send()
end)


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

local wf = hs.window.filter
wf_iterm = wf.new{'iTerm2'}
hs.alert(wf_iterm)
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

