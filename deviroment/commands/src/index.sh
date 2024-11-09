#!/bin/bash

PIndex() {
  source $PROJECT_DIR/src/programs.sh
  source $PROJECT_DIR/src/commands/code/script.sh
  source $PROJECT_DIR/src/commands/compose/script.sh
  source $PROJECT_DIR/src/commands/rcode/script.sh
  source $PROJECT_DIR/src/commands/attach/script.sh

  initialize(){
    declare -A COMMANDS=(
      ["code"]="compcode"
      ["compose"]="compcompose"
      ["rcode"]="comprcode"
      ["attach"]="compattach"
      ["-h"]="run_show_help"
    )
    parse_args "$@"
    eval_and_run_command "$@"
  }

  run_show_help(){
    help_file="$PROJECT_DIR/src/commands/show_help/main.sh"
    ShowHelp "$help_file"
  }

  initialize "$@"
}
