# dotfiles

[![Build Status](https://travis-ci.org/IMOKURI/dotfiles.svg?branch=master)](https://travis-ci.org/IMOKURI/dotfiles)

Deploy dotfiles.

## Requirement

* curl
* sudo

* Set environment variables if you need to use proxy.

```
export http_proxy=http://proxy.example.com:port
export https_proxy=http://proxy.example.com:port
```

* Enable optional and extra repository. (RHEL Only)

```
subscription-manager repos --enable rhel-7-server-optional-rpms
subscription-manager repos --enable rhel-7-server-extras-rpms
```

## Installation

```
bash -c "$(curl -fsSL https://git.io/imokuri)"
```

## Update

```
cd ~/.dotfiles && make update
```

## Feature

* Install Git, Neovim, Python, Node.js, etc...
* Clone Dotfiles Repository
* Create Symbolic Links To Dotfiles
