show-version-{{_input_:app_name}}: ## Show chart version for {{_input_:app_name}}.
	helm search repo {{_input_:chart_name_or_dir}}

save-values-{{_input_:app_name}}: ## Save default values for {{_input_:app_name}}.
	helm show values {{_input_:chart_name_or_dir}} > values.yaml

up-{{_input_:app_name}}: ## Start {{_input_:app_name}}.
	helm upgrade --install {{_input_:app_name}} {{_input_:chart_name_or_dir}} \
		-f values.yaml

down-{{_input_:app_name}}: ## Stop {{_input_:app_name}}.
	helm uninstall {{_input_:app_name}} || :

{{_cursor_}}
