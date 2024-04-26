# .config/profile.d/local.sh

##### Get proxy setting #######################################################

if [ -f ~/.config/profile.d/proxy.sh ]; then
  . ~/.config/profile.d/proxy.sh
fi

##### User specific environment ###############################################

export LANG="en_US.UTF-8"

export LESS="-i -M -R -W -z-3 -x4 -F -X"

export EDITOR="nvim"

if [ -f ~/.hosts ]; then
  export HOSTALIASES=~/.hosts
fi

export JUPYTERLAB_SETTINGS_DIR="$HOME/.config/jupyterlab"
