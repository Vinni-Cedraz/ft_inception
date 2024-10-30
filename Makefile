name = inception

all:
	@sudo bash srcs/requirements/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml up -d

build:
	@sudo bash srcs/requirements/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re: down
	@make build

clean: down
	@docker system prune -a
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*

fclean:
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf /home/vcedraz-
	@docker volume rm srcs_db-volume
	@docker volume rm srcs_wp-volume
