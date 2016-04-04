.PHONY: help
.DEFAULT_GOAL := help

DOTFILES_EXCLUDES    := README.md LICENSE Makefile install $(wildcard .??*)
DOTFILES_TARGET      := $(shell ls)
DOTFILES_FILES       := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

list: ## Show file list for deployment
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(val);)

install: update haskell-setup deploy ## Run make update, haskell-setup, deploy

update: ## Pull changes for this repo
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

haskell-setup: ## Setup Haskell packages
	stack setup
	stack install ghc-mod hlint stylish-haskell hoogle
	hoogle data

deploy: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
	chmod 700 ~/.ghc
	chmod 600 ~/.ghc/ghci.conf

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[32m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
