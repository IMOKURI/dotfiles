IMAGE_NAME = hello-world
IMAGE_TAB = latest

build-{{_input_:container_name}}: ## Build {{_input_:container_name}}.
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) -f Dockerfile .
{{_cursor_}}

