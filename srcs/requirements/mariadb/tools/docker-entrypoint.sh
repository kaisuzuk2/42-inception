#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

if [ -z "$MYSQL_NAME" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    echo "[Entrypoint] Error: Required environment variables are not set"
    exit 1
fi

if [ ! -d "/var/lib/mysql/$MYSQL_NAME" ]; then
    "$@" --skip-networking &
    MARIADB_PID=$!

    # until mysqladmin ping --silent; do
    #     sleep 1
    # done

    for i in {30..0}; do
        if mysqladmin ping --silent; then
            break
        fi
        sleep 1
    done
    if [ "$i" = 0 ]; then
        echo "[Entrypoint] Error: Unable to start server."
        exit 1
    fi

    mariadb -u root <<-EOF
        CREATE DATABASE $MYSQL_NAME;
        ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
        CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
        GRANT ALL PRIVILEGES ON $MYSQL_NAME.* TO '$MYSQL_USER'@'%';
        FLUSH PRIVILEGES;
EOF

    kill $MARIADB_PID
    wait $MARIADB_PID

fi

exec "$@"