all: up

up:	
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -f 

fclean: clean
	docker volume prune -f

re: fclean all

.PHONY: all up down clean fclean re