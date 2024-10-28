#!/bin/bash
######## Flags ########
# MainFlag_k MainFlagParam_k= 3 params
# MainFlag_d
######## End Flags ########
CommandScript() {
  initialize() {
    echo "¿A que proyecto pertenece el comando?"
    local _project_name
    read _project_name
    if ! check_project $_project_name; then
      exit 1
    fi
    local create_command_name
    create_new_command_name

    if ! check_command "$_project_name" "$create_command_name"; then
      delete_or_not "$PROJECT_ROOT/$_project_name"
    fi
    echo "Cual es la descripcion del comando ?"
    local description
    read description
    create_command
  }

  delete_or_not() {
    echo "¿Deseas eliminar el comando creado? (s/n)"
    read response
    if [ "$response" = "s" ]; then
      echo "¿Estás seguro de que deseas eliminar el comando? Esta acción no se puede deshacer. (s/n)"
      read second_response
      if [ "$second_response" = "s" ]; then
        if [ -d "$1/src/commands/$create_command_name" ]; then
          rm -rf "$1/src/commands/$create_command_name"
          echo "Directorio $1/src/commands/$create_command_name eliminado."
        fi
        if [ -d "$1/src/scripts/$create_command_name" ]; then
          rm -rf "$1/src/scripts/$create_command_name"
          echo "Directorio $1/src/scripts/$create_command_name eliminado."
        fi
        return 0
      fi
    fi
    echo "El comando no se ha eliminado. Puedes revisarlo en $command_dir"
    exit 1
  }

  create_new_command_name() {
    while true; do
      echo "Ingrese el nombre del comando (máximo 14 caracteres) o escriba 'salir' para terminar:"
      read input
      if [ "$input" = "salir" ]; then
        echo "Saliendo del programa..."
        exit 0
      elif [ ${#input} -le 14 ]; then
        create_command_name="$input"
        break
      else
        echo "El nombre ingresado es demasiado largo. Por favor, intente nuevamente."
      fi
    done
  }

  create_command() {
    # Cargando archivos a Generar
    create_files
    # Cargando archivos a Generar
    source $PROJECT_DIR/src/scripts/add_command/create_main.sh
    source $PROJECT_DIR/src/scripts/add_command/create_script.sh
    local main_path="$PROJECT_ROOT/$_project_name/src/commands/$create_command_name/main.sh"
    local index_path="$PROJECT_ROOT/$_project_name/src/index.sh"
    local script_path="$PROJECT_ROOT/$_project_name/src/scripts/$create_command_name/script.sh"
    local main_content_add
    local script_content_add
    main_content_add=$(create_main)
    script_content_add=$(create_script_function)
    charge_content
    modify_file
    modify_help
    modify_documentation
  }

  create_files() {
    mkdir "$PROJECT_ROOT"/"$_project_name"/src/commands/"$create_command_name"
    touch "$PROJECT_ROOT"/"$_project_name"/src/commands/"$create_command_name"/main.sh
    mkdir "$PROJECT_ROOT"/"$_project_name"/src/scripts/"$create_command_name"
    touch "$PROJECT_ROOT"/"$_project_name"/src/scripts/"$create_command_name"/script.sh
  }

  charge_content() {
    echo "$main_content_add" >"$main_path"
    echo "$script_content_add" >"$script_path"
  }

  modify_file() {
    sed -i '/local command_name=/c\  local command_name="'"$create_command_name"'"' $main_path
    # Contenido que se va a agregar
    command_declaration="[\"$create_command_name\"]=\"run_$create_command_name\""
    # Verificar si la declaración del comando ya existe
    if ! grep -qF "$command_declaration" "$index_path"; then
      sed -i '/declare -A COMMANDS=(/a \ \ \ \ \ \ ["'"$create_command_name"'"]="'"run_$create_command_name"'"' $index_path
    fi
    # Verificar si la definición de la función ya existe
    if ! grep -qF "run_$create_command_name(" "$index_path"; then
      sed -i '/initialize "\$@"/i \\n'"run_$create_command_name"'(){\n    source "$PROJECT_DIR/src/commands/'"$create_command_name"'/main.sh"\n    CommandRoute "$@"\n  }\n' $index_path
    fi
  }

  modify_help() {
    local help_path="$PROJECT_ROOT/$_project_name/src/commands/show_help/main.sh"
    local max_length=16
    local create_command_name_length=${#create_command_name}
    local command_declaration
    local verificate_declaration
    local response
    local spaces_count=$((max_length - create_command_name_length))
    local spaces=""
    for ((i=0; i<spaces_count; i++)); do
        spaces+=" "
    done
    command_declaration=$(echo "echo \"  $create_command_name$spaces$description\"")
    verificate_declaration=$(echo 'echo "  '$create_command_name)
    if grep -q "$verificate_declaration"  $help_path; then
      echo "Ya existe una descripcion del comando, desea sobreescribirla? (s/n)"
      read response
      if [ "$response" = "s" ]; then
        sed -i "/$verificate_declaration/d" $help_path
        sed -i "/# New_Commands:/a $command_declaration" $help_path
      fi
      return 0
    fi
    sed -i "/# New_Commands:/a $command_declaration" $help_path
  }

  modify_documentation() {
    local documentation_path="$PROJECT_ROOT/$_project_name/README.md"
    
  }

  initialize "$@"
}
