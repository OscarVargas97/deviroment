#!/bin/bash

if [[ -n $BASH_PROGRAM_INSTALLED ]]; then
    echo "Ya tienes instalado un programa de bash basado en hos \nSi deseas instalar otro programa de bash basado en hos, abra una nueva consola"
    return 1 2>/dev/null
fi
BASH_PROGRAM_INSTALLED=true


PROJECT_DIR=$(cd "$(dirname "$0")"; pwd)
PROJECT_ROOT=$(dirname "$PROJECT_DIR")
GITHUB_FOLDER_COMPANY=$HOME/HOStudios

hos() {
  if [ "$1" = "home" ]; then
    cd "$GITHUB_FOLDER_COMPANY"
    return 0
  fi
  (
    source $PROJECT_DIR/modules/index.sh
    source $PROJECT_DIR/src/index.sh
    HOSIndex "$@"
  )
}