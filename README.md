# dotfiles

[![E2E Test](https://github.com/IMOKURI/dotfiles/actions/workflows/e2e_test.yml/badge.svg)](https://github.com/IMOKURI/dotfiles/actions/workflows/e2e_test.yml)

The dotfiles that can be installed by one command

## Features

- Build latest neovim.
- Install Python, Node.js and Go with some packages.
- Clone dotfiles repository.
- Create symbolic link to dotfiles.

## Targets

- Ubuntu 20.04, 22.04

## Requirements

- Packages
  - curl
  - sudo

- Set environment variables if use proxy.

```bash
export http_proxy=<http://proxy.example.com:port>
export https_proxy=<http://proxy.example.com:port>
```

## Installation

```bash
bash -c "$(curl -fsSL https://git.io/imokuri)"
```

## Update

```bash
bash ~/.dotfiles/install
```
