
IMAGE = ghcr.io/xonvanetta/transmission-port-forward-gluetun-server

build:
	docker build . -t ${IMAGE}:${TAG}

run:
	docker run --rm -it ${IMAGE}:${TAG}

push: build
	docker push $(IMAGE):$(TAG)