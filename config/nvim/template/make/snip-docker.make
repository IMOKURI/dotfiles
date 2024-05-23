
IMAGE_NAME = {{_input_:container_name}}
IMAGE_TAG = v0.0.1

build-{{_input_:container_name}}: ## Build {{_input_:container_name}}.
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) -f Dockerfile .

up-{{_input_:container_name}}: ## Start {{_input_:container_name}}.
	docker run -d --name {{_input_:container_name}} -p 10080:8080 \
		--net app-net \
		--shm-size=64g \
		--gpus '"device=0,1,2,3,4,5,6,7"' \
		-v $(XDG_CACHE_HOME):/root/.cache \
		$(IMAGE_NAME):$(IMAGE_TAG)

down-{{_input_:container_name}}: ## Stop {{_input_:container_name}}.
	docker stop {{_input_:container_name}} || :
	docker rm {{_input_:container_name}} || :

{{_cursor_}}
