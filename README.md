<div align="center">

# :computer: dotfiles

[![E2E Test](https://github.com/IMOKURI/dotfiles/actions/workflows/e2e_test.yml/badge.svg)](https://github.com/IMOKURI/dotfiles/actions/workflows/e2e_test.yml)

</div>

Dotfiles that can be installed by one command

## Features

- Clone dotfiles repository.
- Create symbolic links to dotfile.
- Install Neovim and development tools via Mise.

## Platforms

- Ubuntu 22.04, 24.04

## Requirements

- Packages

```bash
sudo apt install -y curl gcc git gnupg make tar
```

- Set environment variables if use proxy.

```bash
export http_proxy=<http://proxy.example.com:port>
export https_proxy=<http://proxy.example.com:port>
```

## Installation

```bash
bash -c "$(curl -fsSL https://git.io/imokuri)"
```
