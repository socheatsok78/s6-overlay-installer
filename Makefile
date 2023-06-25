IMAGE_NAME=s6-overlay-installer

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run -it --rm $(IMAGE_NAME)

bash:
	docker run -it --rm $(IMAGE_NAME) bash
