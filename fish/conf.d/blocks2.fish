#function post --on-event fish_postexec
#  set last_cmd (kitty @get-text --ansi --extent last_cmd_output  --self | string split0)
#  echo $last_cmd
#end
