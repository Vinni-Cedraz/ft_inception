name = inception
login = vcedraz-
all:
	@sudo bash srcs/requirements/tools/make_dir.sh
	@sudo bash srcs/requirements/tools/ufw_settings.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
	@bash srcs/requirements/tools/make_dir.sh
	@sudo bash srcs/requirements/tools/ufw_settings.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

clean: down
	@sudo ufw --force reset
	@docker system prune -a
	@sudo rm -rf /home/${login}/data/wordpress/*
	@sudo rm -rf /home/${login}/data/mariadb/*

re: clean
	@make build

fclean:
	@sudo ufw --force reset
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf /home/${login}/data/wordpress/*
	@sudo rm -rf /home/${login}/data/mariadb/*
