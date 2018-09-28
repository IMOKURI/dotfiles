# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Get local setting
if [ -f ~/.bash_profile.local ]; then
	. ~/.bash_profile.local
fi

# User specific environment and startup programs

export PATH=$HOME/node_modules/.bin:$HOME/.rbenv/bin:$HOME/.local/bin:$HOME/bin:/usr/local/heroku/bin:/usr/local/go/bin:~/go/bin:$PATH

export LESS='-i -M -N -R -W -z-3 -x4 -F -X'

export GREP_OPTIONS='--exclude-dir=.git'

export EDITOR="vi"

if [ -f ~/.hosts ]; then
  export HOSTALIASES=~/.hosts
fi

# for pipenv
export WORKON_HOME=~/.virtualenvs

# initialize rbenv
if [ -n "$(type -t rbenv)" ]; then
  eval "$(rbenv init -)"
fi
