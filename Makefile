DOTFILES_EXCLUDES    := README.md LICENSE Makefile $(wildcard .??*)
DOTFILES_TARGET      := $(shell ls)
DOTFILES_FILES       := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

all: install

install: update haskell-setup deploy

help:
	@echo "make list           #=> Show file list for deployment"
	@echo "make update         #=> Fetch changes for this repo"
	@echo "make haskell-setup  #=> Setup Haskell packages"
	@echo "make deploy         #=> Create symlink to home directory"
	@echo "make install        #=> Run make update, haskell-setup, deploy"

list:
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(val);)

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

haskell-setup:
	stack install ghc-mod

deploy:
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

