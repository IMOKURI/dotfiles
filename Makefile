.PHONY: all help test clean install proxy git neovim vim
.DEFAULT_GOAL := help

DOTFILES_EXCLUDES    := README.md LICENSE Makefile install config $(wildcard .??*)
DOTFILES_TARGET      := $(shell ls)
DOTFILES_FILES       := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))
DOTFILES_CONFIG      := $(shell ls config)

PROXY_TEMPLATE       := config/profile.d/proxy.sh.template
PROXY_SETTINGS       := config/profile.d/proxy.sh

GIT_PROXY_TEMPLATE   := config/git/config.local.template
GIT_PROXY_SETTINGS   := config/git/config.local

list: ## Show file/directory list for deployment
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(val);)
	@$(foreach val, $(DOTFILES_CONFIG), ls -dF config/$(val);)

install: proxy update pipenv deploy ## Do proxy, update, pipenv and deploy

proxy: ## Set proxy
ifdef http_proxy
ifeq ("$(wildcard $(PROXY_SETTINGS))","")
	@sed -e 's|write_proxy_here|$(http_proxy)|g' $(PROXY_TEMPLATE) > $(PROXY_SETTINGS)
endif
ifeq ("$(wildcard $(GIT_PROXY_SETTINGS))","")
	@sed -e 's|write_proxy_here|$(http_proxy)|g' $(GIT_PROXY_TEMPLATE) > $(GIT_PROXY_SETTINGS)
endif
endif

update: ## Update repository
	git fetch
	git pull

pipenv: ## Setup pipenv
	mkdir -p $(HOME)/.local/share/provider.nvim
	cd $(HOME)/.local/share/provider.nvim/ && \
	PIPENV_VENV_IN_PROJECT=true pipenv install pynvim

deploy: ## Create symlink
	@mkdir -p $(HOME)/{.config,ghe,github}
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
	@$(foreach val, $(DOTFILES_CONFIG), ln -sfnv $(abspath config/$(val)) $(HOME)/.config/$(val);)
	@ln -sfnv $(abspath config/nvim/init.vim) $(HOME)/.vimrc

git: update-git build-git ## Get latest git

update-git: ## Update git repository
	cd $(HOME)/src/git && \
	git fetch

build-git: ## Build git
	cd $(HOME)/src/git && \
	make clean && \
	git checkout $$(git describe --abbrev=0) && \
	make all && \
	make install

neovim: update-neovim build-neovim ## Get latest neovim

update-neovim: ## Update neovim repository
	cd $(HOME)/src/neovim && \
	git pull

build-neovim: ## Build neovim
	cd $(HOME)/src/neovim && \
	rm -fr .deps build/ && \
	make distclean && \
	make clean && \
	make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$(HOME)/neovim" && \
	make install

vim: update-vim build-vim ## Get latest vim

update-vim: ## Update vim repository
	cd $(HOME)/src/vim && \
	git pull

build-vim: ## Build vim
	cd $(HOME)/src/vim/src && \
	(make clean || :) && \
	./configure --with-features=huge --enable-python3interp --enable-luainterp --enable-fail-if-missing --with-luajit --prefix=$(HOME)/vim && \
	make && \
	make install

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[38;2;98;209;150m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
