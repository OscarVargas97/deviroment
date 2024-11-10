get_program_path() {
  local index=0
  if [ "$1" = "" ]; then
      echo "error"
      return
  fi
  while [[ $index -le ${#alias_programs[@]} ]]; do
    if [[ "$1" == "${alias_programs[$index]}" ]]; then
      echo "${GITHUB_FOLDER_COMPANY}/${real_name_programs_array[$((index))]}"
      return
    fi
    index=$((index + 1))
  done
  echo "error"
}

get_program_dev_container() {
  local index=0
  if [ "$1" = "" ]; then
      echo "error"
      return
  fi
  while [[ $index -le ${#alias_programs[@]} ]]; do
    if [[ "$1" == "${alias_programs[$index]}" ]]; then
      echo "${container_programs_array[$((index))]}"
      return
    fi
    index=$((index + 1))
  done
  echo "error"
}

error_programs_msg(){
  echo "Argumento no reconocido. Por favor usa ${alias_programs[@]}."
}