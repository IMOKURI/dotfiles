#######################################################################################################################
# {{_input_:project_name}}
#######################################################################################################################
PROJECT_NAME = {{_input_:project_name}}

build-{{_input_:project_name}}: ## Build {{_input_:project_name}}.
	docker compose build

pull-{{_input_:project_name}}: ## Pull {{_input_:project_name}}.
	docker compose pull

up-{{_input_:project_name}}: ## Start {{_input_:project_name}}.
	docker compose -p $(PROJECT_NAME) up -d

down-{{_input_:project_name}}: ## Stop {{_input_:project_name}}.
	docker compose -p $(PROJECT_NAME) down

ps-{{_input_:project_name}}: ## Status {{_input_:project_name}}.
	docker compose -p $(PROJECT_NAME) ps

log-{{_input_:project_name}}: ## Log {{_input_:project_name}}.
	docker compose -p $(PROJECT_NAME) logs -f

{{_cursor_}}
