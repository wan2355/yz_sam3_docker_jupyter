## 260306 Makefile for SAM docker
COMPOSE=docker compose -f docker-compose.yml
CONTAINER=sam3

.PHONY: help build up upd down restart logs ps bash jupyter clean prune reset

help:
	@echo "make build   : build Docker image"
	@echo "make up      : run foreground"
	@echo "make upd     : run background"
	@echo "make down    : stop container"
	@echo "make restart : restart container"
	@echo "make logs    : follow compose logs"
	@echo "make ps      : container status"
	@echo "make bash    : login bash"
	@echo "make zsh     : login zsh"
	@echo "make jupyter : sam3 container logs"
	@echo "make network : docker network list"
	@echo "make prune   : delete unused network"
	@echo "make clean   : stop container + network prune"
#	@echo "make reset   : stop + del orphan + network prune"

build:
	$(COMPOSE) build

up:
	$(COMPOSE) up

upd:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

restart:
	$(COMPOSE) down
	$(COMPOSE) up -d

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

bash:
	docker exec -it $(CONTAINER) bash

zsh:
	docker exec -it $(CONTAINER) zsh

jupyter:
	docker logs -f $(CONTAINER)

network:
	docker network ls

prune:
	docker network prune -f

clean:
	$(COMPOSE) down
	docker network prune -f

#reset:
#	$(COMPOSE) down --remove-orphans
#	docker network prune -f
