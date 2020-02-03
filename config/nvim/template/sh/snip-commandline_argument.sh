ScriptVersion="1.0"

#===  FUNCTION  ================================================================
#         NAME:  usage
#  DESCRIPTION:  Display usage information.
#===============================================================================
function usage ()
{
    cat << EOS

  Usage :  ${0##/*/} [options] [--] 

  Options: 
  -h|help       Display this message
  -v|version    Display script version

EOS
}    # ----------  end of function usage  ----------

#-----------------------------------------------------------------------
#  Check number of command line arguments
#-----------------------------------------------------------------------
[ $# -lt 1 ] && { echo -e "\n\tUsage:  ${0##/*/} File\n"; exit 1; }

#-----------------------------------------------------------------------
#  Handle command line arguments
#-----------------------------------------------------------------------

while getopts ":hv" opt
do
  case $opt in

    h|help     )  usage; exit 0   ;;

    v|version  )  echo "$0 -- Version $ScriptVersion"; exit 0   ;;

    \? )  echo -e "\n  Option does not exist : $OPTARG\n"
          usage; exit 1   ;;

  esac    # --- end of case ---
done
shift $(($OPTIND-1))
