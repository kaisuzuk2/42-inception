# Set up the environment from scratch

## Prerequisites
- Install Docker. Instructions [here](https://docs.docker.com/engine/install/ubuntu/)
- Install make command

## Clone the project
- git clone \<project\> \<name\>
- cd \<name\>

## Prepare the secrets folder
Place the secrets directory at the root and prepare the following files:
- `secrets/db_password.txt`: Write the database user password
- `secrets/db_root_password.txt`: Write the database root password
- `secrets/credentials.txt`: Write the WordPress admin and general user information

### Format of secrets/credentials.txt
- WP_ADMIN_USER=admin username (admin is not allowed)
- WP_ADMIN_PASSWORD=admin password
- WP_ADMIN_EMAIL=admin email address
- WP_USER=general user name
- WP_USER_EMAIL=general user email address
- WP_USER_PASS=general user password

## /etc/hosts Configuration

127.0.0.1 'login'.42.fr

# Build and launch the project using the Makefile and Docker Compose.

## Start
make <br>

The following processes are executed:
1. Create data directories (~/data/mariadb, ~/data/wordpress)
2. Build Docker images
3. Start containers

## Stop
- `make down`: Stop containers
- `make clean`: Remove containers, images, and unused data
- `make fclean`: Remove everything including unused Named Volumes

# Manage the containers and volumes

## Container Management

### Check container status
docker ps

### Check container logs
docker compose -f srcs/docker-compose.yml logs

### Check logs for a specific container
- docker compose -f srcs/docker-compose.yml logs nginx
- docker compose -f srcs/docker-compose.yml logs wordpress
- docker compose -f srcs/docker-compose.yml logs mariadb

### Enter a container
- docker exec -it nginx bash
- docker exec -it wordpress bash
- docker exec -it mariadb bash

### Check container details
- docker inspect nginx
- docker inspect wordpress
- docker inspect mariadb

## Volume Management

### List volumes
docker volume ls

### Check volume details
- docker volume inspect srcs_mariadb_data
- docker volume inspect srcs_wordpress_data

## Network Management

### List networks
docker network ls

### Check network details
docker network inspect srcs_inception

# Data Management

## Data Storage Location
| Service | Path in Container | Path on Host |
|---------|------------------|--------------|
| MariaDB | /var/lib/mysql | ~/data/mariadb |
| WordPress | /var/www/html | ~/data/wordpress |

## Data Persistence
- Data is persisted using Named Volumes
- Data is retained even if containers are stopped or removed