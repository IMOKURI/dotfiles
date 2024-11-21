.PHONY: install
.DEFAULT_GOAL := help

SHELL := /bin/bash

# List up dotfiles
DOTFILES_EXCLUDES   := README.md LICENSE Makefile config install $(wildcard .??*)
DOTFILES_TARGET     := $(shell ls)
DOTFILES_FILES      := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))
DOTFILES_XDG_CONFIG := $(shell ls config)

# Define path
DOTPATH    := $(HOME)/.dotfiles
NEOVIMPATH := $(HOME)/src/neovim
BASHMARKS  := $(HOME)/src/bashmarks
CAT_BAT    := $(HOME)/src/cat-bat

# Proxy settings
PROXY_TEMPLATE     := $(DOTPATH)/config/profile.d/proxy.sh.template
PROXY_SETTING      := $(DOTPATH)/config/profile.d/proxy.sh
GIT_PROXY_TEMPLATE := $(DOTPATH)/config/git/config.proxy.template
GIT_PROXY_SETTING  := $(DOTPATH)/config/git/config.proxy

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

install: proxy update deploy ## Do proxy, update and deploy

proxy: ## Set proxy
ifdef http_proxy
	sed -e 's|write_proxy_here|$(http_proxy)|g' $(PROXY_TEMPLATE) > $(PROXY_SETTING)
	sed -e 's|write_proxy_here|$(http_proxy)|g' $(GIT_PROXY_TEMPLATE) > $(GIT_PROXY_SETTING)

	source $(PROXY_SETTING)
endif

update: update-dot update-plugin ## Update dotfiles

update-dot: ## update dotfiles repository
	git fetch
	git pull

update-plugin: ## update neovim plugins
	:
	# nvim --headless +qa
	# nvim --headless "+Lazy! sync" +qa

deploy: ## Create symlink
	@mkdir -p $(HOME)/{.config,ghe,github,work}
	@mkdir -p $(HOME)/ghe/{hpe,yoshio-sugiyama}
	@mkdir -p $(HOME)/github/{,IMOKURI}
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
	@$(foreach val, $(DOTFILES_XDG_CONFIG), ln -sfnv $(abspath config/$(val)) $(HOME)/.config/$(val);)

neovim: update-neovim build-neovim ## Get edge neovim

update-neovim: ## Update neovim repository
	$(call repo,$(NEOVIMPATH),neovim/neovim)

build-neovim: ## Build neovim
	cd $(NEOVIMPATH) && \
	rm -fr .deps build/ && \
	make distclean && \
	make clean && \
	make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$(HOME)/neovim" && \
	make install

bashmarks: update-bashmarks build-bashmarks ## Get Bashmarks

update-bashmarks: ## Update bashmarks repository
	$(call repo,$(BASHMARKS),huyng/bashmarks)

build-bashmarks: ## Build bashmarks
	cd $(BASHMARKS) && \
	make install && \
	sed -i 's/^alias l=/# &/' $(HOME)/.bashrc

bat-theme: update-bat-theme build-bat-theme ## Get bat theme

update-bat-theme: ## Update bat theme repository
	$(call repo,$(CAT_BAT),catppuccin/bat)

build-bat-theme: ## Build bat theme
	cd $(CAT_BAT) && \
	mkdir -p "$(shell batcat --config-dir)/themes" && \
	cp -f themes/*.tmTheme "$(shell batcat --config-dir)/themes" && \
	batcat cache --build

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[38;2;98;209;150m%-20s\033[0m %s\n", $$1, $$2}' \
		$(MAKEFILE_LIST)
