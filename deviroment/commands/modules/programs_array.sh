get_program_path() {
  local index=0
  while [[ $index -lt ${#PROYECTOS[@]} ]]; do
    echo "$index ${#PROYECTOS[@]}"
        echo "validprograms=\"${validprograms}\"" >> "$file_path"
    if [[ "$1" == "${PROYECTOS[$index]}" ]]; then
      echo "${GITHUB_FOLDER_COMPANY}/${PROYECTOS[$((index + 1))]}"
      return
    fi
    index=$((index + 3))
  done
  echo "error"
}

get_program_dev_container() {
  local index=0
  while [[ $index -lt ${#PROYECTOS[@]} ]]; do
    if [[ "$1" == "${PROYECTOS[$index]}" ]]; then
      echo "${PROYECTOS[$((index + 2))]}"
      return
    fi
    index=$((index + 3))
  done
  echo "error"
}