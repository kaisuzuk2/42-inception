FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server && \
    rm -rf /var/lib/apt/list/*

RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld

COPY ./tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY ./conf/99-custom.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["mariadbd"]