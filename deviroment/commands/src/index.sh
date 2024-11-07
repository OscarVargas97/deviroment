#!/bin/bash

HOSIndex() {
  initialize(){
    declare -A COMMANDS=(
      ["cd"]="hoscd"
      ["code"]="hoscode"
      ["-h"]="run_show_help"
    )
    parse_args "$@"
    eval_and_run_command "$@"
  }
  
  hoscd(){
    
  }

  hoscode() {
    # Define un path base que puede ser modificado
    local programhos=""
    local pathos="$HOME/HOStudios"
    # Modifica el path dependiendo del primer argumento
    case "$2" in
        etheralb)
            programhos="ethereal-realms-back"
            ;;
        ethrealf)
            programhos="ethereal-realms-frontend"
            ;;
        gpb)
            programhos="gp-back"
            ;;
        gpf)
            programhos="gp-front"
            ;;
        *)
            echo "Argumento no reconocido. Por favor usa etheralb, ethrealf, gpb, o gpf."
            return 1
            ;;
    esac
    code "$pathos/$programhos"
  }

  run_show_help(){
    help_file="$PROJECT_DIR/src/commands/show_help/main.sh"
    ShowHelp $help_file
  }

  initialize "$@"
}