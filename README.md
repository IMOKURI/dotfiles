# dotfiles

[![Build Status](https://travis-ci.org/IMOKURI/dotfiles.svg?branch=master)](https://travis-ci.org/IMOKURI/dotfiles)

Deploy dotfiles using ansible.

## Requirement

* curl
* sudo

* Set environment variables if you need to use proxy.

```
export http_proxy=http://proxy.example.com:port
export https_proxy=http://proxy.example.com:port
```

* Enable optional repository. (RHEL Only)

```
subscription-manager repos --enable rhel-7-server-optional-rpms
```

## Installation

```
bash -c "$(curl -fsSL https://git.io/imokuri)"
```

## Feature

* Add Repository
* Install Packages
* Setup Rbenv
* Install Python2/3 Packages
* Install Ruby Packages
* Install Node.js Packages
* Set Alternative Commands
* Setup Python Virtualenv
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
