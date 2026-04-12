#!/bin/bash
set -e

source /run/secrets/credentials
DB_PASSWORD=$(cat /run/secrets/db_password)

for var in DOMAIN_NAME WP_TITLE WP_ADMIN_USER WP_ADMIN_PASSWORD WP_ADMIN_EMAIL WP_USER WP_USER_EMAIL WP_USER_PASS; do
    if [ -z "${!var}" ]; then
        echo "[Entrypoint] Error $var is not set"
        exit 1
    fi
done

# until mysqladmin ping -h mariadb -u$DB_USER -p$DB_PASSWORD --silent; do
#     sleep 1
# done

for i in {30..0}; do 
    if mysqladmin ping -h mariadb -u$DB_USER -p$DB_PASSWORD --silent; then
        break
    fi
    sleep 1
done
if [ "$i" = 0 ]; then
    echo "[Entrypoint] Error: Unable to start database."
fi

if [ ! -f "/var/www/html/wp-config.php" ]; then
    wp --path=/var/www/html config create \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_PASSWORD \
        --dbhost=mariadb \
        --allow-root

    wp --path=/var/www/html core install \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    wp --path=/var/www/html user create \
        $WP_USER \
        $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASS \
        --allow-root
fi

exec "$@"