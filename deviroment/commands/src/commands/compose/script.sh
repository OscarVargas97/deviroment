#!/bin/bash
compcompose() {
    local actualpath="$PWD"
    local programpath
    programpath=$(get_program_path "$2")
    if [ "$programpath" = "error" ]; then
      echo "Argumento no reconocido. Por favor usa $alias_programs."
      exit 1
    fi
    cd "$programpath"
    docker compose "${@:3}"
    cd "$actualpath"
}