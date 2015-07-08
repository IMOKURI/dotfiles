# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$HOME/.cabal/bin:$PATH:$HOME/.local/bin:$HOME/bin

export HTTP_PROXY=http://proxy.jpn.hp.com:8080/
export HTTPS_PROXY=http://proxy.jpn.hp.com:8080/

# Welcome message
fortune | cowsay

