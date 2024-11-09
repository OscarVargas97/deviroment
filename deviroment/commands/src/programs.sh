local validprograms="etherealb, etherealf, gpb, gpf o devironment"
 
get_program_path() {
  case "$1" in
    etherealb) result="$GITHUB_FOLDER_COMPANY/ethereal-realms-back" ;;
    etherealf) result="$GITHUB_FOLDER_COMPANY/ethereal-realms-frontend" ;;
    gpb) result="$GITHUB_FOLDER_COMPANY/gp-back" ;;
    gpf) result="$GITHUB_FOLDER_COMPANY/gp-front" ;;
    devironment) result="$GITHUB_FOLDER_COMPANY/devironment" ;;
    *) result="error" ;;
  esac
  echo "$result"
}

get_program_dev_container() {
  local container=""
  case "$1" in
    etherealb) container="web" ;;
    etherealf) container="web" ;;
    gpb) container="" ;;
    gpf) container="" ;;
    devironment) container="" ;;
    *) container="error" ;;
  esac
  echo "$container"
}