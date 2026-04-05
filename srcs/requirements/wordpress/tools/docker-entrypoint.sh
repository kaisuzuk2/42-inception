#!/bin/bash
set -e

until mysqladmin ping -h mariadb --silent; do
    sleep 1
done

if [ ! -f "/var/www/html/wp-config.php" ]; then

fi