up-{{_input_:app_name}}: ## Start {{_input_:app_name}}.
	helm upgrade --install {{_input_:app_name}} {{_input_:chart_name_or_dir}} \
		-f values.yaml

down-{{_input_:app_name}}: ## Stop {{_input_:app_name}}.
	helm uninstall {{_input_:app_name}} || :

{{_cursor_}}
