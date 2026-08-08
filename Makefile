COMPOSE_FILE = srcs/docker-compose.yml
ENV_FILE = srcs/.env
COMPOSE = docker compose --env-file $(ENV_FILE) -f $(COMPOSE_FILE)
DATA_DIR = /home/$(USER)/data

.PHONY: all up prepare down clean fclean re

all: up

up: prepare
	$(COMPOSE) up --detach --build

prepare:
	mkdir -p $(DATA_DIR)/mariadb
	mkdir -p $(DATA_DIR)/wordpress

down:
	$(COMPOSE) down

clean: down
	$(COMPOSE) rm -f
	docker system prune -f

fclean: clean
	$(COMPOSE) down --volumes --remove-orphans
	sudo rm -rf $(DATA_DIR)/mariadb
	sudo rm -rf $(DATA_DIR)/wordpress

re: fclean all
