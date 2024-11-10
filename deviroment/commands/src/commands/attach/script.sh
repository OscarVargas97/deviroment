#!/bin/bash

  compattach(){
    local programcontainer
    programcontainer=$(get_program_dev_container "$2")
    if [ "$programcontainer" = "error" ]; then
      error_programs_msg
      exit 1
    fi
    docker exec -it $programcontainer zsh
  }