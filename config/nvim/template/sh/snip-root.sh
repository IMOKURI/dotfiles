# Check for root
[ $(id -u) -ne 0 ] && { echo This script must be run as root; exit 1; }

