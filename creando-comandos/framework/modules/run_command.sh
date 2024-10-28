#!/bin/bash
check_command_exists() {
  if [[ -v "COMMANDS[$1]" ]]; then
    return 0
  else
    return 1
  fi
}

parse_args() {
  comm_iterate=1
  for arg in "$@"; do
    if check_command_exists "$arg" "$comm_iterate"; then  
      return 0
    fi
    comm_iterate=$((comm_iterate + 1))
  done
  comm_iterate=0
  run_show_help
}

eval_and_run_command(){
  if [ "$comm_iterate" -gt 0 ]; then
    local index=$(eval echo \${$comm_iterate})
    ${COMMANDS[$index]} "${@}"
  else
    echo 'Command not found'
  fi
}