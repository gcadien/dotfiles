function top_line --on-event fish_preexec --no-scope-shadowing
  for i in (seq 1 $COLUMNS)
    printf '\u2500'
  end
  printf '\n'
  set argv "ls -l"
  printf $argv
  #set output (argv)
end

function bottom_line --on-event fish_postexec
  for i in (seq 1 $COLUMNS)
    printf '\u2500'
  end
  printf '\n'
end


