#!/bin/bash
hosrcode() {
    local programcontainer
    programcontainer=$(get_program_dev_container "$2")
    if [ "$programcontainer" = "error" ]; then
      echo "Argumento no reconocido. Por favor usa $validprograms."
      exit 1
    fi
    if [ -z "$programcontainer" ]; then
      echo "El programa no posee dev-container o no está configurado en deviroment."
      echo "Revise si hay actualizaciones pendientes en deviroment o consulte en la documentación."
      echo "En caso de no encontrarlo y ser necesario, solicite la implementación de un contenedor de desarrollo."
      exit 1
    fi
    local CONTAINER_NAME="$2"_"$programcontainer"
    if ! docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
      hoscompose "none" "$2" up -d
    fi
    code --folder-uri vscode-remote://attached-container+$(printf "$CONTAINER_NAME" | xxd -p)/app
}