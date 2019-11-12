# dotfiles

[![Build Status](https://travis-ci.org/IMOKURI/dotfiles.svg?branch=master)](https://travis-ci.org/IMOKURI/dotfiles)

The dotfiles can be installed by one command for CentOS/RHEL 7.

And, the dotfiles pre-installed docker container is also [available](https://hub.docker.com/repository/docker/imokuri123/imokuri-dev)!

## Feature

- Build edge Neovim and Vim.
- Build latest Git.
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

# all packages
BUILD=all ./install

# dotfiles
make update

# git
make git

# neovim
make neovim

# vim
make vim
```

or set cron as follows.

```bash
SHELL=/bin/bash
BUILD=all

1 4 * * * ~/.dotfiles/install &> ~/.dotfiles_install.log
```

## Docker

```bash
# Let's Develop!
docker pull imokuri123/imokuri-dev
docker run -dt --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro --name dev imokuri123/imokuri-dev
docker exec -it dev /bin/bash --login

# (Optional) Backup Environment as Image.
docker stop dev
docker commit dev dev-image
docker start dev

# (Optional) Use Proxy.
# Execute following commands inside container.
export http_proxy=http://<proxy address>:<proxy port>/
cdd  # alias of cd ~/.dotfiles
make proxy
```
