# .config/profile.d/local.sh

##### Get proxy setting #######################################################

if [ -f ~/.config/profile.d/proxy.sh ]; then
  . ~/.config/profile.d/proxy.sh
fi

##### User specific environment ###############################################

export LANG="en_US.UTF-8"

export PATH=$HOME/.local/bin:$HOME/bin:$PATH
# Go
export PATH=$HOME/go/bin:$PATH
# Python
export PATH=$HOME/.poetry/bin:$PATH
# Neovim/Vim
export PATH=$HOME/neovim/bin:$HOME/vim/bin:$PATH

export GOPATH=$HOME/go

export PYLINTRC=$HOME/.config/pylintrc

export LESS="-i -M -R -W -z-3 -x4 -F -X"

export EDITOR="vi"

if [ -f ~/.hosts ]; then
  export HOSTALIASES=~/.hosts
fi
