# dotfiles

[![Build Status](https://travis-ci.org/IMOKURI/dotfiles.svg?branch=master)](https://travis-ci.org/IMOKURI/dotfiles)

## Feature

- Install/Build latest Git and Neovim, Vim.
- Install Python, Node.js, Go.
- Clone dotfiles repository.
- Create symbolic link to dotfiles.

## Support

- CentOS/RHEL 7
- Ubuntu (wo installer)

## Requirement

- Packages
  - curl
  - sudo

- Set environment variables if you need to use proxy.

```bash
export http_proxy=<http://proxy.example.com:port>
export https_proxy=<http://proxy.example.com:port>
```

- Enable optional and extra repository. (RHEL Only)

```bash
subscription-manager repos --enable rhel-7-server-optional-rpms
subscription-manager repos --enable rhel-7-server-extras-rpms
```

## Installation

```bash
bash -c "$(curl -fsSL https://git.io/imokuri)"
```

## Update

```bash
cd ~/.dotfiles

# dotfiles
make update

# git
make git

# neovim
make neovim

# vim
make vim
```

## Docker

```bash
# Build Environment
docker build --build-arg PROXY=<http://proxy.example.com:port> -t imokuri-base-image .
docker run -dt --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro --name imokuri-dev imokuri-base-image
docker exec -t imokuri-dev bash -c "$(curl -fsSL https://git.io/imokuri)"

# (Optional) Backup Environment
docker stop imokuri-dev
docker commit imokuri-dev imokuri-image
docker start imokuri-dev

# Let's Develop!
docker exec -it imokuri-dev /bin/bash

# Recreate Environment
docker run -it imokuri-image /bin/bash
```
