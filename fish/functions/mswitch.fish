function mswitch
  echo "Switching monitors"
  set name (uname)
  if test $name = Darwin
    ddcctl -d 1 -i 17
  else if test $name = Linux
    echo Add Linux ddc command
  end
end
