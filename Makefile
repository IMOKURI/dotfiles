SHELL := /bin/bash
.DEFAULT_GOAL := help

.PHONY: update
update: ## Bootstrap
	mise self-update --yes
	mise upgrade
	mise prune --yes

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[38;2;98;209;150m%-20s\033[0m %s\n", $$1, $$2}' \
		$(MAKEFILE_LIST)
