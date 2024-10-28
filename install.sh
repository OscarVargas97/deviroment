#!/bin/bash

PATH=/usr/share/
DEVFOLDER=deviroment
DEVPATH=/usr/share/deviroment
HOSPATH="$HOME/HOStudios"
HOSNAME="HOStudios"
PROYECTOS=("ethereal-realms-back" "ethereal-realms-frontend" "gp-back" "gp-front")

main(){
    echo "¿Deseas instalar o desinstalar? (i/un)"
    read -r respuesta

    if [[ "$respuesta" == "i" ]]; then
        echo "Iniciando instalación..."
        
        #verificar si docker, docker compose y git estan instalados
        install_docker
        install_docker_compose
        install_git
        #Si no estan instalados advertir que el programa es necesario y se van a intalar.
        #Confirmar si el usuario desea continuar
        install_deviroment
        install_alias
        crear_carpeta_hostudios
        descargar_proyectos_hostudios
        
    fi

    elif [[ "$respuesta" == "un" ]]; then
        echo "Iniciando desinstalación..."
        #Advertir que no se desinstalaran ni git, ni docker, ni docker-compose
        #Advertir que no se va a eliminar la carpeta de proyectos.
        uninstall_deviroment
        uninstall_source
    fi
}



install_docker(){
}

install_docker_compose(){
}

install_git(){ 
}

install_deviroment() {
    if [ -d "$DEVPATH" ]; then
        read -p "El directorio $DEVPATH ya existe. ¿Deseas reemplazarlo? (s/n): " choice
        if [[ "$choice" == "s" || "$choice" == "S" ]]; then
            sudo rm -rf "$DEVPATH"
            echo "Directorio eliminado."
        else
            echo "Instalación cancelada."
            exit 1
        fi
    fi
    echo "Copiando el entorno..."
    sudo cp -r "$DEVFOLDER" "$PATH"
    install_alias
}

uninstall_deviroment() {
    if [ -d "$DEVPATH" ]; then
        sudo rm -rf "$DEVPATH"
        echo "Directorio $DEVPATH eliminado."
    else
        echo "El entorno no existe."
    fi
    uninstall_alias
}

install_alias() {
    # Variables
    COMMANDS_FILE="/usr/share/deviroment/commands/commands.sh"
    SOURCE_COMMAND="source $COMMANDS_FILE"

    # Verificar y agregar el source en .bashrc
    if [ -f "$HOME/.bashrc" ]; then
        if ! grep -Fxq "$SOURCE_COMMAND" "$HOME/.bashrc"; then
            echo "Agregando source de comandos en $HOME/.bashrc..."
            echo "$SOURCE_COMMAND" >>"$HOME/.bashrc"
        fi
    fi

    # Verificar y agregar el source en .zshrc
    if [ -f "$HOME/.zshrc" ]; then
        if ! grep -Fxq "$SOURCE_COMMAND" "$HOME/.zshrc"; then
            echo "Agregando source de comandos en $HOME/.zshrc..."
            echo "$SOURCE_COMMAND" >>"$HOME/.zshrc"
        fi
    fi

    # Recargar configuración de shell
    source "$HOME/.bashrc" 2>/dev/null || true
    source "$HOME/.zshrc" 2>/dev/null || true
}

uninstall_source() {
    # Eliminar el source de .bashrc si existe
    if [ -f "$HOME/.bashrc" ]; then
        sed -i "\|$SOURCE_COMMAND|d" "$HOME/.bashrc"
        echo "Comando source eliminado de $HOME/.bashrc."
    fi

    # Eliminar el source de .zshrc si existe
    if [ -f "$HOME/.zshrc" ]; then
        sed -i "\|$SOURCE_COMMAND|d" "$HOME/.zshrc"
        echo "Comando source eliminado de $HOME/.zshrc."
    fi
}

crear_carpeta_hostudios(){
    if [ -d "$HOSPATH" ]; then
        echo "La carpeta ya existe"
        exit 1
    else
        mkdir "$HOSPATH"
    fi
}

descargar_proyectos_hostudios(){
    for proyecto in "${PROYECTOS[@]}"; do
        if [ -f "$HOSPATH/$proyecto" ]; then
            echo "Ya existe la carpeta del proyecto $proyecto"
        else
            (
                cd "$HOSPATH"
                git clone "git@github.com:HappyOtterStudios/$proyecto.git" || echo "No se pudo clonar $proyecto. Verifica si tienes permisos."
            )
        fi
    done
}

main