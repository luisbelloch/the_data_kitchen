COMMIT_ID:=$(shell git rev-parse --short HEAD)
DOCKER_IMAGE:=luisbelloch/kitchen
GCLOUD_IMAGE:=us-east1-docker.pkg.dev/bigdataupv2022/deploydocus/$(DOCKER_IMAGE)

.PHONY: build
build:
	DOCKER_CLI_HINTS=false docker build -t $(DOCKER_IMAGE):$(COMMIT_ID) .
	docker tag $(DOCKER_IMAGE):$(COMMIT_ID) $(GCLOUD_IMAGE):$(COMMIT_ID)
	docker tag $(DOCKER_IMAGE):$(COMMIT_ID) $(GCLOUD_IMAGE)

.PHONY: login
login:
	docker login -u oauth2accesstoken -p "$(shell gcloud auth print-access-token)" https://us-east1-docker.pkg.dev

.PHONY: push
push: build
	docker push $(GCLOUD_IMAGE):$(COMMIT_ID)
	docker push $(GCLOUD_IMAGE)
