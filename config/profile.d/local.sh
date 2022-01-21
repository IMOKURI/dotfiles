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
# Rust
export PATH=$PATH:/usr/lib/cargo/bin

export GOPATH=$HOME/go

export LESS="-i -M -R -W -z-3 -x4 -F -X"

export EDITOR="vi"

# export MANPAGER='nvim +Man!'

if [ -f ~/.hosts ]; then
  export HOSTALIASES=~/.hosts
fi

##### Load pyenv ##############################################################

export PATH=$HOME/.pyenv/bin:$PATH
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"
