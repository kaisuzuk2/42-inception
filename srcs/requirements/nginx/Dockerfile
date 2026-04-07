FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl

COPY ./conf/wordpress.conf /etc/nginx/conf.d/wordpress.conf
# RUN rm /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]