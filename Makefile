SHELL := /bin/sh
FLAGS := --non-interactive --color=never
.DEFAULT_GOAL := help

export APP_ROOT ?= $(shell pwd)

EXECUTE_IN_DOCKER = docker compose -f $(APP_ROOT)/docker/docker-compose.yaml run pulumi-service

export STACK ?= dev

-include $(APP_ROOT)/env/override.mk


pulumi-init: # Initialize the pulumi codebase
	@$(EXECUTE_IN_DOCKER) python -m venv venv
	@$(EXECUTE_IN_DOCKER) venv/bin/pip install -r requirements.txt

pulumi-login: # Login into the pulumi 
	@$(EXECUTE_IN_DOCKER) pulumi login file://.
	@$(EXECUTE_IN_DOCKER) pulumi stack init $(STACK) || exit 0

pulumi-preview: pulumi-login # Show preview of the current codebase deployment
	@$(EXECUTE_IN_DOCKER) pulumi preview --diff --stack=$(STACK) $(FLAGS)

pulumi-up: pulumi-login # Deploy the current codebase into cloud
	@$(EXECUTE_IN_DOCKER) pulumi up --skip-preview --stack=$(STACK) $(FLAGS)

pulumi-down: pulumi-login # Destroy the current codebase into cloud
	@$(EXECUTE_IN_DOCKER) pulumi destroy --skip-preview --stack=$(STACK) $(FLAGS)

help: 
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

