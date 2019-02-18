.PHONY: help
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

install: proxy pipenv command update deploy ## Do proxy, pipenv, command, update and deploy

proxy: ## Set proxy
ifdef http_proxy
ifeq ("$(wildcard $(PROXY_SETTINGS))","")
	@sed -e 's|write_proxy_here|$(http_proxy)|g' $(PROXY_TEMPLATE) > $(PROXY_SETTINGS)
endif
ifeq ("$(wildcard $(GIT_PROXY_SETTINGS))","")
	@sed -e 's|write_proxy_here|$(http_proxy)|g' $(GIT_PROXY_TEMPLATE) > $(GIT_PROXY_SETTINGS)
endif
endif

pipenv: ## Setup pipenv
	cd config/nvim/ && \
	PIPENV_VENV_IN_PROJECT=true pipenv install

command: ## Set command alias
	alternatives --install /usr/local/bin/vi vi $(HOME)/neovim/bin/nvim 100

update: ## Pull repo
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

deploy: ## Create symlink
	@mkdir -p $(HOME)/{.config,ghe,github}
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
	@$(foreach val, $(DOTFILES_CONFIG), ln -sfnv $(abspath config/$(val)) $(HOME)/.config/$(val);)

update-neovim: ## Update neovim
	cd $(HOME)/src/neovim && \
	git pull

build-neovim: ## Build neovim
	cd $(HOME)/src/neovim && \
	rm -fr build/ && \
	make clean && \
	make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$(HOME)/neovim" && \
	make install

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[38;2;98;209;150m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
