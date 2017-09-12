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

* Add Repository
* Install Packages
* Install Python2/3 Packages
* Install Ruby Packages
* Install Node.js Packages
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
