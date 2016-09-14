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

export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/heroku/bin:$PATH

export EDITOR="vim"

export HEROKU_SSL_VERIFY=disable

