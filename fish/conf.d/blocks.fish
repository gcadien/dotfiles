function top_line --on-event fish_preexec --no-scope-shadowing
  #  for i in (seq 1 $COLUMNS)
  #    printf '\u2500'
  #  end
  #  printf '\n'
  #  #set output (argv)
end

function bottom_line --on-event fish_postexec
  set -f last_cmd (kitty @get-text --extent last_cmd_output  --self | string split0)
  set -f json (jq -n --arg cmd "$argv" --arg output "$last_cmd" '{command: $cmd, output: $output}')
  # set -U --append BLOCKS "$json"
  for i in (seq 1 $COLUMNS)
    printf '\u2500'
  end
  printf '\n'
end


