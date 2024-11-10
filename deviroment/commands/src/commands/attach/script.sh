#!/bin/bash

  compattach(){
    local programcontainer
    programcontainer=$(get_program_dev_container "$2")
    if [ "$programcontainer" = "error" ]; then
      echo "Argumento no reconocido. Por favor usa $alias_programs."
      exit 1
    fi
    docker exec -it $programcontainer zsh
  }