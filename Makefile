all: docker-run

DOCKER_IMAGE_NAME=curveball-website

docker-build: Dockerfile
	docker build -t $(DOCKER_IMAGE_NAME) .

docker-run: docker-build
	docker run \
	  -p4000:4000 \
	  --volume="${PWD}:/opt/www/src" \
	  -it --rm --name $(DOCKER_IMAGE_NAME)-01 $(DOCKER_IMAGE_NAME)
