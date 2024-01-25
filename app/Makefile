COMMIT_ID:=$(shell git rev-parse --short HEAD)
DOCKER_IMAGE:=luisbelloch/kitchen
GCLOUD_IMAGE:=eu.gcr.io/bigdataupv2022/$(DOCKER_IMAGE)

.PHONY: build
build:
	docker build -t $(DOCKER_IMAGE):$(COMMIT_ID) .
	docker tag $(DOCKER_IMAGE):$(COMMIT_ID) $(GCLOUD_IMAGE):$(COMMIT_ID)
	docker tag $(DOCKER_IMAGE):$(COMMIT_ID) $(GCLOUD_IMAGE)

.PHONY: login
login:
	docker login -u oauth2accesstoken -p "$(shell gcloud auth print-access-token)" https://eu.gcr.io

.PHONY: push
push: build
	docker push $(GCLOUD_IMAGE):$(COMMIT_ID)
	docker push $(GCLOUD_IMAGE)
