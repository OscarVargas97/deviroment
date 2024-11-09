#!/bin/bash

HOSIndex() {
   
  initialize(){
    source
    source
    source
    source
    source
    source

    declare -A COMMANDS=(
      ["attach"]="hosattach"
      ["code"]="hoscode"
      ["compose"]="hoscompose"
      #["create"]="hoscreate"
      ["rcode"]="hosrcode"

      ["-h"]="run_show_help"
    )
    echo "$1"
    parse_args "$@"
    eval_and_run_command "$@"
  }

  run_show_help(){
    help_file="$PROJECT_DIR/src/commands/show_help/main.sh"
    ShowHelp "$help_file"
  }

  initialize "$@"
}
