#!/bin/bash

RflexshIndex() {
  initialize(){
    declare -A COMMANDS=(
      ["add_command"]="run_add_command"
      ["-h"]="run_show_help"
    )
    parse_args "$@"
    eval_and_run_command "$@"
  }
  
  run_show_help(){
    help_file="$PROJECT_DIR/src/commands/show_help/main.sh"
    ShowHelp $help_file
  }

  run_add_command() {
    source "$PROJECT_DIR/src/commands/add_command/main.sh"
    CommandRoute "$@"
  }

  initialize "$@"
}