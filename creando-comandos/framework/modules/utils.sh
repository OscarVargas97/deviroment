GREEN='\e[32m'
RED='\e[31m'
GREY='\e[90m'
WHITE='\e[97m'
NC='\e[0m' # No Color

# Funciones para aplicar el color a los strings
green() {
    echo -e "${GREEN}$1${NC}"
}

red() {
    echo -e "${RED}$1${NC}"
}

grey() {
    echo -e "${GREY}$1${NC}"
}

white() {
    echo -e "${WHITE}$1${NC}"
}

# Funciones para loguear mensajes
log_info() {
    local content=$(grey "       [INFO] $(date '+%Y-%m-%d %H:%M:%S') - $1")
    echo "$content"
}

log_success() {
    local content=$(green "           [SUCCESS] $(date '+%Y-%m-%d %H:%M:%S') - $1")
    echo "$content"
}

log_error() {
    local content=$(red "           [ERROR] $(date '+%Y-%m-%d %H:%M:%S') - $1")
    echo "$content"
}

log_step() {
    local content=$(white "[STEP] $(date '+%Y-%m-%d %H:%M:%S') - $1")
    echo "$content"
}
