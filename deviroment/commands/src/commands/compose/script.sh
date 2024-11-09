#!/bin/bash
hoscompose() {
    local actualpath="$PWD"
    local programpath
    programpath=$(get_program_path "$2")
    if [ "$programpath" = "error" ]; then
      echo "Argumento no reconocido. Por favor usa $validprograms."
      exit 1
    fi
    cd "$programpath"
    docker compose "${@:3}"
    cd "$actualpath"
}