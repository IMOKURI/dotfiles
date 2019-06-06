# dotfiles

[![Build Status](https://travis-ci.org/IMOKURI/dotfiles.svg?branch=master)](https://travis-ci.org/IMOKURI/dotfiles)

## Support

-   CentOS/RHEL 7

## Requirement

-   Packages
    -   curl
    -   sudo

-   Set environment variables if you need to use proxy.

```
export http_proxy=<http://proxy.example.com:port>
export https_proxy=<http://proxy.example.com:port>
```

-   Enable optional and extra repository. (RHEL Only)

```
subscription-manager repos --enable rhel-7-server-optional-rpms
subscription-manager repos --enable rhel-7-server-extras-rpms
```

## Installation

```
bash -c "$(curl -fsSL https://git.io/imokuri)"
```

## Update

-   dotfiles

```
cd ~/.dotfiles && make update
```

-   git

```
cd ~/.dotfiles && make git
```

-   neovim

```
cd ~/.dotfiles && make neovim
```

## Feature

-   Install/Build latest Git and Neovim.
-   Install Python, Node.js.
-   Clone dotfiles repository.
-   Create symbolic link to dotfiles.
