#######################################################################################################################
# {{_input_:app_name}}
#######################################################################################################################
VERSION = {{_cursor_}}

.PHONY: pull-chart
pull-chart: ## pull-chart
	helm pull {{_input_:chart_url}} \
		--version $(VERSION)

.PHONY: up
up: ## Start {{_input_:app_name}}.
	helm upgrade --install {{_input_:app_name}} \
		{{_input_:chart_url}} \
		--namespace {{_input_:namespace}} \
		--create-namespace \
		--version $(VERSION) \
		-f values.yaml

.PHONY: down
down: ## Stop {{_input_:app_name}}.
	helm uninstall {{_input_:app_name}} --namespace {{_input_:namespace}} || :

