#!/bin/bash


## campos editables
COMPANY_NAME="HOStudios"
COMPANY_GIT_NAME=HappyOtterStudios
  #Alias a utilizar             #Nombre repo github                 #Nombre contenedor desarrollo (-= No tiene) 

PROYECTOS=(
  "etherealb"                   "ethereal-realms-back"              "etherealb_web"
  "etherealf"                   "ethereal-realms-frontend"          "etherealf_web"
  "gpb"                         "gp-back"                           "-"
  "gpf"                         "gp-front"                          "-"
  "devironment"                 "devironment"                       "-"
)

## Campos Estaticos
PATH_ORIGIN_INSTALL="$PWD"
PATHP=/usr/share/
DEVFOLDER=deviroment
DEVPATH=/usr/share/"$DEVFOLDER"
COMPANY_PATH="$HOME/$COMPANY_NAME"
GITHUB_COMPANY=git@github.com:$COMPANY_GIT_NAME

## Importacion
source $PATH_ORIGIN_INSTALL/deviroment/commands/modules/utils.sh

main(){
    obtener_distribucion
    log_step "¿Deseas instalar o desinstalar? (i/un)"
    read -p "Respuesta: " respuesta


    if [[ "$respuesta" == "i" ]]; then
        log_info "Iniciando instalación..."
        log_info "Generando archivo con las configuraciones de los programas
        Este archivo es utilizado por los comandos para identificar
        nombres de contenedores de desarrollo y ubicacion de los archivos
        Puede modificarlo en campos modificables"
        create_programs_file
        install_docker
        install_docker_compose
        install_git
        install_xxd
        install_deviroment
        install_alias
        log_warning "Para ejecutar los comandos en su consola, abra una nueva terminal para actualizar el rc"
        crear_carpeta_company
    elif [[ "$respuesta" == "un" ]]; then
        log_info "Iniciando desinstalación..."
        #Advertir que no se desinstalaran ni git, ni docker, ni docker-compose
        #Advertir que no se va a eliminar la carpeta de proyectos.
        uninstall_deviroment
        uninstall_source
    else
        log_error "Opción no válida."
    fi
}

create_programs_file(){ 
    local file_path="${PATH_ORIGIN_INSTALL}/deviroment/commands/src/programs.sh"
    local index=0
    local array_programs=""
    if [ -f "$file_path" ]; then
        rm "$file_path"
    fi
    touch "$file_path"
    echo "#!/bin/bash" > "$file_path"
    echo "#WARNING! no modifique este archivo, utilice el instalador d deviroment o los comandos disponibles" > "$file_path"
    while [[ $index -lt ${#PROYECTOS[@]} ]]; do
        alias_programs+="${PROYECTOS[$index]} "
        real_name_programs_array+="${PROYECTOS[$index+1]} "
        container_programs_array+="${PROYECTOS[$index+2]} "
        index=$((index + 3))
    done
    echo "alias_programs=(${alias_programs})" >> "$file_path"
    echo "real_name_programs_array=(${real_name_programs_array})" >> "$file_path"
    echo "container_programs_array=(${container_programs_array})" >> "$file_path"
    chmod +x "$file_path"
}

#########################  comandos auxiliares #############################
obtener_distribucion(){
    OS_ID=$(grep ^ID= /etc/os-release | cut -d'=' -f2 | tr -d '"')
}
#########################  xxd #############################
install_xxd_fedora(){
    echo "Instalando Docker en xxd..."
    sudo dnf install -y xxd
}

install_xxd_ubuntu(){
    echo "Instalando Docker en xxd..."
    sudo apt install -y xxd
}

install_xxd(){
    if ! command -v xxd &> /dev/null; then
        log_info "xxd no está instalado. Instalando xxd..."
        "install_xxd_$OS_ID"
        log_success "xxd ha sido instalado correctamente."
    else
        log_info "xxd ya está instalado."
    fi
}
#########################  docker #############################
install_docker_fedora(){
    log_info "Instalando Docker en Fedora..."
    sudo dnf install -y dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
}

install_docker_ubuntu(){
    log_info "Instalando Docker en Ubuntu..."
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
        log_info "Docker no está instalado. Instalando Docker..."
        "install_docker_$OS_ID"
        if command -v docker &> /dev/null; then
            log_success "Docker ha sido instalado correctamente."
        else
            log_error "Un error inesperado no permitio la instalacion de docker"
        fi
    else
        log_info "Docker ya está instalado."
    fi
}
#########################  docker compose #############################
install_docker_compose_fedora(){
    sudo dnf update -y
    sudo dnf install -y docker-compose
    # Verificar instalación
    docker-compose --version
    log_success "Docker Compose instalado correctamente en Fedora."
}

install_docker_compose_ubuntu(){
    # Actualizar paquetes e instalar Docker Compose
    sudo apt update -y
    sudo apt install -y docker-compose
    # Verificar instalación
    docker-compose --version
    log_success "Docker Compose instalado correctamente en Ubuntu."
}

install_docker_compose(){
    if ! command -v docker-compose &> /dev/null; then
        log_info "Docker Compose no está instalado. Instalando Docker..."
        "install_docker_compose_$OS_ID"
        log_info "Docker Compose está instalado."
    else
        log_info "Docker Compose esta instalado"
    fi
}
#########################  git #############################
install_git_fedora(){
    # Actualizar paquetes e instalar Git en Fedora
    sudo dnf update -y
    sudo dnf install -y git

    # Verificar instalación
    git --version
    log_success "Git instalado correctamente en Fedora."
}

install_git_ubuntu(){
    # Actualizar paquetes e instalar Git en Ubuntu
    sudo apt update -y
    sudo apt install -y git

    # Verificar instalación
    git --version
    log_success "Git instalado correctamente en Ubuntu."
}

install_git(){ 
    if ! command -v git &> /dev/null; then
        log_info "Git no está instalado. Instalando Git..."
        "install_git_$OS_ID"
        log_info "Git ha sido instalado correctamente."
    else
        log_info "Git ya está instalado."
    fi
}
#########################  deviroment #############################
install_deviroment() {
    if [ -d "$DEVPATH" ]; then
        log_step "El directorio $DEVPATH ya existe. ¿Deseas reemplazarlo? (s/*):"
        read -p "Respuesta:" choice
        if [ "$choice" == "s" ]; then
            sudo rm -rf "$DEVPATH"
            log_success "Directorio eliminado."
            log_info "Copiando el entorno..."
            sudo cp -r "$DEVFOLDER" "$PATHP"
            sudo chown -R $(whoami) $DEVPATH
        fi
    else
        log_info "Copiando el entorno..."
        sudo cp -r "$DEVFOLDER" "$PATHP"
        sudo chown -R $(whoami) $DEVPATH
    fi
    log_success "Directorio copiado."
    install_alias
}

uninstall_deviroment() {
    log_step "¿Qué deseas eliminar? \n
    1) Solo los aliases \n
    2) Solo el entorno de desarrollo\n
    3) Ambos (aliases y entorno) \n"
    read -p "Elige una opción [1/2/3]: " choice

    case $choice in
        1)
            uninstall_alias
            log_success "Aliases eliminados."
            ;;
        2)
            if [ -d "$DEVPATH" ]; then
                sudo rm -rf "$DEVPATH"
                log_success "Directorio $DEVPATH eliminado."
            else
                log_info "El entorno no existe."
            fi
            ;;
        3)
            if [ -d "$DEVPATH" ]; then
                sudo rm -rf "$DEVPATH"
                log_success "Directorio $DEVPATH eliminado."
            else
                log_info "El entorno no existe."
            fi
            uninstall_alias
            log_success "Ambos, aliases y entorno, han sido eliminados."
            ;;
        *)
            log_error "Opción no válida."
            exit 1
            ;;
    esac
}
######################### alias #############################
install_alias() {
    # Variables
    COMMANDS_FILE="/usr/share/deviroment/commands/main.sh"
    SOURCE_COMMAND="source $COMMANDS_FILE"

    # Verificar y agregar el source en .bashrc
    if [ -f "$HOME/.bashrc" ]; then
        if ! grep -Fxq "$SOURCE_COMMAND" "$HOME/.bashrc"; then
            log_info "Agregando source de comandos en $HOME/.bashrc..."
            echo "$SOURCE_COMMAND" >>"$HOME/.bashrc"
            log_success "comandos cargados en .bashrc"
        fi
    fi

    # Verificar y agregar el source en .zshrc
    if [ -f "$HOME/.zshrc" ]; then
        if ! grep -Fxq "$SOURCE_COMMAND" "$HOME/.zshrc"; then
            log_info "Agregando source de comandos en $HOME/.zshrc..."
            echo "$SOURCE_COMMAND" >>"$HOME/.zshrc"
            log_success "comandos cargados en .zshrc"

        fi
    fi
}

uninstall_source() {
    # Eliminar el source de .bashrc si existe
    if [ -f "$HOME/.bashrc" ]; then
        sed -i "\|$SOURCE_COMMAND|d" "$HOME/.bashrc"
        log_success "Comando source eliminado de $HOME/.bashrc."
    fi

    # Eliminar el source de .zshrc si existe
    if [ -f "$HOME/.zshrc" ]; then
        sed -i "\|$SOURCE_COMMAND|d" "$HOME/.zshrc"
        log_success "Comando source eliminado de $HOME/.zshrc."
    fi
}
#########################  carpetas #############################
crear_carpeta_company(){
    log_info "Generando carpeta de proyectos"
    if [ -d "$COMPANY_PATH" ]; then
        log_warning "La carpeta ya existe,"
    else
        mkdir "$COMPANY_PATH"
        descargar_proyectos_github
    fi
    
}

descargar_proyectos_github(){
    for proyecto in "${PROYECTOS[@]}"; do
        if [ -d "$COMPANY_PATH/$proyecto" ]; then
            log_warning "Ya existe la carpeta del proyecto $proyecto"
        else
            (
                cd "$COMPANY_PATH"
                if git clone "$GITHUB_COMPANY/$proyecto.git" > /dev/null 2>&1; then
                    log_success "Clonación de $proyecto completada exitosamente."
                else
                    log_error "No se pudo clonar $proyecto. Verifica si tienes permisos o si el repositorio existe."
                fi
            )
        fi
    done
}

main