#######################################################################################################################
# {{_input_:repo_name}}/{{_input_:app_name}}
#######################################################################################################################
VERSION = {{_cursor_}}

.PHONY: add-helm-repo
add-helm-repo: ## add-helm-repo
	helm repo add {{_input_:repo_name}} {{_input_:repo_url}}
	helm repo update

.PHONY: show-version
show-version: ## Show chart version for {{_input_:app_name}}.
	helm search repo {{_input_:repo_name}}/{{_input_:app_name}}

.PHONY: save-values
save-values: ## Save default values for {{_input_:app_name}}.
	helm show values {{_input_:repo_name}}/{{_input_:app_name}} > values.yaml

.PHONY: up
up: ## Start {{_input_:app_name}}.
	helm upgrade --install {{_input_:app_name}} \
		{{_input_:repo_name}}/{{_input_:app_name}} \
		--namespace {{_input_:namespace}} \
		--create-namespace \
		--version $(VERSION) \
		-f values.yaml

.PHONY: down
down: ## Stop {{_input_:app_name}}.
	helm uninstall {{_input_:app_name}} --namespace {{_input_:namespace}} || :

