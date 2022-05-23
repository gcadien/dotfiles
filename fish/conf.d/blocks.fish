function bottom_line --on-event fish_postexec
  for i in (seq 1 $COLUMNS)
    printf '\u2500'
  end
  printf '\n'
end


