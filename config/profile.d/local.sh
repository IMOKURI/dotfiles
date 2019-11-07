# .config/profile.d/local.sh

##### Get proxy setting #######################################################

if [ -f ~/.config/profile.d/proxy.sh ]; then
  . ~/.config/profile.d/proxy.sh
fi

##### User specific environment ###############################################

export LANG="en_US.UTF-8"

export PATH=$HOME/neovim/bin:$HOME/vim/bin:$HOME/node_modules/.bin:$HOME/.local/bin:$HOME/go/bin:$HOME/bin:$PATH

export LESS="-i -M -R -W -z-3 -x4 -F -X"

export EDITOR="vi"
export KUBE_EDITOR="/usr/bin/vi"

if [ -f ~/.hosts ]; then
  export HOSTALIASES=~/.hosts
fi

export PIPENV_VENV_IN_PROJECT=true
