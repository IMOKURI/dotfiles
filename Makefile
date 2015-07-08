DOTFILES_EXCLUDES := README.md LICENSE Makefile $(wildcard .??*) $(wildcard cabal.*)
DOTFILES_TARGET   := $(shell ls)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

all: install

install: update deploy init

help:
	@echo "make list           #=> Show file list for deployment"
	@echo "make update         #=> Fetch changes for this repo"
	@echo "make deploy         #=> Create symlink to home directory"
	@echo "make init           #=> Setup environment settings"
	@echo "make install        #=> Run make update, deploy, init"

list:
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(val);)

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

deploy:
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)
	@if [ -d ".cabal-sandbox/bin/" ]; then ln -sfnv `pwd`/.cabal-sandbox/bin ~/.local/bin; fi

init:
	cabal update
	cabal sandbox init
	cabal install ghc-mod
	ln -sfnv `pwd`/.cabal-sandbox/bin ~/.local/bin

