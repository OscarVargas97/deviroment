#!/bin/bash

if [[ -n $BASH_PROGRAM_INSTALLED ]]; then
    (
      source $PROJECT_DIR/modules/utils.sh
      log_error "Ya tienes instalado un programa basado en devironment"
      log_info "Si desea instalar un nuevo programa basado en deviroment
                                    elimine la carga en su bashrc o zshrc o bien abra una 
                                    nueva consola"
    )
    return 1 2>/dev/null
fi
BASH_PROGRAM_INSTALLED=true


PROJECT_DIR=/usr/share/deviroment/commands
PROJECT_ROOT=$(dirname "$PROJECT_DIR")
GITHUB_FOLDER_COMPANY=$HOME/HOStudios

hos() {
  if [ "$1" = "home" ]; then
    cd "$GITHUB_FOLDER_COMPANY"
    return 0
  elif [ "$1" = "cd" ]; then
    cd $(   
          source $PROJECT_DIR/src/programs.sh
          local programpath
          programpath=$(get_program_path $2)
          if [ "$programpath" = "error" ]; then
            echo "Argumento no reconocido. Por favor usa $alias_programs."
            exit 1
          fi
          code "$programpath"
        )
    return 0
  fi

  (
    source $PROJECT_DIR/modules/index.sh
    source $PROJECT_DIR/src/index.sh
    PIndex "$@"
  )
}