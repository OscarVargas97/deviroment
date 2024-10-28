#!/bin/bash

CommandRoute() {
  source "$PROJECT_DIR/modules/commands/static_function.sh"
  ###### Project Name ######
  local command_name="add_command"
  ##########################
  ###### Params Number ######
  local nc_params=0
  ###########################
  ###### Subcommands ######
  declare -A CommandSC=(
  )
  #########################
  ###### Flags ######
  local valid_flags=("-k" "-d")
  ### -k 
  local MainFlag_k=false
  local MainFlagParams_k=()
  local MainFlagParamsN_k=2
  ###
  ### -d
  local MainFlag_d=false
  local MainFlagParams_d=()
  local MainFlagParamsN_d=0
  ###
  ###### Get Flags ######
  local _flags=($(get_flags $@))
  #######################
  ###### Commands and Subcommands ######
  command_main() {
    flag_check $_flags
    if check_promp "${@:"$comm_iterate"}"; then
      exit 1
    fi
    source "$PROJECT_DIR/src/scripts/$command_name/script.sh"
    CommandScript "$@"
  }
  #######################
  initialize() {
    if [ ${#CommandSC[@]} -eq 0 ]; then
      command_main "$@"
    # Here you can add subcommands
    fi
  }
  initialize "$@"
}
