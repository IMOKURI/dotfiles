<div align="center">

# :computer: dotfiles

[![E2E Test](https://github.com/IMOKURI/dotfiles/actions/workflows/e2e_test.yml/badge.svg)](https://github.com/IMOKURI/dotfiles/actions/workflows/e2e_test.yml)

</div>

Dotfiles that can be installed by one command

## Features

- Clone dotfiles repository.
- Create symbolic links to dotfile.
- Install Neovim and development tools.

## Platforms

- Ubuntu 24.04
- Ubuntu 26.04

## Requirements

```bash
sudo apt install -y curl
```

Create a GitHub token without any scope from [here](https://github.com/settings/tokens).

```bash
export MISE_GITHUB_TOKEN="<your_github_token>"
```

## Installation

```bash
bash -c "$(curl -fsSL https://git.io/imokuri)"
```

## Testing

<details>
<summary>Test in Docker</summary>

```bash
docker run -it --rm ubuntu bash

apt update
apt install curl -y

export MISE_GITHUB_TOKEN="<your_github_token>"
export BRANCH="<branch_name>"

curl -fsSL https://raw.githubusercontent.com/IMOKURI/dotfiles/refs/heads/${BRANCH}/install | bash
```

</details>
