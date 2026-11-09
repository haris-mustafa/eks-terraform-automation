ENV          ?= dev
BOOTSTRAP    := bootstrap
INFRA        := infra
BUCKET       = $(shell terraform -chdir=$(BOOTSTRAP) output -raw state_bucket_name)
APPROVE_FLAG = $(if $(AUTO_APPROVE),-auto-approve,)

.PHONY: bootstrap init fmt validate plan apply destroy kubeconfig test-nodes help

help:
	@echo "make bootstrap              Create S3 bucket + DynamoDB lock table (once)"
	@echo "make init ENV=dev|prod      Init Terraform with the remote backend"
	@echo "make plan|apply|destroy ENV=dev|prod"
	@echo "make kubeconfig ENV=dev     Configure kubectl for the cluster"
	@echo "make test-nodes             kubectl get nodes + system pods"

bootstrap:
	terraform -chdir=$(BOOTSTRAP) init
	terraform -chdir=$(BOOTSTRAP) apply $(APPROVE_FLAG)

init:
	terraform -chdir=$(INFRA) init -reconfigure \
		-backend-config=envs/$(ENV).backend.hcl \
		-backend-config="bucket=$(BUCKET)"

fmt:
	terraform fmt -recursive

validate: init
	terraform -chdir=$(INFRA) validate

plan: init
	terraform -chdir=$(INFRA) plan -var-file=envs/$(ENV).tfvars

apply: init
	terraform -chdir=$(INFRA) apply -var-file=envs/$(ENV).tfvars $(APPROVE_FLAG)

destroy: init
	terraform -chdir=$(INFRA) destroy -var-file=envs/$(ENV).tfvars $(APPROVE_FLAG)

kubeconfig:
	$$(terraform -chdir=$(INFRA) output -raw update_kubeconfig_command)

test-nodes:
	kubectl get nodes -o wide
	kubectl get pods -n kube-system
