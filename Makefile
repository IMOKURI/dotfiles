.PHONY: install
.DEFAULT_GOAL := help

SHELL := /bin/bash

# Define banner style
COL := 120
BANNER := \033[38;2;101;178;255m
CLEAR_COLOR := \033[0m

# Define path
DOTPATH   := $(HOME)/.dotfiles
BASHMARKS := $(HOME)/src/bashmarks
CAT_BAT   := $(HOME)/src/cat-bat

define banner
	@sep="$$(for ((i = 1; i < $(COL); i++)); do printf '='; done)"; \
	printf "\n$(BANNER)%s %s$(CLEAR_COLOR)\n\n" "$(1)" "$${sep:$${#1}}"
endef

list: ## List all dotfiles
	@mise dotfiles status

install: link shell-setup mise bashmarks bat-theme ## Do installation process

link: ## Create symlink
	$(call banner,Create symlinks...)
	@mkdir -p $(HOME)/.config
	@ln -sfnv $(abspath config/mise) $(HOME)/.config/mise

shell-setup: ## Setup shell and SSH settings
	$(call banner,Setup shell and SSH settings...)
	@if ! grep -q '.config/bashrc' "$(HOME)/.bashrc"; then \
		echo -e "\nif [[ -f ~/.config/bashrc ]]; then\n  . ~/.config/bashrc\nfi" >>"$(HOME)/.bashrc"; \
	fi
	@if ! grep -q 'export MISE_GITHUB_TOKEN=' "$(HOME)/.bashrc"; then \
		echo 'export MISE_GITHUB_TOKEN="$(MISE_GITHUB_TOKEN)"' >> "$(HOME)/.bashrc"; \
	fi
	@mkdir -p -m 700 ~/.ssh
	@touch ~/.ssh/config
	@if ! grep -q 'Include ~/.config/ssh/' "$(HOME)/.ssh/config"; then \
		echo -e "\nInclude ~/.config/ssh/*.conf" >>"$(HOME)/.ssh/config"; \
	fi

mise: ## Setup Mise
	$(call banner,Setup Mise...)
	@if [[ -f $(HOME)/.local/bin/mise ]]; then \
		mise self-update --yes; \
		mise upgrade; \
		mise prune --yes; \
	else \
		curl https://mise.run | sh; \
		mise bootstrap --yes; \
	fi

bashmarks: ## Setup Bashmarks
	$(call banner,Setup Bashmarks...)
	@cd $(BASHMARKS) && \
	make install && \
	sed -i 's/^alias l=/# &/' $(HOME)/.bashrc

bat-theme: ## Setup Bat theme
	$(call banner,Setup Bat theme...)
	@cd $(CAT_BAT) && \
	mkdir -p "$(shell bat --config-dir)/themes" && \
	cp -f themes/*.tmTheme "$(shell bat --config-dir)/themes" && \
	bat cache --build

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[38;2;98;209;150m%-20s\033[0m %s\n", $$1, $$2}' \
		$(MAKEFILE_LIST)
