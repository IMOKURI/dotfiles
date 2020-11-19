# dotfiles

[![CI](https://github.com/IMOKURI/dotfiles/workflows/CI/badge.svg)](https://github.com/IMOKURI/dotfiles/actions?query=workflow%3ACI)

The dotfiles that can be installed by one command

## Features

- Install Neovim, Git, Python3, Node.js and Go with some packages.
- Clone dotfiles repository.
- Create symbolic link to dotfiles.

## Targets

- Ubuntu 18.04, 20.04
- CentOS 7, 8
- RHEL 7, 8

## Requirements

- Packages
  - curl
  - sudo

- Set environment variables if use proxy.

```bash
export http_proxy=<http://proxy.example.com:port>
export https_proxy=<http://proxy.example.com:port>
```

- Enable optional and extra repositories. (for RHEL7)

```bash
sudo subscription-manager repos --enable rhel-7-server-optional-rpms
sudo subscription-manager repos --enable rhel-7-server-extras-rpms
```

- Enable code ready builder repository. (for RHEL8)

```bash
sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
```

## Installation

```bash
bash -c "$(curl -fsSL https://git.io/imokuri)"
```

## Update

```bash
bash ~/.dotfiles/install
```
