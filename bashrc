# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

##### Set bash options #####

# dotで始まるファイルをワイルドカードのマッチ対象に含める
shopt -s dotglob

# ** を指定すると、該当ディレクトリ以下のディレクトリを再帰的にマッチにする
shopt -s globstar

# Colorized cat
alias c='pygmentize -g'

########## For git completion and prompt ##########

if [ -f ~/.git-prompt.sh ]; then
	source ~/.git-prompt.sh
fi

# Unstaged (*) and staged (+) changes will be shown next to the branch name
GIT_PS1_SHOWDIRTYSTATE=true

# A "<" indicates you are behind, ">" indicates you are ahead,
# "<>" indicates you have diverged and "=" indicates that there is no difference.
GIT_PS1_SHOWUPSTREAM=auto

# If there're untracked files, then a '%' will be shown next to the branch name.
GIT_PS1_SHOWUNTRACKEDFILES=true

# If something is stashed, then a '$' will be shown next to the branch name.
GIT_PS1_SHOWSTASHSTATE=true

##################################################

# Set prompt
PS1='\[\e[0;33m\]${?##0}\[\e[0;36m\][\u@\h \W]\[\e[0;35m\]$(__git_ps1)\[\e[0;36m\]\$\[\e[0m\] '

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
