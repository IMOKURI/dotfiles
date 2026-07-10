SHELL := /bin/bash
.DEFAULT_GOAL := help

.PHONY: mise
mise: ## Bootstrap
	@if [[ -f $(HOME)/.local/bin/mise ]]; then \
		mise self-update --yes; \
		mise upgrade; \
		mise prune --yes; \
	else \
		mkdir -p $(HOME)/.config; \
		ln -sfnv $(abspath config/mise) $(HOME)/.config/mise; \
		curl https://mise.run | sh; \
		mise bootstrap --yes; \
	fi

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[38;2;98;209;150m%-20s\033[0m %s\n", $$1, $$2}' \
		$(MAKEFILE_LIST)
