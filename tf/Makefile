COMMIT_ID:=$(shell git rev-parse --short HEAD)
SSH_OPTS=-o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no"
TF_VARS:=-var="image_tag=$(COMMIT_ID)" -var="gcloud_access_token=$(shell gcloud auth print-access-token)"

.terraform:
	terraform init

.PHONY: up
up: .terraform
	terraform apply $(TF_VARS)

.PHONY: down
down: .terraform
	terraform destroy $(TF_VARS)
