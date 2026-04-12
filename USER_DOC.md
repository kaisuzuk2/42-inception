# Understand what services are provided by the stack.

## NGINX
- Web server that accepts HTTPS communication on port 443
- Supports only TLS1.2/TLS1.3, the only entry point from outside
- Forwards requests to the WordPress container

## WordPress + php-fpm
- Executes PHP using php-fpm to dynamically generate web pages
- Manages articles, user information, and settings in the MariaDB database
- Content can be created and edited from the administration panel

## MariaDB
- Database that manages WordPress data
- Uses Named Volumes to persist data

# Start and Stop - Start and stop the project.

## Start
make

## Stop
- Stop containers: `make down`
- Remove containers, images, and unused data: `make clean`
- Remove everything including unused Named Volumes: `make fclean`

# Access the website and the administration panel.

## Website
https://kaisuzuk.42.fr

## Administration Panel
https://kaisuzuk.42.fr/wp-admin

# Locate and manage credentials.

## Location
Credentials are managed in the following files:
- Database user password: `secrets/db_password.txt`
- Database root password: `secrets/db_root_password.txt`
- WordPress admin and general user information: `secrets/credentials.txt`

## How to Change Credentials
1. Edit the target file
2. Restart the containers

# Check that the services are running correctly.

## Container Status
docker ps <br>
If all containers are in the `Up` state, they are running correctly.

## Log Check

docker compose -f srcs/docker-compose.yml logs

### Check logs for a specific container
- docker compose -f srcs/docker-compose.yml logs wordpress
- docker compose -f srcs/docker-compose.yml logs nginx
- docker compose -f srcs/docker-compose.yml logs mariadb
