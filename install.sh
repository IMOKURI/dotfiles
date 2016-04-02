#!/bin/bash

set -eu

export DOTFILES_REPO="https://github.com/IMOKURI/dotfiles.git"
export DOTPATH=~/.dotfiles

is_exist(){
  type "$1" >/dev/null 2>&1
  return $?
}

set_proxy(){
  export http_proxy="$1"
  export https_proxy="$1"

  git config --global http.proxy "$1"
  git config --global https.proxy "$1"

  cp ~/.gitconfig{,.local}

  echo "proxy = \"$1\"" >> ~/.curlrc

  echo "http_proxy=$1" >> ~/.wgetrc
  echo "https_proxy=$1" >> ~/.wgetrc

  echo "http_proxy=$1" >> ~/.bash_profile.local
  echo "https_proxy=$1" >> ~/.bash_profile.local
}

while true; do
  read -p "Do you wish to use proxy to download dotfiles? [n] " -e -i "n" yn
  case $yn in
    [Yy]* )
      read -p "Please input proxy address and port(ex: http://proxy.example.com:8080). " proxy_uri
      set_proxy "$proxy_uri"
      break;;
    [Nn]* )
      break;;
    * )
      echo "Please answer yes or no.";;
  esac
done

if is_exist "git"; then
  git clone --recursive "$DOTFILES_REPO" "$DOTPATH"

elif is_exist "curl" || is_exist "wget"; then
  tarball="https://github.com/IMOKURI/dotfiles/archive/master.tar.gz"

  if is_exist "curl"; then
    curl -L "$tarball"

  elif is_exist "wget"; then
    wget -O - "$tarball"

  fi | tar xz

  mv -f dotfiles-master "$DOTPATH"

else
  exit 1
fi

cd ~/.dotfiles
if [ $? -ne 0 ]; then
  exit 1
fi

while true; do
  read -p "Do you wish to install haskell packages? [n] " -e -i "n" yn
  case $yn in
    [Yy]* )
      if is_exist "stack"; then
        make haskell-setup
      else
        echo "Skip due to missing stack."
      fi
      break;;
    [Nn]* )
      break;;
    * )
      echo "Please answer yes or no.";;
  esac
done

make deploy

