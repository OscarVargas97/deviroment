#!/bin/bash

if [[ -n $BASH_PROGRAM_INSTALLED ]]; then
    echo "Ya tienes instalado un programa de bash basado en rflexsh \nSi deseas instalar otro programa de bash basado en rflexsh, abra una nueva consola"
    return 1 2>/dev/null
fi
BASH_PROGRAM_INSTALLED=true

PROJECT_DIR=$(cd "$(dirname "$0")"; pwd)
PROJECT_ROOT=$(dirname "$PROJECT_DIR")

hos() {
  (
    source $PROJECT_DIR/modules/index.sh
    source $PROJECT_DIR/src/index.sh
    HOSIndex "$@"
  )
}