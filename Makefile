DOTFILES_EXCLUDES := README.md LICENSE Makefile $(wildcard .??*) $(wildcard cabal.*)
DOTFILES_TARGET   := $(shell ls)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

all: install

install: update init deploy

help:
	@echo "make list           #=> Show file list for deployment"
	@echo "make update         #=> Fetch changes for this repo"
	@echo "make init           #=> Setup environment settings"
	@echo "make deploy         #=> Create symlink to home directory"
	@echo "make install        #=> Run make update, init, deploy"

list:
	@if [ -d ".cabal-sandbox/bin" ]; then ls -dF .cabal-sandbox/bin/ghc-mod*; fi
	@$(foreach val, $(DOTFILES_FILES), ls -dF $(abspath $(val));)

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

init:
	cabal update
	cabal sandbox init
	cabal install ghc-mod

deploy:
	@if [ ! -e "~/.local/bin" ]; then mkdir -p ~/.local/bin; fi
	@if [ -f ".cabal-sandbox/bin/ghc-mod" ] && [ -f ".cabal-sandbox/bin/ghc-modi" ]; then \
		ln -sfnv `pwd`/.cabal-sandbox/bin/ghc-mod ~/.local/bin/ghc-mod; \
		ln -sfnv `pwd`/.cabal-sandbox/bin/ghc-modi ~/.local/bin/ghc-modi; \
	 fi
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/.$(val);)

