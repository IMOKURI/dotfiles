.PHONY: all help test clean install proxy git neovim vim
.DEFAULT_GOAL := help

SHELL := /bin/bash

# List up dotfiles
DOTFILES_EXCLUDES   := README.md LICENSE Makefile config install $(wildcard .??*)
DOTFILES_TARGET     := $(shell ls)
DOTFILES_FILES      := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))
DOTFILES_XDG_CONFIG := $(shell ls config)

# Define path
VIMPATH       := $(HOME)/src/vim
NEOVIMPATH    := $(HOME)/src/neovim
GITPATH       := $(HOME)/src/git
GITSTATUSPATH := $(HOME)/src/gitstatus

# Proxy settings
PROXY_TEMPLATE     := config/profile.d/proxy.sh.template
PROXY_SETTING      := config/profile.d/proxy.sh
GIT_PROXY_TEMPLATE := config/git/config.local.template
GIT_PROXY_SETTING  := config/git/config.local

list: ## Show file/directory list for deployment
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(val);)
	@$(foreach val, $(DOTFILES_XDG_CONFIG), ls -dF config/$(val);)

install: proxy update deploy ## Do proxy, update and deploy

proxy: ## Set proxy
ifdef http_proxy
	if grep -q proxy /etc/yum.conf; then \
		sudo sed -i 's|proxy=.*|proxy=$(http_proxy)|g' /etc/yum.conf; \
	else \
		echo "proxy=$(http_proxy)" | sudo tee -a /etc/yum.conf; \
	fi

	sed -e 's|write_proxy_here|$(http_proxy)|g' $(PROXY_TEMPLATE) > $(PROXY_SETTING)
	sed -e 's|write_proxy_here|$(http_proxy)|g' $(GIT_PROXY_TEMPLATE) > $(GIT_PROXY_SETTING)

	source $(PROXY_SETTING)
endif

update: update-repo update-plugin ## Update dotfiles

update-repo: ## update dotfiles repository
	git fetch
	git pull
	git submodule update --init --recursive

update-plugin: ## update neovim plugins
	git submodule foreach git pull origin master

deploy: ## Create symlink
	@mkdir -p $(HOME)/{.config,ghe,github}
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
	@$(foreach val, $(DOTFILES_XDG_CONFIG), ln -sfnv $(abspath config/$(val)) $(HOME)/.config/$(val);)

git: update-git build-git update-gitstatus ## Get latest git

update-git: ## Update git repository
	if [[ -d "$(GITPATH)" ]]; then \
		cd $(GITPATH) && git pull --depth 1; \
	else \
		git clone --depth 1 https://github.com/git/git.git "$(GITPATH)"; \
	fi

build-git: ## Build git
	cd $(GITPATH) && \
	make clean && \
	make all && \
	make install

update-gitstatus: ## Update gitstatus repository
	if [[ -d "$(GITSTATUSPATH)" ]]; then \
		cd $(GITSTATUSPATH) && git pull --depth 1; \
	else \
		git clone --depth 1 https://github.com/romkatv/gitstatus.git "$(GITSTATUSPATH)"; \
	fi

neovim: update-neovim build-neovim ## Get edge neovim

update-neovim: ## Update neovim repository
	if [[ -d "$(NEOVIMPATH)" ]]; then \
		cd $(NEOVIMPATH) && git pull --depth 1; \
	else \
		git clone --depth 1 https://github.com/neovim/neovim.git "$(NEOVIMPATH)"; \
	fi

build-neovim: ## Build neovim
	cd $(NEOVIMPATH) && \
	rm -fr .deps build/ && \
	make distclean && \
	make clean && \
	make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$(HOME)/neovim" && \
	make install

vim: update-vim build-vim ## Get edge vim

update-vim: ## Update vim repository
	if [[ -d "$(VIMPATH)" ]]; then \
		cd $(VIMPATH) && git pull --depth 1; \
	else \
		git clone --depth 1 https://github.com/vim/vim.git "$(VIMPATH)"; \
	fi

build-vim: ## Build vim
	cd $(VIMPATH) && \
	(make clean || :) && \
	./configure --with-features=huge --enable-python3interp --enable-luainterp --enable-fail-if-missing --with-luajit --prefix=$(HOME)/vim && \
	make && \
	make install

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[38;2;98;209;150m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
