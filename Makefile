name = inception
ENV = /home/user42/ft_inception/srcs/.env

all: ${ENV}
	@sudo bash srcs/requirements/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml up -d

build: ${ENV}
	@sudo bash srcs/requirements/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml up -d

${ENV}:
	@wget -O /home/user42/ft_inception/srcs/.env https://gist.githubusercontent.com/Vinni-Cedraz/a0aaf45caa14cc8099c8fa9b2e69477f/raw/f646836e4e6b6d91ec89230ae562e448d7a67e4b/.env

down: ${ENV}
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
