# .config/profile.d/local.sh

##### Get proxy setting #######################################################

if [ -f ~/.config/profile.d/proxy.sh ]; then
  . ~/.config/profile.d/proxy.sh
fi

if [ -f ~/.local/bin/bashmarks.sh ]; then
  . ~/.local/bin/bashmarks.sh
fi

##### User specific environment ###############################################

export PATH=$HOME/neovim/bin:$HOME/node_modules/.bin:$HOME/.local/bin:$HOME/bin:$PATH

export LESS='-i -M -R -W -z-3 -x4 -F -X'

export GREP_OPTIONS='--exclude-dir=.git'

export EDITOR="vi"

if [ -f ~/.hosts ]; then
  export HOSTALIASES=~/.hosts
fi

export PIPENV_VENV_IN_PROJECT=true
