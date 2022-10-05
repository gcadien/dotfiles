local logger = hs.logger.new('hammerspoon', 'debug')
local bwSessionId
local bwLoginItems
-- check if logged in
function bwLoggedIn()
  logger.i("Checking bw login state")
  local stdout, status, typ, rc = hs.execute("/usr/local/bin/bw login --check", true)
  logger.i(stdout)
  return status
end

-- prompt for master password
function passwordPrompt()
  local button, password = hs.dialog.textPrompt("Bitwarden Login.", "Please enter master password:", "", "OK", "Cancel", true)
  logger.i("Button: " .. button)
  if not button == "OK" then
    focusLastFocused(); return
  end
  return password
end

 -- prompt for mfa code
function mfaCodePrompt()
  local button, mfaCode = hs.dialog.textPrompt("Bitwarden Login.", "Please enter MFA Code:", "", "OK", "Cancel", true)
  if not button == "OK" then
    focusLastFocused(); return
  end
  return mfaCode
end

-- perform bw login, prompting for password and mfa code
-- sets bwSessionId
function bwLogin()
  hs.focus()
  local password = passwordPrompt()
  --local mfaCode = mfaCodePrompt()
  logger.i("Logging into Bitwarden")
  local sessionId, status, typ, rc = hs.execute("/usr/local/bin/bw login marty.christiansen@gmail.com " .. password .. " --code " .. " --raw", true)
  if status then
    bwSessionId = sessionId
    logger.i("Set bwSessionId: " .. bwSessionId)
  else
    hs.alert("Login failed: " .. rc .. " output: " .. sessionId)
    focusLastFocused(); return
  end
end

-- perform bw unlock, prompting for password
-- sets bwSessionId
function bwLoadSession()
  hs.focus()
  local password = passwordPrompt()
  logger.i("Logging into Bitwarden")
  local sessionId, status, typ, rc = hs.execute("/usr/local/bin/bw unlock " .. password .. " --raw", true)
  if status then
    bwSessionId = sessionId
    logger.i("Set bwSessionId: " .. bwSessionId)
  else
    hs.alert("Login failed: " .. rc .. " output: " .. sessionId)
    focusLastFocused(); return
  end
end

-- focus the last focused window
function focusLastFocused()
  local wf = hs.window.filter
  local lastFocused = wf.defaultCurrentSpace:getWindows(wf.sortByFocusedLast)
  if #lastFocused > 0 then lastFocused[1]:focus() end
end

-- load the login items into global variable
-- sets bwLoginItems
function bwLoadLoginItems()
  local choices = {}
  local json, status, typ, rc = hs.execute("/usr/local/bin/bw list items --session " .. bwSessionId, true)
  if not status then
    logger.e(json)
    hs.alert("Error retrieving items: " .. rc)
    focusLastFocused(); return
  end
  for _, login in ipairs(hs.json.decode(json)) do
    table.insert(choices,
      {
        text = login['name'],
        itemId = login['id']
      })
  end
  bwLoginItems = choices
end
function bitwarden()
  if not bwLoggedIn() then
    bwLogin()
  elseif bwSessionId == nil then
    bwLoadSession()
  end
  if bwLoginItems == nil then
    bwLoadLoginItems()
  end
  -- TODO: detect invalid bwSessionId?
  local chooser = hs.chooser.new(function(choice)
    if not choice then focusLastFocused(); return end
    logger.i(choice["itemId"])
      local password, status, typ, rc = hs.execute("/usr/local/bin/bw get password " .. choice["itemId"] .. " --session " .. bwSessionId, true)
      logger.i("Password Retrieved")
      if (rc == 0) then
        hs.pasteboard.writeObjects(password)
        hs.alert("Password copied")
      else
        hs.alert("Error retrieving password: " .. rc)
      end
  end)
  chooser:searchSubText(true)
  chooser:choices(bwLoginItems)
  chooser:show()
end

