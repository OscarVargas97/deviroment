#!/bin/bash

HOSIndex() {
  local validprograms="etherealb, etherealf, gpb, gpf o devironment"

  initialize(){
    declare -A COMMANDS=(
      ["home"]="hoshome"
      ["code"]="hoscode"
      ["rcode"]="hosrcode"
      ["-h"]="run_show_help"
      ["compose"]="hoscompose"
    )
    parse_args "$@"
    eval_and_run_command "$@"
  }

  get_program_path() {
    # Define el path base que puede ser modificado
    local pathos="$HOME/HOStudios"

    # Modifica el path dependiendo del primer argumento
    case "$1" in
      etherealb)
        result="$pathos/ethereal-realms-back"
        ;;
      etherealf)
        result="$pathos/ethereal-realms-frontend"
        ;;
      gpb)
        result="$pathos/gp-back"
        ;;
      gpf)
        result="$pathos/gp-front"
        ;;
      devironment)
        result="$pathos/devironment"
        ;;
      *)
        result="error"
        ;;
    esac
    echo "$result" 
  }

  get_program_dev_containr() {
    local container=""
    case "$1" in
      etherealb)
        container="web"
        ;;
      etherealf)
        container="web"
        ;;
      gpb)
        container=""
        ;;
      gpf)
        container=""
        ;;
      devironment)
        container=""
        ;;
      *)
        container="error"
        ;;
    esac
    echo "$container" 
  }

  hoshome(){
    cd $HOME/HOStudios
  }

  hoscode() {
    local programpath=$(get_program_path "$2")
    if [ $programpath = "error" ]; then
        echo "Argumento no reconocido. Por favor usa $validprograms."
        exit 1
    fi
    code $programpath
  }
  
  hosrcode() {
    local programcontainer=$(get_program_dev_containr "$2")
    if [ $programcontainer = "error" ]; then
        echo "Argumento no reconocido. Por favor usa $validprograms."
        exit 1
    fi
    if [ $programcontainer = "" ]; then
        echo log_info("El programa no posee dev-container o bien no esta configurado en deviroment.")
        echo log_info("Revise si hay actualizaciones pendientes en deviroment o consulte en la documentacion")
        echo log_info("En caso de no encontrarlo y ser necesario solicite con su encargado la implementacion de un contenedor de desarrollo")
        exit 1
    if
    code --folder-uri=vscode-remote://"$programcontainer"+%vscode_remote_hex%/app
  }

  hoscompose() {
    local actualpath="$PWD"
    local programpath=$(get_program_path "$2")
    if [ $programpath = "error" ]; then
        echo "Argumento no reconocido. Por favor usa $validprograms."
        exit 1
    fi
    cd $programpath
    docker compose "${@:3}"
    cd $actualpath
  }

  run_show_help(){
    help_file="$PROJECT_DIR/src/commands/show_help/main.sh"
    ShowHelp $help_file
  }

  initialize "$@"
}