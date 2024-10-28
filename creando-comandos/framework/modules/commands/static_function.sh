#!/bin/bash

check_promp(){ 
  local iteration=0
  if [ $# -eq 0 ]; then
    return 1
  else
    for i in $@; do
      if [ -z "$i" ]; then
        return 1
      else 
        if [ "$i" != "$command_name" ]; then
          iteration=+1
        fi  
      fi
    done
    if [ $iteration -eq $nc_params ]; then
      return 1
    else
      echo "$command_name no recibe parametros"
      exit 1
    fi
  fi
  echo "El parametro ingresado no es valido"
  exit 1
}

flag_validation(){
  local max_params=$1
  shift
  for ((a=1; a<=max_params; a++)); do
    index=$((iteration + a))
    eval argument=\${$index}
    if [ -n $argument ]; then
      if [[ ${argument} = -* ]]; then
        break
      fi
      eval "$main_flag_params+=($argument)"
      skip_params+=($index)  
    fi
  done
}

options_flag_check(){
  local value=$1
  shift
  local value_without_dash=${value//-/}
  local found=false
  local param_num
  local main_flag_params_n
  local main_flag_params
  local param_count
  for flag in "${valid_flags[@]}"; do
    if [[ "$flag" == "$value" ]]; then
        found=true
        break
    fi
  done
  if ! $found;then
    if [[ ${value} != -* ]]; then
      echo "El parametro $value no es valido, porfavor revisar -h para mas informacion"
      exit 1
    fi
    echo La bandera $value no es válida, porfavor revisar -h para mas informacion
    exit
  fi
  eval "MainFlag_${value_without_dash}"=true
  main_flag_params_n="MainFlagParamsN_""$value_without_dash"
  main_flag_params="MainFlagParams_""$value_without_dash"
  eval param_num=\$$main_flag_params_n
  flag_validation $param_num $@
  eval param_count=\${#$main_flag_params[@]}
  if [ $param_count -ne $param_num ]; then
    echo "Faltan parámetros para la bandera $flag"
    exit 1
  fi 
}

flag_check() {
  local iteration=1
  local index
  local argument
  local skip_params=() 
  local check_continue=false
  for i in "$@"; do
    check_continue=true;
    for j in "${skip_params[@]}"; do
      if [ $iteration = $j ]; then
        check_continue=false
      fi
    done
    if $check_continue; then
      options_flag_check $i "$@"
    fi
    iteration=$((iteration+1))
  done
}