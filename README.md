# dotfiles

## Setup (Prerequisites)

* Install git
* Install [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
* Install python3
* Install python packages
    - `pip3 install neovim jedi flake8 icdiff Pygments virtualenvwrapper`

## Setup (Recommendation)

* Install [Stack](https://docs.haskellstack.org/en/stable/README/#how-to-install)
* Install ShellCheck
    - `stack setup`
    - `stack install shellcheck`
* Add alias nvim to vi (by using `update-alternatives` etc)

## Installation

`bash -c "$(curl -fsSL https://git.io/imokuri)"`

or

`bash -c "$(wget -qO - https://git.io/imokuri)"`

## Feature

* Download repository to ~/.dotfiles
* Create symlinks to dotfile
