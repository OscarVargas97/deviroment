#!/bin/bash

HOSIndex() {
  local validprograms="etherealb, etherealf, gpb, gpf o devironment"

  initialize(){
    declare -A COMMANDS=(
      ["code"]="hoscode"
      ["compose"]="hoscompose"
      ["rcode"]="hosrcode"
      ["attach"]="hosattach"
      ["-h"]="run_show_help"
    )
    echo "$1"
    parse_args "$@"
    eval_and_run_command "$@"
  }

  get_program_path() {
    case "$1" in
      etherealb) result="$GITHUB_FOLDER_COMPANY/ethereal-realms-back" ;;
      etherealf) result="$GITHUB_FOLDER_COMPANY/ethereal-realms-frontend" ;;
      gpb) result="$GITHUB_FOLDER_COMPANY/gp-back" ;;
      gpf) result="$GITHUB_FOLDER_COMPANY/gp-front" ;;
      devironment) result="$GITHUB_FOLDER_COMPANY/devironment" ;;
      *) result="error" ;;
    esac
    echo "$result"
  }

  get_program_dev_container() {
    local container=""
    case "$1" in
      etherealb|etherealf) container="web" ;;
      gpb|gpf|devironment) container="" ;;
      *) container="error" ;;
    esac
    echo "$container"
  }

  hoscode() {
    local programpath
    programpath=$(get_program_path "$2")
    if [ "$programpath" = "error" ]; then
      echo "Argumento no reconocido. Por favor usa $validprograms."
      exit 1
    fi
    code "$programpath"
  }

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

  hoscompose() {
    local actualpath="$PWD"
    local programpath
    programpath=$(get_program_path "$2")
    if [ "$programpath" = "error" ]; then
      echo "Argumento no reconocido. Por favor usa $validprograms."
      exit 1
    fi
    cd "$programpath"
    docker compose "${@:3}"
    cd "$actualpath"
  }

  hosattach(){
    local programcontainer
    programcontainer=$(get_program_dev_container "$2")
    if [ "$programcontainer" = "error" ]; then
      echo "Argumento no reconocido. Por favor usa $validprograms."
      exit 1
    fi
    local CONTAINER_NAME="$2"_"$programcontainer"
    docker exec -it $CONTAINER_NAME zsh
  }

  run_show_help(){
    help_file="$PROJECT_DIR/src/commands/show_help/main.sh"
    ShowHelp "$help_file"
  }

  initialize "$@"
}
