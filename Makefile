.PHONY: help
.DEFAULT_GOAL := help

DOTFILES_EXCLUDES    := README.md LICENSE Makefile install $(wildcard .??*)
DOTFILES_TARGET      := $(shell ls)
DOTFILES_FILES       := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))
DOTFILES_FILES_LSB   := config gitconfig inputrc

list: ## Show file list for deployment
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(val);)

install: update deploy ## Run make update, deploy

update: ## Pull changes for this repo
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

deploy: ## Create symlink to home directory
ifneq ("$(wildcard /etc/redhat-release)","")
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
else ifneq ("$(wildcard /etc/lsb-release)","")
	@$(foreach val, $(DOTFILES_FILES_LSB), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
else
	@echo "Unsupported OS..."
endif

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[32m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
