# .config/profile.d/local.sh

##### User specific environment ###############################################

export LANG="en_US.UTF-8"

export LESS="-i -M -R -W -z-3 -x4 -F -X"

export EDITOR="nvim"

if [ -f ~/.hosts ]; then
  export HOSTALIASES=~/.hosts
fi
