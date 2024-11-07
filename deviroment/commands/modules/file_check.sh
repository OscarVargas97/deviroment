#!/bin/bash

# Function to check if a directory exists
check_directory_exists() {
  local dir=$1
  if [[ ! -d "$dir" ]]; then
    return 1
  fi
  return 0
}

# Function to check if a file exists
check_file_exists() {
  local file=$1
  if [[ ! -f "$file" ]]; then
    return 1
  fi
  return 0
}

check_project() {
    if ! check_directory_exists "$PROJECT_ROOT/$1"; then
      echo "El proyecto" "$PROJECT_ROOT"/"$1" "no existe."
      return 1
    fi
    if ! check_file_exists "$PROJECT_ROOT/$1/README.md"; then
      echo "El proyecto ""$PROJECT_ROOT"/"$1" "no existe."
      return 1
    fi
    if ! check_file_exists "$PROJECT_ROOT/$1/main.sh"; then
      echo "El proyecto ""$PROJECT_ROOT"/"$1"" no existe."
      return 1
    fi
    if ! check_file_exists "$PROJECT_ROOT/$1/src/index.sh"; then
      echo "El proyecto ""$PROJECT_ROOT"/"$1"" no existe."
      return 1
    fi
    if ! check_file_exists "$PROJECT_ROOT/$1/src/commands/show_help/main.sh"; then
      echo "El proyecto ""$PROJECT_ROOT"/"$1"" no existe."
      return 1
    fi
    return 0
}

check_command() {
  if check_directory_exists "$PROJECT_ROOT/$1/src/commands/$2"; then
      echo "El comando '$2' ya existe."
      return 1
  fi
  if check_file_exists "$PROJECT_ROOT/$1/src/commands/$2/main.sh"; then
      echo "El comando '$2' ya existe."
      return 1
  fi
  return 0
}