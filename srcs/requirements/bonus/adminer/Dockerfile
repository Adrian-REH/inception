# Usa Debian Buster como base
FROM debian:buster

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/adminer

#RUN sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf
WORKDIR /var/www/adminer

RUN mkdir -p /run/php
RUN chown -R www-data:www-data /var/www/adminer \
    && chmod -R 755 /var/www/adminer


COPY /requirements/bonus/adminer/tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 9090

CMD ["/entrypoint.sh"]

