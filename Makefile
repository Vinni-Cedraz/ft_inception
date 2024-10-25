name = inception
all:
	@sudo bash srcs/requirements/wordpress/tools/make_dir.sh
	@sudo -u vcedraz- -i -- docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@sudo bash srcs/requirements/wordpress/tools/make_dir.sh
	@sudo -u vcedraz- -i -- docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up --build -d

down:
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re: fclean
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
	@sudo rm -rf ~/data/wordpress/*
	@sudo rm -rf ~/data/mariadb/*
