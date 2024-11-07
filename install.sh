#!/bin/bash

PATHP=/usr/share/
DEVFOLDER=deviroment
DEVPATH=/usr/share/deviroment
HOSPATH="$HOME/HOStudios"
HOSNAME="HOStudios"
PROYECTOS=("ethereal-realms-back" "ethereal-realms-frontend" "gp-back" "gp-front")

main(){
    obtener_distribucion
    echo "¿Deseas instalar o desinstalar? (i/un)"
    read -r respuesta

    if [[ "$respuesta" == "i" ]]; then
        echo "Iniciando instalación..."
        install_docker
        install_docker_compose
        install_git
        install_deviroment
        install_alias
        crear_carpeta_hostudios
        descargar_proyectos_hostudios
    elif [[ "$respuesta" == "un" ]]; then
        echo "Iniciando desinstalación..."
        #Advertir que no se desinstalaran ni git, ni docker, ni docker-compose
        #Advertir que no se va a eliminar la carpeta de proyectos.
        uninstall_deviroment
        uninstall_source
    fi
}

obtener_distribucion(){
    OS_ID=$(grep ^ID= /etc/os-release | cut -d'=' -f2 | tr -d '"')
}

install_docker_fedora(){
    echo "Instalando Docker en Fedora..."
    # Aquí agregarías los comandos específicos para instalar Docker en Fedora
    sudo dnf install -y dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
}

install_docker_ubuntu(){
    echo "Instalando Docker en Ubuntu..."
    # Aquí agregarías los comandos específicos para instalar Docker en Ubuntu
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
}

install_docker(){
    if ! command -v docker &> /dev/null; then
        echo "Docker no está instalado. Instalando Docker..."
        "install_docker_$OS_ID"
        echo "Docker ha sido instalado correctamente."
    else
        echo "Docker ya está instalado."
    fi
}

install_docker_compose_fedora(){
    sudo dnf update -y
    sudo dnf install -y docker-compose
    # Verificar instalación
    docker-compose --version && echo "Docker Compose instalado correctamente en Fedora."
}

install_docker_compose_ubuntu(){
    # Actualizar paquetes e instalar Docker Compose
    sudo apt update -y
    sudo apt install -y docker-compose
    # Verificar instalación
    docker-compose --version && echo "Docker Compose instalado correctamente en Ubuntu."
}

install_docker_compose(){
    if ! command -v docker-compose &> /dev/null; then
        echo "Docker Compose no está instalado. Instalando Docker..."
        "install_docker_compose_$OS_ID"
        echo "Docker Compose está instalado."
    else
        echo "Docker Compose y esta instalado"
    fi
}

install_git_fedora(){
    # Actualizar paquetes e instalar Git en Fedora
    sudo dnf update -y
    sudo dnf install -y git

    # Verificar instalación
    git --version && echo "Git instalado correctamente en Fedora."
}

install_git_ubuntu(){
    # Actualizar paquetes e instalar Git en Ubuntu
    sudo apt update -y
    sudo apt install -y git

    # Verificar instalación
    git --version && echo "Git instalado correctamente en Ubuntu."
}

install_git(){ 
    if ! command -v git &> /dev/null; then
        echo "Git no está instalado. Instalando Git..."
        "install_git_$OS_ID"
        echo "Git ha sido instalado correctamente."
    else
        echo "Git ya está instalado."
    fi
}

install_deviroment() {
    if [ -d "$DEVPATH" ]; then
        read -p "El directorio $DEVPATH ya existe. ¿Deseas reemplazarlo? (s/n): " choice
        if [[ "$choice" == "s" || "$choice" == "S" ]]; then
            sudo rm -rf "$DEVPATH"
            echo "Directorio eliminado."
            echo "Copiando el entorno..."
            sudo cp -r "$DEVFOLDER" "$PATHP"
            sudo chown -R $(whoami) $DEVPATH
        fi
    fi
    install_alias
}

uninstall_deviroment() {
    echo "¿Qué deseas eliminar?"
    echo "1) Solo los aliases"
    echo "2) Solo el entorno de desarrollo"
    echo "3) Ambos (aliases y entorno)"
    read -p "Elige una opción [1/2/3]: " choice

    case $choice in
        1)
            uninstall_alias
            echo "Aliases eliminados."
            ;;
        2)
            if [ -d "$DEVPATH" ]; then
                sudo rm -rf "$DEVPATH"
                echo "Directorio $DEVPATH eliminado."
            else
                echo "El entorno no existe."
            fi
            ;;
        3)
            if [ -d "$DEVPATH" ]; then
                sudo rm -rf "$DEVPATH"
                echo "Directorio $DEVPATH eliminado."
            else
                echo "El entorno no existe."
            fi
            uninstall_alias
            echo "Ambos, aliases y entorno, han sido eliminados."
            ;;
        *)
            echo "Opción no válida."
            ;;
    esac
}

install_alias() {
    # Variables
    COMMANDS_FILE="/usr/share/deviroment/commands/main.sh"
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