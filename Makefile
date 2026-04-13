all: up

dir:
	mkdir -p /home/kaisuzuk/data/mariadb
	mkdir -p /home/kaisuzuk/data/wordpress

up:	dir
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af 

fclean: clean
	docker compose -f srcs/docker-compose.yml down -v
	docker volume prune -af

re: fclean all

.PHONY: all up down clean fclean re