IMAGE_NAME = hello-world
IMAGE_TAB = latest

up-{{_input_:container_name}}: ## Start {{_input_:container_name}}.
	docker run -d --name {{_input_:container_name}} -p 10080:8080 \
		--net app-net \
		--shm-size=64g \
		--gpus '"device=0,1,2,3,4,5,6,7"' \
		-v $(XDG_CACHE_HOME):/root/.cache \
		$(IMAGE_NAME):$(IMAGE_TAG)
{{_cursor_}}
