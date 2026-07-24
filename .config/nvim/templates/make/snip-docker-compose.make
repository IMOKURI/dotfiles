#######################################################################################################################
# {{_input_:project_name}}
#######################################################################################################################
PROJECT_NAME = {{_input_:project_name}}

.PHONY: build-{{_input_:project_name}}
build-{{_input_:project_name}}: ## Build {{_input_:project_name}}.
	docker compose build

.PHONY: pull-{{_input_:project_name}}
pull-{{_input_:project_name}}: ## Pull {{_input_:project_name}}.
	docker compose pull

.PHONY: up-{{_input_:project_name}}
up-{{_input_:project_name}}: ## Start {{_input_:project_name}}.
	docker compose -p $(PROJECT_NAME) up -d

.PHONY: down-{{_input_:project_name}}
down-{{_input_:project_name}}: ## Stop {{_input_:project_name}}.
	docker compose -p $(PROJECT_NAME) down

.PHONY: ps-{{_input_:project_name}}
ps-{{_input_:project_name}}: ## Status {{_input_:project_name}}.
	docker compose -p $(PROJECT_NAME) ps

.PHONY: log-{{_input_:project_name}}
log-{{_input_:project_name}}: ## Log {{_input_:project_name}}.
	docker compose -p $(PROJECT_NAME) logs -f

{{_cursor_}}
