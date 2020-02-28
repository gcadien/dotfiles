ctrlPressed = false
keyPressed = false

control_key_handler = function(evt) 
  print(hs.inspect(evt:getFlags()))
  print(evt:getKeyCode())
  local flags = evt:getFlags()
  local keyCode = evt:getKeyCode()
  if flags.cmd and keyCode == 54 and not (flags.alt or flags.shift or flags.ctrl or flags.fn) then
    ctrlPressed = true
    keyPressed = false
  elseif ctrlPressed and not (flags.cmd or flags.alt or flags.shift or flags.ctrl or flags.fn) then
    if keyCode == 54 then
      right_click()
    end
  else
    keyPressed = true
  end
end

control_key_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, control_key_handler)
control_key_tap:start()
function down() hs.eventtap.keyStroke({}, "Down") end
function up() hs.eventtap.keyStroke({}, "Up") end
function right() hs.eventtap.keyStroke({}, "Right") end
function left() hs.eventtap.keyStroke({}, "Left") end
function right_click() hs.eventtap.rightClick(hs.mouse.getAbsolutePosition()) end

