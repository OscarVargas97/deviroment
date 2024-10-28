#!/bin/bash
create_script_function(){
    echo '#!/bin/bash
######## Flags ########
######## End Flags ########

CommandScript() {
    initialize() {
        echo 'soy la funcion pepe'
    }
    initialize "$@"
}'
}