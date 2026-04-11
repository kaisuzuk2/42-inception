all: up

dir:
	mkdir -p ~/data/mariadb
	mkdir -p ~/data/wordpress

up:	dir
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af 

fclean: clean
	docker volume prune -af

re: fclean all

.PHONY: all up down clean fclean re