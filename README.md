# dotfiles

[![Build Status](https://travis-ci.org/IMOKURI/dotfiles.svg?branch=master)](https://travis-ci.org/IMOKURI/dotfiles)

## Feature

- Install/Build edge Neovim and Vim.
- Install/Build latest Git.
- Install Python3, Node.js and Go with some packages.
- Clone dotfiles repository.
- Create symbolic link to dotfiles.

## Support

- CentOS/RHEL 7
- Ubuntu (no installer)

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
# Let's Develop!
docker pull imokuri123/imokuri-dev
docker run -dt --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro --name dev imokuri123/imokuri-dev
docker exec -it dev /bin/bash --login

# (Optional) Backup Environment as Image
docker stop dev
docker commit dev dev-image
docker start dev
```
