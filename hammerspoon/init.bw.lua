local logger = hs.logger.new('hammerspoon','debug')
function bwLoggedIn()
  logger.i("Checking bw login state")
  stdout, status,typ,rc = hs.execute("/usr/local/bin/bw login --check", true)
  logger.i(stdout)
  logger.i(rc)
  return rc == 0
end

local bwSesseionId = ""
local itemId = "4ea387e5-a1f8-40e2-aa28-ab5201271dfe"
hs.hotkey.bind({"cmd", "shift"}, "l", function()
  if not bwLoggedIn() then
    hs.focus()
    button, text = hs.dialog.textPrompt("Bitwarden Login.", "Please enter master password:", "", "OK", "Cancel", true)
    logger.i("Button: " .. button)
    if button == "OK" then
      logger.i("Logging into Bitwarden")
      stdout, status,typ,rc  = hs.execute("/usr/local/bin/bw login gcadien@gmail.com " .. text .. " --raw", true)
      if rc == 0 then
        bwSesseionId = stdout
        logger.i(bwSesseionId)
      end
      logger.i(rc)
    end
  end
  -- TODO figure out why calling bw directly doesn't work.
  -- There seemed to be an issue when passing the sessionId to bw using hs.execute so I added
  -- a simple shell script that seems to work.
  stdout, status,typ,rc = hs.execute("~/bin/bw-password " .. itemId .. " " .. bwSesseionId, true)
  logger.i("Password Retrieved")
  if (rc == 0) then
    hs.pasteboard.writeObjects(stdout)
    hs.alert("Password copied.")
  else
    hs.alert("Error retrieving password.")
  end
  logger.i(rc)

end)
