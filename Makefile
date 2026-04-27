.PHONY: install
.DEFAULT_GOAL := help

SHELL := /bin/bash

# Define banner style
COL := 120
BANNER := \033[38;2;101;178;255m
CLEAR_COLOR := \033[0m

# List up dotfiles
DOTFILES_EXCLUDES   := README.md LICENSE Makefile bin config install $(wildcard .??*)
DOTFILES_TARGET     := $(shell ls)
DOTFILES_FILES      := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))
DOTFILES_XDG_CONFIG := $(shell ls config)

# Define path
DOTPATH   := $(HOME)/.dotfiles
BASHMARKS := $(HOME)/src/bashmarks
CAT_BAT   := $(HOME)/src/cat-bat

# Proxy settings
PROXY_TEMPLATE     := $(DOTPATH)/config/profile.d/proxy.sh.template
PROXY_SETTING      := $(DOTPATH)/config/profile.d/proxy.sh
GIT_PROXY_TEMPLATE := $(DOTPATH)/config/git/config.proxy.template
GIT_PROXY_SETTING  := $(DOTPATH)/config/git/config.proxy

define banner
	@sep="$$(for ((i = 1; i < $(COL); i++)); do printf '='; done)"; \
	printf "\n$(BANNER)%s %s$(CLEAR_COLOR)\n\n" "$(1)" "$${sep:$${#1}}"
endef

define repo
	if [[ -d "$1" ]]; then \
		cd $1 && git pull && git submodule update --init --recursive; \
	else \
		git clone --depth 1 --recursive https://github.com/$2 "$1"; \
	fi
endef

list: ## Show file/directory list for deployment
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(val);)
	@$(foreach val, $(DOTFILES_XDG_CONFIG), ls -dF config/$(val);)

install: proxy deploy shell-setup mise bashmarks bat-theme ## Do installation process

proxy: ## Set proxy
	$(call banner,Set proxy...)
ifdef http_proxy
	sed -e 's|write_proxy_here|$(http_proxy)|g' $(PROXY_TEMPLATE) > $(PROXY_SETTING)
	sed -e 's|write_proxy_here|$(http_proxy)|g' $(GIT_PROXY_TEMPLATE) > $(GIT_PROXY_SETTING)

	source $(PROXY_SETTING)
endif

deploy: ## Create symlink
	$(call banner,Create symlinks...)
	@mkdir -p ${HOME}/.local/bin
	@mkdir -p $(HOME)/{bin,.config,ghe,github,github_hpeprod,work,docker,namespace}
	@mkdir -p $(HOME)/ghe/{hpe,yoshio-sugiyama}
	@mkdir -p $(HOME)/github/{HPE-TA,IMOKURI,others}
	@mkdir -p $(HOME)/github_hpeprod/yoshio-sugiyama_hpeprod
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
	@$(foreach val, $(DOTFILES_XDG_CONFIG), ln -sfnv $(abspath config/$(val)) $(HOME)/.config/$(val);)

shell-setup: ## Add shell and SSH bootstrap settings
	$(call banner,Setup shell and SSH bootstrap settings...)
	@if ! grep -q '.config/bashrc' "${HOME}/.bashrc"; then \
		echo -e "\nif [[ -f ~/.config/bashrc ]]; then\n  . ~/.config/bashrc\nfi" >>"${HOME}/.bashrc"; \
	fi
	@if ! grep -q '.config/profile.d/local.sh' "${HOME}/.profile"; then \
		echo -e "\nif [[ -f ~/.config/profile.d/local.sh ]]; then\n  . ~/.config/profile.d/local.sh\nfi" >>"${HOME}/.profile"; \
	fi
	@mkdir -p -m 700 ~/.ssh
	@if ! grep -q 'Include ~/.config/ssh/' "${HOME}/.ssh/config"; then \
		echo -e "\nInclude ~/.config/ssh/*.conf" >>"${HOME}/.ssh/config"; \
	fi

mise: ## Get Mise
	$(call banner,Setup Mise...)
	if [[ -f $(HOME)/.local/bin/mise ]]; then \
		mise self-update -y; \
		mise upgrade; \
		mise prune -y; \
	else \
		curl https://mise.run | sh; \
		mise install; \
	fi

bashmarks: update-bashmarks build-bashmarks ## Get Bashmarks
	$(call banner,Setup Bashmarks...)

update-bashmarks: ## Update Bashmarks repository
	$(call repo,$(BASHMARKS),huyng/bashmarks)

build-bashmarks: ## Build Bashmarks
	cd $(BASHMARKS) && \
	make install && \
	sed -i 's/^alias l=/# &/' $(HOME)/.bashrc

bat-theme: update-bat-theme build-bat-theme ## Get Bat theme
	$(call banner,Setup Bat theme...)

update-bat-theme: ## Update Bat theme repository
	$(call repo,$(CAT_BAT),catppuccin/bat)

build-bat-theme: ## Build Bat theme
	cd $(CAT_BAT) && \
	mkdir -p "$(shell bat --config-dir)/themes" && \
	cp -f themes/*.tmTheme "$(shell bat --config-dir)/themes" && \
	bat cache --build

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[38;2;98;209;150m%-20s\033[0m %s\n", $$1, $$2}' \
		$(MAKEFILE_LIST)
