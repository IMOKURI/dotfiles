# dotfiles

Deploy dotfiles using ansible.

## Requirement

* curl

Set environment variables if you need to use proxy.

```
export http_proxy=http://proxy.example.com:port
export https_proxy=http://proxy.example.com:port
```

## Installation

```
bash -c "$(curl -fsSL https://git.io/imokuri)"
```

## Feature

* Install Packages
	* git
	* git-lfs
	* neovim
	* python2
	* python3
	* ruby
	* nodejs	etc...
* Install Python2 Packages
	* jedi
	* flake8
	* virtualenvwrapper
	* yamllint
	* vint	etc...
* Install Python3 Packages
	* See above...
* Install Ruby Packages
	* rubocop
	* mdl	etc...
* Set Alternative Commands
* Setup Python Virtualenv
* Setup Rbenv
* Clone Dotfiles Repository
* Create Symbolic Links To Dotfiles

## Installation - Optional

```
ansible-playbook setup.yaml --tags optional
```

## Feature - Optional

* Install Haskell Stack
* Setup Haskell
* Install Haskell Packages
	* ShellCheck
	* ghc-mod
	* hdevtools
	* hlint
