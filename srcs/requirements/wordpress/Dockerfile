# Usa Debian Buster como base
FROM debian:buster

RUN apt-get update && apt-get install -y \
    curl \
    php-fpm \
    php-mysql \
    unzip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

RUN wp core download --allow-root

COPY /requirements/wordpress/tools/wp-config.php /var/www/html/wp-config.php
COPY /requirements/wordpress/tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 9000

CMD ["/entrypoint.sh"]
