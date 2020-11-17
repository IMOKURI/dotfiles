# dotfiles

[![CI](https://github.com/IMOKURI/dotfiles/workflows/CI/badge.svg)](https://github.com/IMOKURI/dotfiles/actions?query=workflow%3ACI)

The dotfiles that can be installed by one command

## Feature

- Install Neovim, Git, Python3, Node.js and Go with some packages.
- Clone dotfiles repository.
- Create symbolic link to dotfiles.

## Support

- CentOS/RHEL 7
- Ubuntu 18.04, 20.04

> CentOS/RHEL 8 is under testing.

## Requirement

- Packages
  - curl
  - sudo
  - software-properties-common (for Ubuntu)

- Set environment variables if use proxy.

```bash
export http_proxy=<http://proxy.example.com:port>
export https_proxy=<http://proxy.example.com:port>
```

- Enable optional and extra repositories. (for RHEL)

```bash
sudo subscription-manager repos --enable rhel-7-server-optional-rpms
sudo subscription-manager repos --enable rhel-7-server-extras-rpms
```

- Enable additional repositories. (for CentOS 8, may also need RHEL 8)

```bash
sudo dnf config-manager --enable PowerTools
```

## Installation

```bash
bash -c "$(curl -fsSL https://git.io/imokuri)"
```

## Update

```bash
bash ~/.dotfiles/install
```
