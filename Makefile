CONTAINER_NAME ?= app-service
DOCKER_COMPOSE = docker-compose
EXEC = $(DOCKER_COMPOSE) exec $(CONTAINER_NAME)
RUN = $(DOCKER_COMPOSE) run --rm $(CONTAINER_NAME)

GREEN := \033[0;32m
NC := \033[0m

.PHONY: help up down build rebuild logs exec bash shell install clean clean-all

help:
	@echo "Available commands:"
	@echo "  $(GREEN)make up$(NC)          - Start containers"
	@echo "  $(GREEN)make down$(NC)        - Stop and remove containers, networks"
	@echo "  $(GREEN)make stop$(NC)        - Stop containers without removing"
	@echo "  $(GREEN)make build$(NC)       - Build images"
	@echo "  $(GREEN)make rebuild$(NC)     - Rebuild images"
	@echo "  $(GREEN)make logs$(NC)        - View container logs"
	@echo "  $(GREEN)make exec$(NC)        - Execute command in container (usage: make exec cmd='ls -la')"
	@echo "  $(GREEN)make bash$(NC)        - Enter container with bash"
	@echo "  $(GREEN)make shell$(NC)       - Enter container with sh"
	@echo "  $(GREEN)make install$(NC)     - Run composer install in container"
	@echo "  $(GREEN)make clean$(NC)       - Remove containers, networks, volumes, and images"
	@echo ""
	@echo "Variables:"
	@echo "  CONTAINER_NAME - specify container name (default: app)"
	@echo "  Example: CONTAINER_NAME=web make bash"

up:
	@echo "$(GREEN)Starting containers...$(NC)"
	$(DOCKER_COMPOSE) up -d

stop:
	@echo "$(GREEN)Stopping containers...$(NC)"
	$(DOCKER_COMPOSE) stop

down:
	@echo "$(GREEN)Stopping and removing containers, networks...$(NC)"
	$(DOCKER_COMPOSE) down

build:
	@echo "$(GREEN)Building images...$(NC)"
	$(DOCKER_COMPOSE) build

rebuild:
	@echo "$(GREEN)Rebuilding images...$(NC)"
	$(DOCKER_COMPOSE) build --no-cache --pull

logs:
	$(DOCKER_COMPOSE) logs -f $(CONTAINER_NAME)

exec:
ifndef cmd
	@echo "Usage: make exec cmd='your_command'"
	@exit 1
endif
	$(EXEC) $(cmd)

bash:
	$(EXEC) bash

shell:
	$(EXEC) sh

install:
	@echo "$(GREEN)Running composer install...$(NC)"
	$(EXEC) composer install

clean:
	@echo "$(GREEN)Removing containers, networks, volumes, and images...$(NC)"
	$(DOCKER_COMPOSE) down --rmi all --volumes --remove-orphans

clean-all: clean