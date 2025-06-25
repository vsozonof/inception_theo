.PHONY: all build up down restart logs clean

all: up

build:
	docker compose -f docker-compose.yml build

up:
	docker compose -f docker-compose.yml up -d

down:
	docker compose -f docker-compose.yml down

restart: down up

logs:
	docker compose -f docker-compose.yml logs -f

clean: down
	docker compose -f docker-compose.yml down -v --remove-orphans

ps:
	docker compose -f docker-compose.yml ps

exec-wp:
	docker exec -it wordpress /bin/bash

exec-nginx:
	docker exec -it nginx /bin/bash

exec-mariadb:
	docker exec -it mariadb /bin/bash