#!/bin/bash
compcd() {
  local programpath
  programpath=$(get_program_path $2)
  if [ "$programpath" = "error" ]; then
    error_programs_msg
    exit 1
  fi
  cd "$programpath"
}