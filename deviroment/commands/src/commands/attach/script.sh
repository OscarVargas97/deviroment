#!/bin/bash

  hosattach(){
    local programcontainer
    programcontainer=$(get_program_dev_container "$2")
    if [ "$programcontainer" = "error" ]; then
      echo "Argumento no reconocido. Por favor usa $validprograms."
      exit 1
    fi
    local CONTAINER_NAME="$2"_"$programcontainer"
    docker exec -it $CONTAINER_NAME zsh
  }