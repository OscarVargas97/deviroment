#!/bin/bash
compcode() {
  local programpath
  programpath=$(get_program_path "$2")
  if [ "$programpath" = "error" ]; then
    echo "Argumento no reconocido. Por favor usa $alias_programs."
    exit 1
  fi
  code "$programpath"
}