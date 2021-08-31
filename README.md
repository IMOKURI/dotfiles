# dotfiles

[![E2E Test](https://github.com/IMOKURI/dotfiles/actions/workflows/blank.yml/badge.svg)](https://github.com/IMOKURI/dotfiles/actions/workflows/blank.yml)

The dotfiles that can be installed by one command

## Features

- Install Neovim, Git, Python3, Node.js and Go with some packages.
- Clone dotfiles repository.
- Create symbolic link to dotfiles.

## Targets

- Ubuntu 20.04
- CentOS 8
- RHEL 8

## Requirements

- Packages
  - curl
  - sudo

- Set environment variables if use proxy.

```bash
export http_proxy=<http://proxy.example.com:port>
export https_proxy=<http://proxy.example.com:port>
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
