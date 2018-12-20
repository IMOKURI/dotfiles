# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

##### Set bash options #####

# ディレクトリ名を実行すると、そのディレクトリに移動する
shopt -s autocd

# dotで始まるファイルをワイルドカードのマッチ対象に含める
shopt -s dotglob

# ** を指定すると、該当ディレクトリ以下のディレクトリを再帰的にマッチにする
shopt -s globstar

alias jfl='curl -X POST --insecure -F "jenkinsfile=<Jenkinsfile" https://jenkins.docker.hpecorp.net/pipeline-model-converter/validate'

# cdls
alias cd='cdls'

cdls () {
  \cd "$@" && pwd && ls -l
}

# cdroot
cdroot () {
  cd "$(git rev-parse --show-toplevel)" || return
}

alias g='git'
complete -o default -o nospace -F _git g

alias git-delete-merged-branch='git branch --merged | grep -vE "^\*| master$| develop$" | xargs git branch -d'

########## For git completion and prompt ##########

GIT_PROMPT="$(find /usr/share/doc/ -type f -name git-prompt.sh 2> /dev/null | head -1)"
if [ -n "$GIT_PROMPT" ]; then
  source "$GIT_PROMPT"
fi

GIT_COMPLETION="$(find /usr/share/doc/ -type f -name git-completion.bash 2> /dev/null | head -1)"
if [ -n "$GIT_COMPLETION" ]; then
  source "$GIT_COMPLETION"
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
case ${UID} in
0)
  PS1='\[\033[38;05;9m\]${?##0}\[\033[38;05;11m\][\u@\h \W]\[\033[38;05;13m\]$(__git_ps1)\[\033[38;05;11m\]\$\[\033[0m\] '
  ;;
*)
  PS1='\[\033[38;05;9m\]${?##0}\[\033[38;2;0;179;136m\][\u@\h \W]\[\033[38;05;13m\]$(__git_ps1)\[\033[38;2;0;179;136m\]\$\[\033[0m\] '
  ;;
esac

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# enable Haskell Stack completion
if [[ $(type stack > /dev/null 2>&1) ]]; then
  eval "$(stack --bash-completion-script stack)"
fi
