#!/bin/bash

  compattach(){
    local programcontainer
    programcontainer=$(get_program_dev_container "$2")
    if [ "$programcontainer" = "error" ]; then
      echo "Argumento no reconocido. Por favor usa $alias_programs."
      exit 1
    fi
    local CONTAINER_NAME="$2"_"$programcontainer"
    docker exec -it $CONTAINER_NAME zsh
  }