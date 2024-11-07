#!/bin/bash

CommandRoute() {
  source "$PROJECT_DIR/modules/commands/static_function.sh"
  ###### Project Name ######
  local command_name="add_command"
  ##########################
  ###### Params Number ######
  local nc_params=1
  ###########################
  ###### Subcommands ######
  declare -A CommandSC=(
  )
  #########################
  ###### Flags ######
  local valid_flags=("-admin")
  ### admin
  local MainFlag_admin=false
  local MainFlagParams_admin=()
  local MainFlagParamsN_admin=0
  ###
  ###### Get Flags ######
  local _flags=($(get_flags $@))
  #######################
  ###### Commands and Subcommands ######
  command_main() {
    if [ "${#valid_flags[@]}" -gt "$nc_params" ]; then
      echo "El numero de banderas es mayor al permitido"
      exit 1
    fi
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
    fi
  }
  initialize "$@"
}
