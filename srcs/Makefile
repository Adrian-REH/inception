DOCKER_COMPOSE = docker compose

all: build up

build:
	$(DOCKER_COMPOSE) build

build-%:
	$(DOCKER_COMPOSE) build $*

up:
	$(DOCKER_COMPOSE) up -d

up-%:
	$(DOCKER_COMPOSE) up $* -d

down:
	$(DOCKER_COMPOSE) down

down-%:
	$(DOCKER_COMPOSE) down $*

fclean:
	$(DOCKER_COMPOSE) down --volumes --remove-orphans --rmi all


logs-%:
	$(DOCKER_COMPOSE) logs $*


.PHONY: all build up down logs fclean