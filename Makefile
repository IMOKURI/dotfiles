.PHONY: help
.DEFAULT_GOAL := help

DOTFILES_EXCLUDES    := README.md LICENSE Makefile install config $(wildcard .??*)
DOTFILES_TARGET      := $(shell ls)
DOTFILES_FILES       := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))
DOTFILES_CONFIG      := $(shell ls config)

list: ## Show file list for deployment
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(val);)
	@$(foreach val, $(DOTFILES_CONFIG), ls -dF config/$(val);)

install: update deploy ## Run make update, deploy

update: ## Pull changes for this repo
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

deploy: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
	@$(foreach val, $(DOTFILES_CONFIG), ln -sfnv $(abspath config/$(val)) $(HOME)/.config/$(val);)

haskell: ## Install haskell packages
	stack setup
	stack install shellcheck ghc-mod hdevtools hlint

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[32m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
