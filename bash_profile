# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Get local setting
if [ -f ~/.bash_profile.local ]; then
  . ~/.bash_profile.local
fi

# Get proxy setting
if [ -f ~/.bash_profile.proxy ]; then
  . ~/.bash_profile.proxy
fi

# User specific environment and startup programs

export PATH=$HOME/node_modules/.bin:$HOME/.local/bin:$HOME/bin:$PATH

export LESS='-i -M -N -R -W -z-3 -x4 -F -X'

export GREP_OPTIONS='--exclude-dir=.git'

export EDITOR="vi"

if [ -f ~/.hosts ]; then
  export HOSTALIASES=~/.hosts
fi
