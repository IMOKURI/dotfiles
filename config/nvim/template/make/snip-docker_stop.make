down-{{_input_:container_name}}: ## Stop {{_input_:container_name}}.
    docker stop {{_input_:container_name}} || :
    docker rm {{_input_:container_name}} || :
