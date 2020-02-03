
##### Banner ##################################################################

RED="\033[38;2;255;84;88m"
GREEN="\033[38;2;98;209;150m"
YELLOW="\033[38;2;255;179;120m"
BLUE="\033[38;2;101;178;255m"
MAGENTA="\033[38;2;144;108;255m"
CYAN="\033[38;2;99;242;241m"
CLEAR_COLOR="\033[0m"

INFO="GREEN"
WARN="YELLOW"
ERROR="RED"

if [[ -t 1 ]]; then
    COL=$(tput cols)
else
    COL=80
fi

function _banner() {
    sep=$(for ((i = 1; i < ${COL}; i++)); do echo -n =; done)
    printf "\n${BLUE}%s %s${CLEAR_COLOR}\n\n" "${1}" "${sep:${#1}}"
}

function _logger() {
    COLOR="${1}"
    printf "${!COLOR}%s${CLEAR_COLOR}\n" "${2}"
}
