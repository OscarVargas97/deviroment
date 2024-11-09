#!/bin/bash
hoscode() {
    local programpath
    programpath=$(get_program_path "$2")
    if [ "$programpath" = "error" ]; then
      echo "Argumento no reconocido. Por favor usa $validprograms."
      exit 1
    fi
    code "$programpath"
}