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
GITLFSPATH    := $(HOME)/src/git-lfs
GITSTATUSPATH := $(HOME)/src/gitstatus

# Proxy settings
PROXY_TEMPLATE     := config/profile.d/proxy.sh.template
PROXY_SETTING      := config/profile.d/proxy.sh
GIT_PROXY_TEMPLATE := config/git/config.local.template
GIT_PROXY_SETTING  := config/git/config.local

define repo
	if [[ -d "$1" ]]; then \
		cd $1 && git pull; \
	else \
		git clone --depth 1 https://github.com/$2 "$1"; \
	fi
endef

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

update: update-dot update-plugin ## Update dotfiles

update-dot: ## update dotfiles repository
	git fetch
	git pull
	git submodule update --init --recursive

update-plugin: ## update neovim plugins
	git submodule foreach git pull origin master

deploy: ## Create symlink
	@mkdir -p $(HOME)/{.config,ghe,github}
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
	@$(foreach val, $(DOTFILES_XDG_CONFIG), ln -sfnv $(abspath config/$(val)) $(HOME)/.config/$(val);)

git: update-git build-git update-gitlfs build-gitlfs update-gitstatus ## Get latest git

update-git: ## Update git repository
	$(call repo,$(GITPATH),git/git)

build-git: ## Build git
	cd $(GITPATH) && \
	make clean && \
	make all && \
	make install

update-gitlfs: ## Update git-lfs repository
	$(call repo,$(GITLFSPATH),git-lfs/git-lfs)

build-gitlfs: ## Build git-lfs
	cd $(GITLFSPATH) && \
	make && \
	ln -sfnv $(GITLFSPATH)/bin/git-lfs $(HOME)/bin/git-lfs

update-gitstatus: ## Update gitstatus repository
	$(call repo,$(GITSTATUSPATH),romkatv/gitstatus)

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

vim: update-vim build-vim ## Get edge vim

update-vim: ## Update vim repository
	$(call repo,$(VIMPATH),vim/vim)

build-vim: ## Build vim
	cd $(VIMPATH) && \
	(make clean || :) && \
	./configure --with-features=huge --enable-python3interp --enable-luainterp --enable-fail-if-missing --with-luajit --prefix=$(HOME)/vim && \
	make && \
	make install

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[38;2;98;209;150m%-20s\033[0m %s\n", $$1, $$2}' \
		$(MAKEFILE_LIST)
