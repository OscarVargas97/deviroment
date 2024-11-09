#!/bin/bash
comprcode() {
    local programcontainer
    programcontainer=$(get_program_dev_container "$2")
    if [ "$programcontainer" = "error" ]; then
      log_warning "Su programa no es un programa valido, 
                                           Programas validos: $alias_programs."
      exit 1
    fi
    if [ -z "$programcontainer" ]; then
      log_warning "El programa no posee dev-container o no está configurado en deviroment."
      log_warning "Revise si hay actualizaciones pendientes en deviroment o consulte en la documentación."
      log_warning "En caso de no encontrarlo y ser necesario, solicite la implementación de un contenedor de desarrollo."
      exit 1
    fi
    if ! docker ps -a --format '{{.Names}}' | grep -q "^${programcontainer}$"; then
      compcompose "none" "$2" up -d
    fi
    code --folder-uri vscode-remote://attached-container+$(printf "$programcontainer" | xxd -p)/app
}