#######################################################################################################################
# {{_input_:container_name}}
#######################################################################################################################
IMAGE_NAME = {{_input_:container_name}}
IMAGE_TAG = v0.0.1

build-{{_input_:container_name}}: ## Build {{_input_:container_name}}.
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) -f Dockerfile .

up-{{_input_:container_name}}: ## Start {{_input_:container_name}}.
	docker run -d --name {{_input_:container_name}} -p 10000:8000 \
		--shm-size=16g \
		--gpus '"device=0,1"' \
		-v $(XDG_CACHE_HOME):/root/.cache \
		$(IMAGE_NAME):$(IMAGE_TAG)

down-{{_input_:container_name}}: ## Stop {{_input_:container_name}}.
	docker stop {{_input_:container_name}} || :
	docker rm {{_input_:container_name}} || :

ps-{{_input_:container_name}}: ## Status {{_input_:container_name}}.
	docker ps -a -f name={{_input_:container_name}} || :

log-{{_input_:container_name}}: ## Log {{_input_:container_name}}.
	docker logs -f {{_input_:container_name}} || :

{{_cursor_}}
