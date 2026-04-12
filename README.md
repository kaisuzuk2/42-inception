*This project has been created as part of the 42 curriculum by kaisuzuk*

# Description

## Purpose
- Deeply understand Docker and containerization concepts.
- Understand how official Docker images are built and what processes they follow.
- Learn how to configure various services (NGINX, WordPress, MariaDB) from scratch.

## Overview
This infrastructure consists of three Docker containers managed by Docker Compose.

### NGINX
- Web server that accepts HTTPS communication only on port 443
- Supports only TLS1.2/TLS1.3, the only entry point from outside
- Forwards requests to the WordPress container

### WordPress + php-fpm
- Application server combining WordPress CMS and php-fpm
- Processes requests from NGINX with PHP
- Saves data to MariaDB

### MariaDB
- Database server managing WordPress data

# Instructions

## Prerequisites
- Install Docker. Instructions [here](https://docs.docker.com/engine/install/ubuntu/)
- make command must be available

## Prepare the secrets folder

### secrets/db_password.txt
Write the database password.

### secrets/db_root_password.txt
Write the database root password.

### secrets/credentials.txt
WP_ADMIN_USER=admin username (admin is not allowed)
WP_ADMIN_PASSWORD=admin password
WP_ADMIN_EMAIL=admin email address
WP_USER=general user name
WP_USER_EMAIL=general user email address
WP_USER_PASS=general user password


## /etc/hosts Configuration
127.0.0.1 'login'.42.fr

## Start
make

## Stop
- Stop containers: `make down`
- Remove containers and images: `make clean`
- Remove everything including volumes: `make fclean`

## Access
https://'login'.42.fr

# Resources
- [Docker docs](https://docs.docker.com/manuals/)
- [MariaDB document](https://mariadb.com/docs)
- [NGINX document](https://nginx.org/)
- [NGINX config](https://ja.wordpress.org/support/article/nginx/)
- [NGINX conf.d](https://wiki.debian.org/Nginx/DirectoryStructure)
- [WordPress handbook](https://make.wordpress.org/cli/handbook/)
- [php-fpm config](https://zenn.dev/toshi052312/articles/79051f48948d64)
- [SSL/TLS](https://www.youtube.com/watch?v=F3eLZynBDV0)
- [openssl](https://qiita.com/daixque/items/b9432dbf7c344142a72b)

## Books
- [Docker for Developers (Japanese)](https://www.shuwasystem.co.jp/book/9784798071503.html)
- [Docker & Kubernetes Basics (Japanese)](https://book.mynavi.jp/ec/products/detail/id=120304)

## AI
- Checking shell script syntax in each docker-entrypoint.sh
- Checking configuration files
- Used as a discussion partner to deepen understanding
- Translation

# Project Description

## How Docker is Used
This project uses Docker Compose to manage multiple containers.
Each service runs in an independent container and communicates through a Docker network.
- **Dockerfile**: Builds the image for each service
- **Docker Compose**: Manages multiple containers together
- **Named Volume**: Persists data
- **Docker Network**: Manages communication between containers
- **Docker Secrets**: Safely manages sensitive information such as passwords

## Main Design Choices
- **Base Image**: Debian Bullseye (penultimate stable version)
- **TLS**: Uses self-signed certificate to enable HTTPS communication
- **Security**: Passwords managed with Docker Secrets, not included in environment variables
- **Entry Point**: External access only through NGINX port 443
- **Container Isolation**: Each service runs in an independent container

## Virtual Machines vs Docker

### Virtual Machines
- Virtualizes hardware using a hypervisor
- Virtualizes the entire OS including the kernel, consuming large resources
- Takes time to start

### Docker
- Shares the host OS kernel
- Does not have its own kernel, only has the Linux user space
- Consumes fewer resources and starts faster

## Secrets vs Environment Variables

### Environment Variables
- Set in .env file or docker-compose.yml
- Values are visible with docker inspect command
- Accessible from all containers

### Secrets
- Mounted as files in /run/secrets inside the container
- Values are not visible with docker inspect command
- Can be passed only to the containers that need them

## Docker Network vs Host Network

### Host Network
- Container uses the host network directly
- Container and host share the same IP address
- No isolation between containers, security risk

### Docker Network
- Creates an independent virtual network for each container
- Containers can access each other by container name
- Only containers in the same network can communicate

## Docker Volumes vs Bind Mounts

### Bind Mounts
- Mounts a specific host directory to the container
- Host path is specified directly
- Not managed by Docker

### Docker Volumes
- Virtual volumes managed by Docker
- Can be managed with docker volume commands
- Docker manages the storage location on the host
